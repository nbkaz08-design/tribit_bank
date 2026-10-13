import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(this._db);
  final AppDatabase _db;

  @override
  Future<int> registerClient({
    required String login,
    required String passwordHash,
    required String fullName,
    String? phone,
    String? email,
  }) =>
      _db.transaction(() async {
        final userId = await _db.into(_db.users).insert(UsersCompanion.insert(
              login: login,
              passwordHash: passwordHash,
              role: UserRole.client,
            ));
        return _db.into(_db.clients).insert(ClientsCompanion.insert(
              userId: userId,
              fullName: fullName,
              phone: Value(phone),
              email: Value(email),
            ));
      });

  @override
  Future<User?> login(String login, String passwordHash) =>
      (_db.select(_db.users)
            ..where((u) =>
                u.login.equals(login) &
                u.passwordHash.equals(passwordHash) &
                u.isActive.equals(true)))
          .getSingleOrNull();

  @override
  Future<Client?> getClientByUserId(int userId) =>
      (_db.select(_db.clients)..where((c) => c.userId.equals(userId)))
          .getSingleOrNull();

  @override
  Future<Employee?> getEmployeeByUserId(int userId) =>
      (_db.select(_db.employees)..where((e) => e.userId.equals(userId)))
          .getSingleOrNull();
}
