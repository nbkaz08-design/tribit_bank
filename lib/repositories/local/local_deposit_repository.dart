import '../../database/app_database.dart';
import '../deposit_repository.dart';

class LocalDepositRepository implements DepositRepository {
  LocalDepositRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Deposit>> watchDeposits(int clientId) =>
      (_db.select(_db.deposits)..where((d) => d.clientId.equals(clientId)))
          .watch();

  @override
  Future<int> requestDeposit({
    required int clientId,
    required int amount,
    required Currency currency,
    required int termMonths,
  }) =>
      _db.into(_db.deposits).insert(DepositsCompanion.insert(
            clientId: clientId,
            amount: amount,
            currency: currency,
            termMonths: termMonths,
          ));
}
