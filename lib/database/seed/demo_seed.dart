import 'package:drift/drift.dart';

import '../app_database.dart';

/// Тестовые данные для разработки и проверки системы.
/// Суммы — в копейках/центах. Все пароли демо-пользователей: см. [demoPasswordHash].
///
/// ВАЖНО: подставьте сюда то же хэширование, которое использует экран входа,
/// иначе войти под демо-пользователями не получится.
/// it's a 1234 password
const demoPasswordHash = r'$2a$10$l3l/bvpEugxbAeblyHgi/.Kr.iR6tEiR.VqlsOSFdP22ERiQ3PFRy';

int _n = 0;
String _digits(int length) {
  // Детерминированный «номер»: одни и те же данные при каждом запуске.
  _n++;
  return (4000000000000000 + _n * 7919).toString().padLeft(length, '0').substring(0, length);
}

Future<void> insertDemoData(AppDatabase db) => db.transaction(() async {
      _n = 0;

      // ── Сотрудники ──
      Future<int> employee(String login, String name, String position) async {
        final userId = await db.into(db.users).insert(UsersCompanion.insert(
              login: login,
              passwordHash: demoPasswordHash,
              role: UserRole.employee,
            ));
        return db.into(db.employees).insert(EmployeesCompanion.insert(
              userId: userId,
              fullName: name,
              position: position,
            ));
      }

      final manager = await employee('manager', 'Петрова Анна Сергеевна', 'Менеджер');
      await employee('operator', 'Смирнов Иван Павлович', 'Операционист');

      // ── Клиенты ──
      Future<int> client(String login, String name, String phone) async {
        final userId = await db.into(db.users).insert(UsersCompanion.insert(
              login: login,
              passwordHash: demoPasswordHash,
              role: UserRole.client,
            ));
        return db.into(db.clients).insert(ClientsCompanion.insert(
              userId: userId,
              fullName: name,
              phone: Value(phone),
              email: Value('$login@example.com'),
            ));
      }

      final ivan = await client('ivan', 'Иванов Иван Иванович', '+79001112233');
      final maria = await client('maria', 'Сидорова Мария Олеговна', '+79004445566');
      final oleg = await client('oleg', 'Кузнецов Олег Дмитриевич', '+79007778899');

      // ── Счета ──
      Future<int> account(int clientId, Currency cur, int balance,
              {AccountType type = AccountType.current}) =>
          db.into(db.accounts).insert(AccountsCompanion.insert(
                clientId: clientId,
                number: _digits(20),
                type: type,
                currency: cur,
                balance: Value(balance),
              ));

      final ivanRub = await account(ivan, Currency.rub, 15000000); // 150 000,00 ₽
      final ivanUsd = await account(ivan, Currency.usd, 100000); // 1 000,00 $
      final mariaRub = await account(maria, Currency.rub, 4250050); // 42 500,50 ₽
      final olegRub = await account(oleg, Currency.rub, 500000); // 5 000,00 ₽
      final olegLoan = await account(oleg, Currency.rub, 30000000,
          type: AccountType.loan); // кредитный счёт

      // ── Карты ──
      Future<void> card(int accId, String holder, CardStatus st) =>
          db.into(db.bankCards).insert(BankCardsCompanion.insert(
                accountId: accId,
                number: Value(st == CardStatus.requested ? null : _digits(16)),
                holderName: holder,
                status: Value(st),
                expiresAt: Value(st == CardStatus.requested
                    ? null
                    : DateTime(DateTime.now().year + 4, 12, 31)),
              ));
      await card(ivanRub, 'IVAN IVANOV', CardStatus.active);
      await card(mariaRub, 'MARIA SIDOROVA', CardStatus.active);
      await card(mariaRub, 'MARIA SIDOROVA', CardStatus.blocked);
      await card(olegRub, 'OLEG KUZNETSOV', CardStatus.requested);

      // ── Вклады ──
      await db.into(db.deposits).insert(DepositsCompanion.insert(
            clientId: ivan,
            accountId: Value(ivanRub),
            amount: 5000000,
            currency: Currency.rub,
            termMonths: 12,
            ratePercentX100: const Value(1050),
            status: Value(DepositStatus.open),
            openedAt: Value(DateTime.now().subtract(const Duration(days: 60))),
          ));
      await db.into(db.deposits).insert(DepositsCompanion.insert(
            clientId: maria,
            amount: 1000000,
            currency: Currency.rub,
            termMonths: 6,
          )); // заявка

      // ── Кредиты: одобренный, ожидающий решения и отклонённый ──
      final approvedApp = await db.into(db.loanApplications).insert(
            LoanApplicationsCompanion.insert(
              clientId: oleg,
              createdByEmployeeId: manager,
              amount: 30000000,
              currency: Currency.rub,
              termMonths: 24,
              status: Value(LoanApplicationStatus.approved),
              decidedByEmployeeId: Value(manager),
              decidedAt: Value(DateTime.now().subtract(const Duration(days: 30))),
            ),
          );
      await db.into(db.loans).insert(LoansCompanion.insert(
            applicationId: approvedApp,
            accountId: olegLoan,
            principal: 30000000,
            remaining: 28000000,
            ratePercentX100: 1450,
          ));
      await db.into(db.loanApplications).insert(LoanApplicationsCompanion.insert(
            clientId: ivan,
            createdByEmployeeId: manager,
            amount: 10000000,
            currency: Currency.rub,
            termMonths: 12,
          )); // ожидает решения
      await db.into(db.loanApplications).insert(LoanApplicationsCompanion.insert(
            clientId: maria,
            createdByEmployeeId: manager,
            amount: 90000000,
            currency: Currency.rub,
            termMonths: 36,
            status: Value(LoanApplicationStatus.rejected),
            rejectReason: const Value('Недостаточный доход'),
            decidedByEmployeeId: Value(manager),
            decidedAt: Value(DateTime.now().subtract(const Duration(days: 5))),
          ));

      // ── История операций (пакетной вставкой) ──
      final now = DateTime.now();
      await db.batch((b) {
        b.insertAll(db.transactions, [
          TransactionsCompanion.insert(
            type: TransactionType.transferInternal,
            fromAccountId: Value(ivanRub),
            toAccountId: Value(mariaRub),
            amount: 150000,
            currency: Currency.rub,
            description: const Value('Возврат долга'),
            createdAt: Value(now.subtract(const Duration(days: 10))),
          ),
          TransactionsCompanion.insert(
            type: TransactionType.exchange,
            fromAccountId: Value(ivanRub),
            toAccountId: Value(ivanUsd),
            amount: 9200000,
            currency: Currency.rub,
            convertedAmount: const Value(100000),
            appliedRateX10000: const Value(920000),
            createdAt: Value(now.subtract(const Duration(days: 7))),
          ),
          TransactionsCompanion.insert(
            type: TransactionType.loanPayment,
            fromAccountId: Value(olegRub),
            amount: 2000000,
            currency: Currency.rub,
            createdAt: Value(now.subtract(const Duration(days: 2))),
          ),
        ]);
      });
    });
