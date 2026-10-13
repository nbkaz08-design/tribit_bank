import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/enums.dart';
import 'tables/tables.dart';

export 'tables/enums.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Users,
  Clients,
  Employees,
  Accounts,
  BankCards,
  ExchangeRates,
  Transactions,
  Deposits,
  LoanApplications,
  Loans,
  LoanPayments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'tribit_bank'));

  /// Для тестов: `AppDatabase(NativeDatabase.memory())`.

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedExchangeRates();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  Future<void> _seedExchangeRates() async {
    // Стартовые внутренние курсы (×10000), далее обновляются сотрудниками/сервером.
    Future<void> add(Currency b, Currency q, int buy, int sell) =>
        into(exchangeRates).insert(ExchangeRatesCompanion.insert(
          baseCurrency: b,
          quoteCurrency: q,
          buyRateX10000: buy,
          sellRateX10000: sell,
        ));
    await add(Currency.usd, Currency.rub, 920000, 940000);
    await add(Currency.eur, Currency.rub, 1000000, 1020000);
    await add(Currency.eur, Currency.usd, 10800, 11000);
  }

  // ───────────────────────── Клиент ─────────────────────────

  /// Регистрация и авторизация: регистрация клиента.
  Future<int> registerClient({
    required String login,
    required String passwordHash,
    required String fullName,
    String? phone,
    String? email,
  }) =>
      transaction(() async {
        final userId = await into(users).insert(UsersCompanion.insert(
          login: login,
          passwordHash: passwordHash,
          role: UserRole.client,
        ));
        return into(clients).insert(ClientsCompanion.insert(
          userId: userId,
          fullName: fullName,
          phone: Value(phone),
          email: Value(email),
        ));
      });

  /// Авторизация: вернуть пользователя при совпадении логина и хэша.
  Future<User?> authorize(String login, String passwordHash) =>
      (select(users)
            ..where((u) =>
                u.login.equals(login) &
                u.passwordHash.equals(passwordHash) &
                u.isActive.equals(true)))
          .getSingleOrNull();

  /// Просмотр баланса.
  Future<int?> balanceOf(int accountId) async =>
      (await (select(accounts)..where((a) => a.id.equals(accountId))).getSingleOrNull())
          ?.balance;

  Stream<List<Account>> watchAccounts(int clientId) =>
      (select(accounts)..where((a) => a.clientId.equals(clientId))).watch();

  /// Просмотр истории операций по счёту (новые сверху).
  Stream<List<Transaction>> watchHistory(int accountId) =>
      (select(transactions)
            ..where((t) =>
                t.fromAccountId.equals(accountId) | t.toAccountId.equals(accountId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  /// Просмотр курса валют.
  Stream<List<ExchangeRate>> watchRates() => select(exchangeRates).watch();

  /// Перевод (между своими счетами или другому клиенту банка, одна валюта).
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
    String? description,
  }) =>
      transaction(() async {
        final from = await _account(fromAccountId);
        final to = await _account(toAccountId);
        if (from.currency != to.currency) {
          throw StateError('Для разных валют используйте обмен валюты');
        }
        if (from.balance < amount) throw StateError('Недостаточно средств');
        await _addBalance(fromAccountId, -amount);
        await _addBalance(toAccountId, amount);
        await into(transactions).insert(TransactionsCompanion.insert(
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

  /// Обмен валюты по внутреннему курсу банка.
  /// Курс берётся из ExchangeRates: клиент покупает валюту по sellRate банка,
  /// продаёт — по buyRate.
  Future<void> exchangeCurrency({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
  }) =>
      transaction(() async {
        final from = await _account(fromAccountId);
        final to = await _account(toAccountId);
        if (from.currency == to.currency) throw StateError('Валюты совпадают');
        if (from.balance < amount) throw StateError('Недостаточно средств');

        // Ищем прямую пару (from→to) или обратную (to→from).
        final direct = await (select(exchangeRates)
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
          final inverse = await (select(exchangeRates)
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
        await into(transactions).insert(TransactionsCompanion.insert(
          type: TransactionType.exchange,
          fromAccountId: Value(fromAccountId),
          toAccountId: Value(toAccountId),
          amount: amount,
          currency: from.currency,
          convertedAmount: Value(converted),
          appliedRateX10000: Value(rateX10000),
        ));
      });

  /// Открытие вклада: заявка (status = requested).
  Future<int> requestDeposit({
    required int clientId,
    required int amount,
    required Currency currency,
    required int termMonths,
  }) =>
      into(deposits).insert(DepositsCompanion.insert(
        clientId: clientId,
        amount: amount,
        currency: currency,
        termMonths: termMonths,
      ));

  /// Оформление карты: заявка на выпуск.
  Future<int> requestCard({required int accountId, required String holderName}) =>
      into(bankCards).insert(
          BankCardsCompanion.insert(accountId: accountId, holderName: holderName));

  /// Блокировка карты.
  Future<void> blockCard(int cardId, {String? reason}) =>
      (update(bankCards)..where((c) => c.id.equals(cardId))).write(
        BankCardsCompanion(
          status: const Value(CardStatus.blocked),
          blockedAt: Value(DateTime.now()),
          blockReason: Value(reason),
        ),
      );

  // ───────────────────────── Сотрудник ─────────────────────────

  /// Просмотр информации по счетам клиента.
  Future<List<Account>> accountsOfClient(int clientId) =>
      (select(accounts)..where((a) => a.clientId.equals(clientId))).get();

  /// Заявка на кредит.
  Future<int> createLoanApplication({
    required int clientId,
    required int employeeId,
    required int amount,
    required Currency currency,
    required int termMonths,
  }) =>
      into(loanApplications).insert(LoanApplicationsCompanion.insert(
        clientId: clientId,
        createdByEmployeeId: employeeId,
        amount: amount,
        currency: currency,
        termMonths: termMonths,
      ));

  /// Одобрение кредита: заявка → approved, создаётся кредит и зачисляются средства.
  Future<int> approveLoan({
    required int applicationId,
    required int employeeId,
    required int creditAccountId,
    required int ratePercentX100,
  }) =>
      transaction(() async {
        final app = await (select(loanApplications)
              ..where((a) => a.id.equals(applicationId)))
            .getSingle();
        if (app.status != LoanApplicationStatus.pending) {
          throw StateError('Заявка уже рассмотрена');
        }
        await (update(loanApplications)..where((a) => a.id.equals(applicationId)))
            .write(LoanApplicationsCompanion(
          status: const Value(LoanApplicationStatus.approved),
          decidedByEmployeeId: Value(employeeId),
          decidedAt: Value(DateTime.now()),
        ));
        await _addBalance(creditAccountId, app.amount);
        await into(transactions).insert(TransactionsCompanion.insert(
          type: TransactionType.loanIssue,
          toAccountId: Value(creditAccountId),
          amount: app.amount,
          currency: app.currency,
        ));
        return into(loans).insert(LoansCompanion.insert(
          applicationId: applicationId,
          accountId: creditAccountId,
          principal: app.amount,
          remaining: app.amount,
          ratePercentX100: ratePercentX100,
        ));
      });

  /// Отклонение кредита с причиной отказа.
  Future<void> rejectLoan({
    required int applicationId,
    required int employeeId,
    String? reason,
  }) =>
      (update(loanApplications)
            ..where((a) =>
                a.id.equals(applicationId) &
                a.status.equals(LoanApplicationStatus.pending.index)))
          .write(LoanApplicationsCompanion(
        status: const Value(LoanApplicationStatus.rejected),
        decidedByEmployeeId: Value(employeeId),
        decidedAt: Value(DateTime.now()),
        rejectReason: Value(reason),
      ));

  /// Оплата кредита (наличные через кассу или безналичный платёж).
  /// Для безналичного способа укажите [fromAccountId], с которого спишутся средства.
  Future<void> payLoan({
    required int loanId,
    required int employeeId,
    required int amount,
    required PaymentMethod method,
    int? fromAccountId,
  }) =>
      transaction(() async {
        final loan = await (select(loans)..where((l) => l.id.equals(loanId))).getSingle();
        if (amount > loan.remaining) throw StateError('Сумма больше задолженности');
        final acc = await _account(loan.accountId);
        if (method == PaymentMethod.cashless) {
          if (fromAccountId == null) throw ArgumentError('Нужен счёт списания');
          final src = await _account(fromAccountId);
          if (src.balance < amount) throw StateError('Недостаточно средств');
          await _addBalance(fromAccountId, -amount);
        }
        final left = loan.remaining - amount;
        await (update(loans)..where((l) => l.id.equals(loanId))).write(LoansCompanion(
          remaining: Value(left),
          status: Value(left == 0 ? LoanStatus.paidOff : LoanStatus.active),
        ));
        await into(loanPayments).insert(LoanPaymentsCompanion.insert(
          loanId: loanId,
          employeeId: employeeId,
          amount: amount,
          method: method,
        ));
        await into(transactions).insert(TransactionsCompanion.insert(
          type: TransactionType.loanPayment,
          fromAccountId: Value(fromAccountId),
          amount: amount,
          currency: acc.currency,
        ));
      });

  // ───────────────────────── Внутренние ─────────────────────────

  Future<Account> _account(int id) =>
      (select(accounts)..where((a) => a.id.equals(id))).getSingle();

  Future<void> _addBalance(int accountId, int delta) => customUpdate(
        'UPDATE accounts SET balance = balance + ? WHERE id = ?',
        variables: [Variable.withInt(delta), Variable.withInt(accountId)],
        updates: {accounts},
      );
}
