import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../card_repository.dart';

class LocalCardRepository implements CardRepository {
  LocalCardRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<BankCard>> watchCards(int clientId) {
    // Карты клиента = карты, привязанные к его счетам.
    final query = _db.select(_db.bankCards).join([
      innerJoin(_db.accounts, _db.accounts.id.equalsExp(_db.bankCards.accountId)),
    ])
      ..where(_db.accounts.clientId.equals(clientId));
    return query.watch().map(
        (rows) => rows.map((r) => r.readTable(_db.bankCards)).toList());
  }

  @override
  Future<int> requestCard({required int accountId, required String holderName}) =>
      _db.into(_db.bankCards).insert(
          BankCardsCompanion.insert(accountId: accountId, holderName: holderName));

  @override
  Future<void> blockCard(int cardId, {String? reason}) =>
      (_db.update(_db.bankCards)..where((c) => c.id.equals(cardId))).write(
        BankCardsCompanion(
          status: const Value(CardStatus.blocked),
          blockedAt: Value(DateTime.now()),
          blockReason: Value(reason),
        ),
      );
}
