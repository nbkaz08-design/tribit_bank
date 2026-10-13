import 'package:bcrypt/bcrypt.dart';
import 'package:drift/drift.dart';

import '../../database/app_database.dart';
import '../auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository(this._db);
  final AppDatabase _db;

  @override
  Future<int> registerClient({
    required String login,
    required String password,
    required String fullName,
    String? phone,
    String? email,
  }) => _db.transaction(() async {
    final userId = await _db
        .into(_db.users)
        .insert(
          UsersCompanion.insert(
            login: login,
            passwordHash: BCrypt.hashpw(password, BCrypt.gensalt()),
            role: UserRole.client,
          ),
        );
    return _db
        .into(_db.clients)
        .insert(
          ClientsCompanion.insert(
            userId: userId,
            fullName: fullName,
            phone: Value(phone),
            email: Value(email),
          ),
        );
  });

  @override
  Future<User?> login(String login, String password) async {
    final user =
        await (_db.select(_db.users)
              ..where((u) => u.login.equals(login) & u.isActive.equals(true)))
            .getSingleOrNull();
    if (user == null) return null;

    return (BCrypt.checkpw(password, user.passwordHash)) ? user : null;
  }

  @override
  Future<Client?> getClientByUserId(int userId) => (_db.select(
    _db.clients,
  )..where((c) => c.userId.equals(userId))).getSingleOrNull();

  @override
  Future<Employee?> getEmployeeByUserId(int userId) => (_db.select(
    _db.employees,
  )..where((e) => e.userId.equals(userId))).getSingleOrNull();
}
