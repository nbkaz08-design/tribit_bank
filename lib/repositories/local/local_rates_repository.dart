import '../../database/app_database.dart';
import '../rates_repository.dart';

class LocalRatesRepository implements RatesRepository {
  LocalRatesRepository(this._db);
  final AppDatabase _db;

  @override
  Stream<List<ExchangeRate>> watchRates() => _db.select(_db.exchangeRates).watch();
}
