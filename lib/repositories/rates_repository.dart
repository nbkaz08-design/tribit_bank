import '../database/app_database.dart';

/// Курсы валют.
abstract class RatesRepository {
  Stream<List<ExchangeRate>> watchRates();
}
