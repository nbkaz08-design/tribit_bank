import '../database/app_database.dart';

/// Регистрация и авторизация.
abstract class AuthRepository {
  /// Регистрирует клиента, возвращает id клиента.
  Future<int> registerClient({
    required String login,
    required String password,
    required String fullName,
    String? phone,
    String? email,
  });

  /// Возвращает пользователя при верных данных, иначе null.
  Future<User?> login(String login, String password);

  Future<Client?> getClientByUserId(int userId);
  Future<Employee?> getEmployeeByUserId(int userId);
}
