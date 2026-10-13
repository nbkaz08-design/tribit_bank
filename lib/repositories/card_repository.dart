import '../database/app_database.dart';

/// Банковские карты.
abstract class CardRepository {
  Stream<List<BankCard>> watchCards(int clientId);

  /// Заявка на выпуск карты, возвращает id.
  Future<int> requestCard({required int accountId, required String holderName});

  Future<void> blockCard(int cardId, {String? reason});
}
