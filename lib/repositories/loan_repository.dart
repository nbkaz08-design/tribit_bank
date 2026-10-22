import '../database/app_database.dart';

/// Кредиты (работа сотрудника).
abstract class LoanRepository {
  Stream<List<LoanApplication>> watchPendingApplications();
  Stream<List<Loan>> watchLoans(int clientId);

  Future<int> createApplication({
    required int clientId,
    required int employeeId,
    required int amount,
    required Currency currency,
    required int termMonths,
  });

  /// Одобрение: создаёт кредит и зачисляет сумму на [creditAccountId].
  Future<int> approve({
    required int applicationId,
    required int employeeId,
    required int creditAccountId,
    required int ratePercentX100,
  });

  Future<void> reject({
    required int applicationId,
    required int employeeId,
    String? reason,
  });

  /// Оплата кредита. Для безналичной оплаты нужен [fromAccountId].
  Future<void> pay({
    required int loanId,
    required int employeeId,
    required int amount,
    required PaymentMethod method,
    int? fromAccountId,
  });
}
