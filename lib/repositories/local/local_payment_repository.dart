import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../payment_repository.dart';

class LocalPaymentRepository implements PaymentRepository {
  LocalPaymentRepository(this._db);
  final AppDatabase _db;

  Future<Account> _account(int id) =>
      (_db.select(_db.accounts)..where((a) => a.id.equals(id))).getSingle();

  Future<void> _addBalance(int accountId, int delta) => _db.customUpdate(
        'UPDATE accounts SET balance = balance + ? WHERE id = ?',
        variables: [Variable.withInt(delta), Variable.withInt(accountId)],
        updates: {_db.accounts},
      );

  @override
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
    String? description,
  }) =>
      _db.transaction(() async {
        final from = await _account(fromAccountId);
        final to = await _account(toAccountId);
        if (from.currency != to.currency) {
          throw StateError('Для разных валют используйте обмен валюты');
        }
        if (from.balance < amount) throw StateError('Недостаточно средств');
        await _addBalance(fromAccountId, -amount);
        await _addBalance(toAccountId, amount);
        await _db.into(_db.transactions).insert(TransactionsCompanion.insert(
              type: from.clientId == to.clientId
                  ? TransactionType.transferOwn
                  : TransactionType.transferInternal,
              fromAccountId: Value(fromAccountId),
              toAccountId: Value(toAccountId),
              amount: amount,
              currency: from.currency,
              description: Value(description),
            ));
      });

  @override
  Future<void> exchangeCurrency({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
  }) =>
      _db.transaction(() async {
        final from = await _account(fromAccountId);
        final to = await _account(toAccountId);
        if (from.currency == to.currency) throw StateError('Валюты совпадают');
        if (from.balance < amount) throw StateError('Недостаточно средств');

        final direct = await (_db.select(_db.exchangeRates)
              ..where((r) =>
                  r.baseCurrency.equals(from.currency.index) &
                  r.quoteCurrency.equals(to.currency.index)))
            .getSingleOrNull();

        int rateX10000;
        int converted;
        if (direct != null) {
          // Клиент отдаёт base, получает quote по курсу покупки банком.
          rateX10000 = direct.buyRateX10000;
          converted = amount * rateX10000 ~/ 10000;
        } else {
          final inverse = await (_db.select(_db.exchangeRates)
                ..where((r) =>
                    r.baseCurrency.equals(to.currency.index) &
                    r.quoteCurrency.equals(from.currency.index)))
              .getSingleOrNull();
          if (inverse == null) throw StateError('Курс не найден');
          // Клиент отдаёт quote, получает base по курсу продажи банком.
          rateX10000 = inverse.sellRateX10000;
          converted = amount * 10000 ~/ rateX10000;
        }

        await _addBalance(fromAccountId, -amount);
        await _addBalance(toAccountId, converted);
        await _db.into(_db.transactions).insert(TransactionsCompanion.insert(
              type: TransactionType.exchange,
              fromAccountId: Value(fromAccountId),
              toAccountId: Value(toAccountId),
              amount: amount,
              currency: from.currency,
              convertedAmount: Value(converted),
              appliedRateX10000: Value(rateX10000),
            ));
      });
}
