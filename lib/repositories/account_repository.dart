import '../database/app_database.dart';

/// Счета, баланс, история операций.
abstract class AccountRepository {
  Stream<List<Account>> watchAccounts(int clientId);
  Future<int> getBalance(int accountId);
  Stream<List<Transaction>> watchHistory(int accountId);

  /// Для сотрудника: просмотр информации по счетам клиента.
  Future<List<Account>> getAccountsOfClient(int clientId);
}
