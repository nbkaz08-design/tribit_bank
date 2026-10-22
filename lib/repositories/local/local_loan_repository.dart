import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../loan_repository.dart';

class LocalLoanRepository implements LoanRepository {
  LocalLoanRepository(this._db);
  final AppDatabase _db;

  Future<void> _addBalance(int accountId, int delta) => _db.customUpdate(
        'UPDATE accounts SET balance = balance + ? WHERE id = ?',
        variables: [Variable.withInt(delta), Variable.withInt(accountId)],
        updates: {_db.accounts},
      );

  @override
  Stream<List<LoanApplication>> watchPendingApplications() =>
      (_db.select(_db.loanApplications)
            ..where((a) => a.status.equals(LoanApplicationStatus.pending.index))
            ..orderBy([(a) => OrderingTerm.desc(a.createdAt)]))
          .watch();

  @override
  Stream<List<Loan>> watchLoans(int clientId) {
    final query = _db.select(_db.loans).join([
      innerJoin(_db.accounts, _db.accounts.id.equalsExp(_db.loans.accountId)),
    ])
      ..where(_db.accounts.clientId.equals(clientId));
    return query
        .watch()
        .map((rows) => rows.map((r) => r.readTable(_db.loans)).toList());
  }

  @override
  Future<int> createApplication({
    required int clientId,
    required int employeeId,
    required int amount,
    required Currency currency,
    required int termMonths,
  }) =>
      _db.into(_db.loanApplications).insert(LoanApplicationsCompanion.insert(
            clientId: clientId,
            createdByEmployeeId: employeeId,
            amount: amount,
            currency: currency,
            termMonths: termMonths,
          ));

  @override
  Future<int> approve({
    required int applicationId,
    required int employeeId,
    required int creditAccountId,
    required int ratePercentX100,
  }) =>
      _db.transaction(() async {
        final app = await (_db.select(_db.loanApplications)
              ..where((a) => a.id.equals(applicationId)))
            .getSingle();
        if (app.status != LoanApplicationStatus.pending) {
          throw StateError('Заявка уже рассмотрена');
        }
        await (_db.update(_db.loanApplications)
              ..where((a) => a.id.equals(applicationId)))
            .write(LoanApplicationsCompanion(
          status: const Value(LoanApplicationStatus.approved),
          decidedByEmployeeId: Value(employeeId),
          decidedAt: Value(DateTime.now()),
        ));
        await _addBalance(creditAccountId, app.amount);
        await _db.into(_db.transactions).insert(TransactionsCompanion.insert(
              type: TransactionType.loanIssue,
              toAccountId: Value(creditAccountId),
              amount: app.amount,
              currency: app.currency,
            ));
        return _db.into(_db.loans).insert(LoansCompanion.insert(
              applicationId: applicationId,
              accountId: creditAccountId,
              principal: app.amount,
              remaining: app.amount,
              ratePercentX100: ratePercentX100,
            ));
      });

  @override
  Future<void> reject({
    required int applicationId,
    required int employeeId,
    String? reason,
  }) =>
      (_db.update(_db.loanApplications)
            ..where((a) =>
                a.id.equals(applicationId) &
                a.status.equals(LoanApplicationStatus.pending.index)))
          .write(LoanApplicationsCompanion(
        status: const Value(LoanApplicationStatus.rejected),
        decidedByEmployeeId: Value(employeeId),
        decidedAt: Value(DateTime.now()),
        rejectReason: Value(reason),
      ));

  @override
  Future<void> pay({
    required int loanId,
    required int employeeId,
    required int amount,
    required PaymentMethod method,
    int? fromAccountId,
  }) =>
      _db.transaction(() async {
        final loan = await (_db.select(_db.loans)
              ..where((l) => l.id.equals(loanId)))
            .getSingle();
        if (amount > loan.remaining) {
          throw StateError('Сумма больше задолженности');
        }
        final loanAcc = await (_db.select(_db.accounts)
              ..where((a) => a.id.equals(loan.accountId)))
            .getSingle();

        if (method == PaymentMethod.cashless) {
          if (fromAccountId == null) throw ArgumentError('Нужен счёт списания');
          final src = await (_db.select(_db.accounts)
                ..where((a) => a.id.equals(fromAccountId)))
              .getSingle();
          if (src.balance < amount) throw StateError('Недостаточно средств');
          await _addBalance(fromAccountId, -amount);
        }

        final left = loan.remaining - amount;
        await (_db.update(_db.loans)..where((l) => l.id.equals(loanId))).write(
          LoansCompanion(
            remaining: Value(left),
            status: Value(left == 0 ? LoanStatus.paidOff : LoanStatus.active),
          ),
        );
        await _db.into(_db.loanPayments).insert(LoanPaymentsCompanion.insert(
              loanId: loanId,
              employeeId: employeeId,
              amount: amount,
              method: method,
            ));
        await _db.into(_db.transactions).insert(TransactionsCompanion.insert(
              type: TransactionType.loanPayment,
              fromAccountId: Value(fromAccountId),
              amount: amount,
              currency: loanAcc.currency,
            ));
      });
}
