import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../account_repository.dart';

class LocalAccountRepository implements AccountRepository {
  LocalAccountRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Account>> watchAccounts(int clientId) =>
      (_db.select(_db.accounts)..where((a) => a.clientId.equals(clientId)))
          .watch();

  @override
  Future<int> getBalance(int accountId) async {
    final acc = await (_db.select(_db.accounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingle();
    return acc.balance;
  }

  @override
  Stream<List<Transaction>> watchHistory(int accountId) =>
      (_db.select(_db.transactions)
            ..where((t) =>
                t.fromAccountId.equals(accountId) |
                t.toAccountId.equals(accountId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  @override
  Future<List<Account>> getAccountsOfClient(int clientId) =>
      (_db.select(_db.accounts)..where((a) => a.clientId.equals(clientId)))
          .get();
}
