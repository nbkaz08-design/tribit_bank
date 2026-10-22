// ignore: unused_import
import '../database/app_database.dart';

/// Денежные операции клиента.
abstract class PaymentRepository {
  /// Перевод в одной валюте (между своими счетами или другому клиенту).
  Future<void> transfer({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
    String? description,
  });

  /// Обмен валюты по внутреннему курсу банка.
  Future<void> exchangeCurrency({
    required int fromAccountId,
    required int toAccountId,
    required int amount,
  });
}
