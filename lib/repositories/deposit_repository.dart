import '../database/app_database.dart';

/// Вклады.
abstract class DepositRepository {
  Stream<List<Deposit>> watchDeposits(int clientId);

  /// Заявка на открытие вклада, возвращает id.
  Future<int> requestDeposit({
    required int clientId,
    required int amount,
    required Currency currency,
    required int termMonths,
  });
}
