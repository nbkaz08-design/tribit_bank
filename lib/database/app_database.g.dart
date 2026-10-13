// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
    'login',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UserRole, int> role =
      GeneratedColumn<int>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<UserRole>($UsersTable.$converterrole);
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    login,
    passwordHash,
    role,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
        _loginMeta,
        login.isAcceptableOrUnknown(data['login']!, _loginMeta),
      );
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      login: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}login'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      role: $UsersTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}role'],
        )!,
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UserRole, int, int> $converterrole =
      const EnumIndexConverter<UserRole>(UserRole.values);
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String login;
  final String passwordHash;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.login,
    required this.passwordHash,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['login'] = Variable<String>(login);
    map['password_hash'] = Variable<String>(passwordHash);
    {
      map['role'] = Variable<int>($UsersTable.$converterrole.toSql(role));
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      login: Value(login),
      passwordHash: Value(passwordHash),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      login: serializer.fromJson<String>(json['login']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      role: $UsersTable.$converterrole.fromJson(
        serializer.fromJson<int>(json['role']),
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'login': serializer.toJson<String>(login),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'role': serializer.toJson<int>($UsersTable.$converterrole.toJson(role)),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? login,
    String? passwordHash,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    login: login ?? this.login,
    passwordHash: passwordHash ?? this.passwordHash,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      login: data.login.present ? data.login.value : this.login,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, login, passwordHash, role, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.login == this.login &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> login;
  final Value<String> passwordHash;
  final Value<UserRole> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String login,
    required String passwordHash,
    required UserRole role,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : login = Value(login),
       passwordHash = Value(passwordHash),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? login,
    Expression<String>? passwordHash,
    Expression<int>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? login,
    Value<String>? passwordHash,
    Value<UserRole>? role,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<int>($UsersTable.$converterrole.toSql(role.value));
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passportNumberMeta = const VerificationMeta(
    'passportNumber',
  );
  @override
  late final GeneratedColumn<String> passportNumber = GeneratedColumn<String>(
    'passport_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    fullName,
    phone,
    email,
    passportNumber,
    birthDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('passport_number')) {
      context.handle(
        _passportNumberMeta,
        passportNumber.isAcceptableOrUnknown(
          data['passport_number']!,
          _passportNumberMeta,
        ),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      passportNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}passport_number'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final int userId;
  final String fullName;
  final String? phone;
  final String? email;
  final String? passportNumber;
  final DateTime? birthDate;
  const Client({
    required this.id,
    required this.userId,
    required this.fullName,
    this.phone,
    this.email,
    this.passportNumber,
    this.birthDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || passportNumber != null) {
      map['passport_number'] = Variable<String>(passportNumber);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      userId: Value(userId),
      fullName: Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      passportNumber: passportNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(passportNumber),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      passportNumber: serializer.fromJson<String?>(json['passportNumber']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'passportNumber': serializer.toJson<String?>(passportNumber),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
    };
  }

  Client copyWith({
    int? id,
    int? userId,
    String? fullName,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> passportNumber = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
  }) => Client(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fullName: fullName ?? this.fullName,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    passportNumber: passportNumber.present
        ? passportNumber.value
        : this.passportNumber,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      passportNumber: data.passportNumber.present
          ? data.passportNumber.value
          : this.passportNumber,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('passportNumber: $passportNumber, ')
          ..write('birthDate: $birthDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    fullName,
    phone,
    email,
    passportNumber,
    birthDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.passportNumber == this.passportNumber &&
          other.birthDate == this.birthDate);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> fullName;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> passportNumber;
  final Value<DateTime?> birthDate;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.passportNumber = const Value.absent(),
    this.birthDate = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String fullName,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.passportNumber = const Value.absent(),
    this.birthDate = const Value.absent(),
  }) : userId = Value(userId),
       fullName = Value(fullName);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? passportNumber,
    Expression<DateTime>? birthDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (passportNumber != null) 'passport_number': passportNumber,
      if (birthDate != null) 'birth_date': birthDate,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? fullName,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? passportNumber,
    Value<DateTime?>? birthDate,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      passportNumber: passportNumber ?? this.passportNumber,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passportNumber.present) {
      map['passport_number'] = Variable<String>(passportNumber.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('passportNumber: $passportNumber, ')
          ..write('birthDate: $birthDate')
          ..write(')'))
        .toString();
  }
}

class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES users (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 150,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, fullName, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final int userId;
  final String fullName;
  final String position;
  const Employee({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['full_name'] = Variable<String>(fullName);
    map['position'] = Variable<String>(position);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      userId: Value(userId),
      fullName: Value(fullName),
      position: Value(position),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      position: serializer.fromJson<String>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'position': serializer.toJson<String>(position),
    };
  }

  Employee copyWith({
    int? id,
    int? userId,
    String? fullName,
    String? position,
  }) => Employee(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fullName: fullName ?? this.fullName,
    position: position ?? this.position,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, fullName, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.position == this.position);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> fullName;
  final Value<String> position;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.position = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String fullName,
    required String position,
  }) : userId = Value(userId),
       fullName = Value(fullName),
       position = Value(position);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? fullName,
    Expression<String>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (position != null) 'position': position,
    });
  }

  EmployeesCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? fullName,
    Value<String>? position,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

class $AccountsTable extends Accounts with TableInfo<$AccountsTable, Account> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 20,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<AccountType>($AccountsTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> currency =
      GeneratedColumn<int>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($AccountsTable.$convertercurrency);
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<int> balance = GeneratedColumn<int>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<AccountStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(AccountStatus.active.index),
      ).withConverter<AccountStatus>($AccountsTable.$converterstatus);
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    number,
    type,
    currency,
    balance,
    status,
    openedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Account> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Account map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Account(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      type: $AccountsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      currency: $AccountsTable.$convertercurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}currency'],
        )!,
      ),
      balance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance'],
      )!,
      status: $AccountsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      )!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AccountType, int, int> $convertertype =
      const EnumIndexConverter<AccountType>(AccountType.values);
  static JsonTypeConverter2<Currency, int, int> $convertercurrency =
      const EnumIndexConverter<Currency>(Currency.values);
  static JsonTypeConverter2<AccountStatus, int, int> $converterstatus =
      const EnumIndexConverter<AccountStatus>(AccountStatus.values);
}

class Account extends DataClass implements Insertable<Account> {
  final int id;
  final int clientId;
  final String number;
  final AccountType type;
  final Currency currency;
  final int balance;
  final AccountStatus status;
  final DateTime openedAt;
  const Account({
    required this.id,
    required this.clientId,
    required this.number,
    required this.type,
    required this.currency,
    required this.balance,
    required this.status,
    required this.openedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['number'] = Variable<String>(number);
    {
      map['type'] = Variable<int>($AccountsTable.$convertertype.toSql(type));
    }
    {
      map['currency'] = Variable<int>(
        $AccountsTable.$convertercurrency.toSql(currency),
      );
    }
    map['balance'] = Variable<int>(balance);
    {
      map['status'] = Variable<int>(
        $AccountsTable.$converterstatus.toSql(status),
      );
    }
    map['opened_at'] = Variable<DateTime>(openedAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      number: Value(number),
      type: Value(type),
      currency: Value(currency),
      balance: Value(balance),
      status: Value(status),
      openedAt: Value(openedAt),
    );
  }

  factory Account.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Account(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      number: serializer.fromJson<String>(json['number']),
      type: $AccountsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      currency: $AccountsTable.$convertercurrency.fromJson(
        serializer.fromJson<int>(json['currency']),
      ),
      balance: serializer.fromJson<int>(json['balance']),
      status: $AccountsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'number': serializer.toJson<String>(number),
      'type': serializer.toJson<int>(
        $AccountsTable.$convertertype.toJson(type),
      ),
      'currency': serializer.toJson<int>(
        $AccountsTable.$convertercurrency.toJson(currency),
      ),
      'balance': serializer.toJson<int>(balance),
      'status': serializer.toJson<int>(
        $AccountsTable.$converterstatus.toJson(status),
      ),
      'openedAt': serializer.toJson<DateTime>(openedAt),
    };
  }

  Account copyWith({
    int? id,
    int? clientId,
    String? number,
    AccountType? type,
    Currency? currency,
    int? balance,
    AccountStatus? status,
    DateTime? openedAt,
  }) => Account(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    number: number ?? this.number,
    type: type ?? this.type,
    currency: currency ?? this.currency,
    balance: balance ?? this.balance,
    status: status ?? this.status,
    openedAt: openedAt ?? this.openedAt,
  );
  Account copyWithCompanion(AccountsCompanion data) {
    return Account(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      number: data.number.present ? data.number.value : this.number,
      type: data.type.present ? data.type.value : this.type,
      currency: data.currency.present ? data.currency.value : this.currency,
      balance: data.balance.present ? data.balance.value : this.balance,
      status: data.status.present ? data.status.value : this.status,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Account(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('number: $number, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('balance: $balance, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    number,
    type,
    currency,
    balance,
    status,
    openedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Account &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.number == this.number &&
          other.type == this.type &&
          other.currency == this.currency &&
          other.balance == this.balance &&
          other.status == this.status &&
          other.openedAt == this.openedAt);
}

class AccountsCompanion extends UpdateCompanion<Account> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> number;
  final Value<AccountType> type;
  final Value<Currency> currency;
  final Value<int> balance;
  final Value<AccountStatus> status;
  final Value<DateTime> openedAt;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.number = const Value.absent(),
    this.type = const Value.absent(),
    this.currency = const Value.absent(),
    this.balance = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
  });
  AccountsCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String number,
    required AccountType type,
    required Currency currency,
    this.balance = const Value.absent(),
    this.status = const Value.absent(),
    this.openedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       number = Value(number),
       type = Value(type),
       currency = Value(currency);
  static Insertable<Account> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? number,
    Expression<int>? type,
    Expression<int>? currency,
    Expression<int>? balance,
    Expression<int>? status,
    Expression<DateTime>? openedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (number != null) 'number': number,
      if (type != null) 'type': type,
      if (currency != null) 'currency': currency,
      if (balance != null) 'balance': balance,
      if (status != null) 'status': status,
      if (openedAt != null) 'opened_at': openedAt,
    });
  }

  AccountsCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<String>? number,
    Value<AccountType>? type,
    Value<Currency>? currency,
    Value<int>? balance,
    Value<AccountStatus>? status,
    Value<DateTime>? openedAt,
  }) {
    return AccountsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      number: number ?? this.number,
      type: type ?? this.type,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      status: status ?? this.status,
      openedAt: openedAt ?? this.openedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $AccountsTable.$convertertype.toSql(type.value),
      );
    }
    if (currency.present) {
      map['currency'] = Variable<int>(
        $AccountsTable.$convertercurrency.toSql(currency.value),
      );
    }
    if (balance.present) {
      map['balance'] = Variable<int>(balance.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $AccountsTable.$converterstatus.toSql(status.value),
      );
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('number: $number, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('balance: $balance, ')
          ..write('status: $status, ')
          ..write('openedAt: $openedAt')
          ..write(')'))
        .toString();
  }
}

class $BankCardsTable extends BankCards
    with TableInfo<$BankCardsTable, BankCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 16,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _holderNameMeta = const VerificationMeta(
    'holderName',
  );
  @override
  late final GeneratedColumn<String> holderName = GeneratedColumn<String>(
    'holder_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CardStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(CardStatus.requested.index),
      ).withConverter<CardStatus>($BankCardsTable.$converterstatus);
  static const VerificationMeta _requestedAtMeta = const VerificationMeta(
    'requestedAt',
  );
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
    'requested_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _blockedAtMeta = const VerificationMeta(
    'blockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> blockedAt = GeneratedColumn<DateTime>(
    'blocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockReasonMeta = const VerificationMeta(
    'blockReason',
  );
  @override
  late final GeneratedColumn<String> blockReason = GeneratedColumn<String>(
    'block_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    number,
    holderName,
    expiresAt,
    status,
    requestedAt,
    blockedAt,
    blockReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('holder_name')) {
      context.handle(
        _holderNameMeta,
        holderName.isAcceptableOrUnknown(data['holder_name']!, _holderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_holderNameMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('requested_at')) {
      context.handle(
        _requestedAtMeta,
        requestedAt.isAcceptableOrUnknown(
          data['requested_at']!,
          _requestedAtMeta,
        ),
      );
    }
    if (data.containsKey('blocked_at')) {
      context.handle(
        _blockedAtMeta,
        blockedAt.isAcceptableOrUnknown(data['blocked_at']!, _blockedAtMeta),
      );
    }
    if (data.containsKey('block_reason')) {
      context.handle(
        _blockReasonMeta,
        blockReason.isAcceptableOrUnknown(
          data['block_reason']!,
          _blockReasonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      holderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}holder_name'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
      status: $BankCardsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      requestedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}requested_at'],
      )!,
      blockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}blocked_at'],
      ),
      blockReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}block_reason'],
      ),
    );
  }

  @override
  $BankCardsTable createAlias(String alias) {
    return $BankCardsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CardStatus, int, int> $converterstatus =
      const EnumIndexConverter<CardStatus>(CardStatus.values);
}

class BankCard extends DataClass implements Insertable<BankCard> {
  final int id;
  final int accountId;
  final String? number;
  final String holderName;
  final DateTime? expiresAt;
  final CardStatus status;
  final DateTime requestedAt;
  final DateTime? blockedAt;
  final String? blockReason;
  const BankCard({
    required this.id,
    required this.accountId,
    this.number,
    required this.holderName,
    this.expiresAt,
    required this.status,
    required this.requestedAt,
    this.blockedAt,
    this.blockReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['holder_name'] = Variable<String>(holderName);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    {
      map['status'] = Variable<int>(
        $BankCardsTable.$converterstatus.toSql(status),
      );
    }
    map['requested_at'] = Variable<DateTime>(requestedAt);
    if (!nullToAbsent || blockedAt != null) {
      map['blocked_at'] = Variable<DateTime>(blockedAt);
    }
    if (!nullToAbsent || blockReason != null) {
      map['block_reason'] = Variable<String>(blockReason);
    }
    return map;
  }

  BankCardsCompanion toCompanion(bool nullToAbsent) {
    return BankCardsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      holderName: Value(holderName),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
      status: Value(status),
      requestedAt: Value(requestedAt),
      blockedAt: blockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(blockedAt),
      blockReason: blockReason == null && nullToAbsent
          ? const Value.absent()
          : Value(blockReason),
    );
  }

  factory BankCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankCard(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      number: serializer.fromJson<String?>(json['number']),
      holderName: serializer.fromJson<String>(json['holderName']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
      status: $BankCardsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
      blockedAt: serializer.fromJson<DateTime?>(json['blockedAt']),
      blockReason: serializer.fromJson<String?>(json['blockReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'number': serializer.toJson<String?>(number),
      'holderName': serializer.toJson<String>(holderName),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
      'status': serializer.toJson<int>(
        $BankCardsTable.$converterstatus.toJson(status),
      ),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
      'blockedAt': serializer.toJson<DateTime?>(blockedAt),
      'blockReason': serializer.toJson<String?>(blockReason),
    };
  }

  BankCard copyWith({
    int? id,
    int? accountId,
    Value<String?> number = const Value.absent(),
    String? holderName,
    Value<DateTime?> expiresAt = const Value.absent(),
    CardStatus? status,
    DateTime? requestedAt,
    Value<DateTime?> blockedAt = const Value.absent(),
    Value<String?> blockReason = const Value.absent(),
  }) => BankCard(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    number: number.present ? number.value : this.number,
    holderName: holderName ?? this.holderName,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    status: status ?? this.status,
    requestedAt: requestedAt ?? this.requestedAt,
    blockedAt: blockedAt.present ? blockedAt.value : this.blockedAt,
    blockReason: blockReason.present ? blockReason.value : this.blockReason,
  );
  BankCard copyWithCompanion(BankCardsCompanion data) {
    return BankCard(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      number: data.number.present ? data.number.value : this.number,
      holderName: data.holderName.present
          ? data.holderName.value
          : this.holderName,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      status: data.status.present ? data.status.value : this.status,
      requestedAt: data.requestedAt.present
          ? data.requestedAt.value
          : this.requestedAt,
      blockedAt: data.blockedAt.present ? data.blockedAt.value : this.blockedAt,
      blockReason: data.blockReason.present
          ? data.blockReason.value
          : this.blockReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankCard(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('number: $number, ')
          ..write('holderName: $holderName, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('status: $status, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('blockedAt: $blockedAt, ')
          ..write('blockReason: $blockReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    number,
    holderName,
    expiresAt,
    status,
    requestedAt,
    blockedAt,
    blockReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankCard &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.number == this.number &&
          other.holderName == this.holderName &&
          other.expiresAt == this.expiresAt &&
          other.status == this.status &&
          other.requestedAt == this.requestedAt &&
          other.blockedAt == this.blockedAt &&
          other.blockReason == this.blockReason);
}

class BankCardsCompanion extends UpdateCompanion<BankCard> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<String?> number;
  final Value<String> holderName;
  final Value<DateTime?> expiresAt;
  final Value<CardStatus> status;
  final Value<DateTime> requestedAt;
  final Value<DateTime?> blockedAt;
  final Value<String?> blockReason;
  const BankCardsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.number = const Value.absent(),
    this.holderName = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.status = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.blockedAt = const Value.absent(),
    this.blockReason = const Value.absent(),
  });
  BankCardsCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    this.number = const Value.absent(),
    required String holderName,
    this.expiresAt = const Value.absent(),
    this.status = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.blockedAt = const Value.absent(),
    this.blockReason = const Value.absent(),
  }) : accountId = Value(accountId),
       holderName = Value(holderName);
  static Insertable<BankCard> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<String>? number,
    Expression<String>? holderName,
    Expression<DateTime>? expiresAt,
    Expression<int>? status,
    Expression<DateTime>? requestedAt,
    Expression<DateTime>? blockedAt,
    Expression<String>? blockReason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (number != null) 'number': number,
      if (holderName != null) 'holder_name': holderName,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (status != null) 'status': status,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (blockedAt != null) 'blocked_at': blockedAt,
      if (blockReason != null) 'block_reason': blockReason,
    });
  }

  BankCardsCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<String?>? number,
    Value<String>? holderName,
    Value<DateTime?>? expiresAt,
    Value<CardStatus>? status,
    Value<DateTime>? requestedAt,
    Value<DateTime?>? blockedAt,
    Value<String?>? blockReason,
  }) {
    return BankCardsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      number: number ?? this.number,
      holderName: holderName ?? this.holderName,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      blockedAt: blockedAt ?? this.blockedAt,
      blockReason: blockReason ?? this.blockReason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (holderName.present) {
      map['holder_name'] = Variable<String>(holderName.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $BankCardsTable.$converterstatus.toSql(status.value),
      );
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (blockedAt.present) {
      map['blocked_at'] = Variable<DateTime>(blockedAt.value);
    }
    if (blockReason.present) {
      map['block_reason'] = Variable<String>(blockReason.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankCardsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('number: $number, ')
          ..write('holderName: $holderName, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('status: $status, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('blockedAt: $blockedAt, ')
          ..write('blockReason: $blockReason')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates
    with TableInfo<$ExchangeRatesTable, ExchangeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> baseCurrency =
      GeneratedColumn<int>(
        'base_currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($ExchangeRatesTable.$converterbaseCurrency);
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> quoteCurrency =
      GeneratedColumn<int>(
        'quote_currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($ExchangeRatesTable.$converterquoteCurrency);
  static const VerificationMeta _buyRateX10000Meta = const VerificationMeta(
    'buyRateX10000',
  );
  @override
  late final GeneratedColumn<int> buyRateX10000 = GeneratedColumn<int>(
    'buy_rate_x10000',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellRateX10000Meta = const VerificationMeta(
    'sellRateX10000',
  );
  @override
  late final GeneratedColumn<int> sellRateX10000 = GeneratedColumn<int>(
    'sell_rate_x10000',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    baseCurrency,
    quoteCurrency,
    buyRateX10000,
    sellRateX10000,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExchangeRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buy_rate_x10000')) {
      context.handle(
        _buyRateX10000Meta,
        buyRateX10000.isAcceptableOrUnknown(
          data['buy_rate_x10000']!,
          _buyRateX10000Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_buyRateX10000Meta);
    }
    if (data.containsKey('sell_rate_x10000')) {
      context.handle(
        _sellRateX10000Meta,
        sellRateX10000.isAcceptableOrUnknown(
          data['sell_rate_x10000']!,
          _sellRateX10000Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellRateX10000Meta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {baseCurrency, quoteCurrency},
  ];
  @override
  ExchangeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      baseCurrency: $ExchangeRatesTable.$converterbaseCurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}base_currency'],
        )!,
      ),
      quoteCurrency: $ExchangeRatesTable.$converterquoteCurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}quote_currency'],
        )!,
      ),
      buyRateX10000: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}buy_rate_x10000'],
      )!,
      sellRateX10000: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sell_rate_x10000'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Currency, int, int> $converterbaseCurrency =
      const EnumIndexConverter<Currency>(Currency.values);
  static JsonTypeConverter2<Currency, int, int> $converterquoteCurrency =
      const EnumIndexConverter<Currency>(Currency.values);
}

class ExchangeRate extends DataClass implements Insertable<ExchangeRate> {
  final int id;
  final Currency baseCurrency;
  final Currency quoteCurrency;
  final int buyRateX10000;
  final int sellRateX10000;
  final DateTime updatedAt;
  const ExchangeRate({
    required this.id,
    required this.baseCurrency,
    required this.quoteCurrency,
    required this.buyRateX10000,
    required this.sellRateX10000,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['base_currency'] = Variable<int>(
        $ExchangeRatesTable.$converterbaseCurrency.toSql(baseCurrency),
      );
    }
    {
      map['quote_currency'] = Variable<int>(
        $ExchangeRatesTable.$converterquoteCurrency.toSql(quoteCurrency),
      );
    }
    map['buy_rate_x10000'] = Variable<int>(buyRateX10000);
    map['sell_rate_x10000'] = Variable<int>(sellRateX10000);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      baseCurrency: Value(baseCurrency),
      quoteCurrency: Value(quoteCurrency),
      buyRateX10000: Value(buyRateX10000),
      sellRateX10000: Value(sellRateX10000),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExchangeRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRate(
      id: serializer.fromJson<int>(json['id']),
      baseCurrency: $ExchangeRatesTable.$converterbaseCurrency.fromJson(
        serializer.fromJson<int>(json['baseCurrency']),
      ),
      quoteCurrency: $ExchangeRatesTable.$converterquoteCurrency.fromJson(
        serializer.fromJson<int>(json['quoteCurrency']),
      ),
      buyRateX10000: serializer.fromJson<int>(json['buyRateX10000']),
      sellRateX10000: serializer.fromJson<int>(json['sellRateX10000']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'baseCurrency': serializer.toJson<int>(
        $ExchangeRatesTable.$converterbaseCurrency.toJson(baseCurrency),
      ),
      'quoteCurrency': serializer.toJson<int>(
        $ExchangeRatesTable.$converterquoteCurrency.toJson(quoteCurrency),
      ),
      'buyRateX10000': serializer.toJson<int>(buyRateX10000),
      'sellRateX10000': serializer.toJson<int>(sellRateX10000),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExchangeRate copyWith({
    int? id,
    Currency? baseCurrency,
    Currency? quoteCurrency,
    int? buyRateX10000,
    int? sellRateX10000,
    DateTime? updatedAt,
  }) => ExchangeRate(
    id: id ?? this.id,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    quoteCurrency: quoteCurrency ?? this.quoteCurrency,
    buyRateX10000: buyRateX10000 ?? this.buyRateX10000,
    sellRateX10000: sellRateX10000 ?? this.sellRateX10000,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExchangeRate copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRate(
      id: data.id.present ? data.id.value : this.id,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      quoteCurrency: data.quoteCurrency.present
          ? data.quoteCurrency.value
          : this.quoteCurrency,
      buyRateX10000: data.buyRateX10000.present
          ? data.buyRateX10000.value
          : this.buyRateX10000,
      sellRateX10000: data.sellRateX10000.present
          ? data.sellRateX10000.value
          : this.sellRateX10000,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRate(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('quoteCurrency: $quoteCurrency, ')
          ..write('buyRateX10000: $buyRateX10000, ')
          ..write('sellRateX10000: $sellRateX10000, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    baseCurrency,
    quoteCurrency,
    buyRateX10000,
    sellRateX10000,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          other.id == this.id &&
          other.baseCurrency == this.baseCurrency &&
          other.quoteCurrency == this.quoteCurrency &&
          other.buyRateX10000 == this.buyRateX10000 &&
          other.sellRateX10000 == this.sellRateX10000 &&
          other.updatedAt == this.updatedAt);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRate> {
  final Value<int> id;
  final Value<Currency> baseCurrency;
  final Value<Currency> quoteCurrency;
  final Value<int> buyRateX10000;
  final Value<int> sellRateX10000;
  final Value<DateTime> updatedAt;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.quoteCurrency = const Value.absent(),
    this.buyRateX10000 = const Value.absent(),
    this.sellRateX10000 = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    this.id = const Value.absent(),
    required Currency baseCurrency,
    required Currency quoteCurrency,
    required int buyRateX10000,
    required int sellRateX10000,
    this.updatedAt = const Value.absent(),
  }) : baseCurrency = Value(baseCurrency),
       quoteCurrency = Value(quoteCurrency),
       buyRateX10000 = Value(buyRateX10000),
       sellRateX10000 = Value(sellRateX10000);
  static Insertable<ExchangeRate> custom({
    Expression<int>? id,
    Expression<int>? baseCurrency,
    Expression<int>? quoteCurrency,
    Expression<int>? buyRateX10000,
    Expression<int>? sellRateX10000,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (quoteCurrency != null) 'quote_currency': quoteCurrency,
      if (buyRateX10000 != null) 'buy_rate_x10000': buyRateX10000,
      if (sellRateX10000 != null) 'sell_rate_x10000': sellRateX10000,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ExchangeRatesCompanion copyWith({
    Value<int>? id,
    Value<Currency>? baseCurrency,
    Value<Currency>? quoteCurrency,
    Value<int>? buyRateX10000,
    Value<int>? sellRateX10000,
    Value<DateTime>? updatedAt,
  }) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      quoteCurrency: quoteCurrency ?? this.quoteCurrency,
      buyRateX10000: buyRateX10000 ?? this.buyRateX10000,
      sellRateX10000: sellRateX10000 ?? this.sellRateX10000,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<int>(
        $ExchangeRatesTable.$converterbaseCurrency.toSql(baseCurrency.value),
      );
    }
    if (quoteCurrency.present) {
      map['quote_currency'] = Variable<int>(
        $ExchangeRatesTable.$converterquoteCurrency.toSql(quoteCurrency.value),
      );
    }
    if (buyRateX10000.present) {
      map['buy_rate_x10000'] = Variable<int>(buyRateX10000.value);
    }
    if (sellRateX10000.present) {
      map['sell_rate_x10000'] = Variable<int>(sellRateX10000.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('quoteCurrency: $quoteCurrency, ')
          ..write('buyRateX10000: $buyRateX10000, ')
          ..write('sellRateX10000: $sellRateX10000, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>($TransactionsTable.$convertertype);
  static const VerificationMeta _fromAccountIdMeta = const VerificationMeta(
    'fromAccountId',
  );
  @override
  late final GeneratedColumn<int> fromAccountId = GeneratedColumn<int>(
    'from_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _toAccountIdMeta = const VerificationMeta(
    'toAccountId',
  );
  @override
  late final GeneratedColumn<int> toAccountId = GeneratedColumn<int>(
    'to_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> currency =
      GeneratedColumn<int>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($TransactionsTable.$convertercurrency);
  static const VerificationMeta _convertedAmountMeta = const VerificationMeta(
    'convertedAmount',
  );
  @override
  late final GeneratedColumn<int> convertedAmount = GeneratedColumn<int>(
    'converted_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appliedRateX10000Meta = const VerificationMeta(
    'appliedRateX10000',
  );
  @override
  late final GeneratedColumn<int> appliedRateX10000 = GeneratedColumn<int>(
    'applied_rate_x10000',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    fromAccountId,
    toAccountId,
    amount,
    currency,
    convertedAmount,
    appliedRateX10000,
    description,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('from_account_id')) {
      context.handle(
        _fromAccountIdMeta,
        fromAccountId.isAcceptableOrUnknown(
          data['from_account_id']!,
          _fromAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
        _toAccountIdMeta,
        toAccountId.isAcceptableOrUnknown(
          data['to_account_id']!,
          _toAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('converted_amount')) {
      context.handle(
        _convertedAmountMeta,
        convertedAmount.isAcceptableOrUnknown(
          data['converted_amount']!,
          _convertedAmountMeta,
        ),
      );
    }
    if (data.containsKey('applied_rate_x10000')) {
      context.handle(
        _appliedRateX10000Meta,
        appliedRateX10000.isAcceptableOrUnknown(
          data['applied_rate_x10000']!,
          _appliedRateX10000Meta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      fromAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}from_account_id'],
      ),
      toAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}to_account_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: $TransactionsTable.$convertercurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}currency'],
        )!,
      ),
      convertedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}converted_amount'],
      ),
      appliedRateX10000: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}applied_rate_x10000'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, int, int> $convertertype =
      const EnumIndexConverter<TransactionType>(TransactionType.values);
  static JsonTypeConverter2<Currency, int, int> $convertercurrency =
      const EnumIndexConverter<Currency>(Currency.values);
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final TransactionType type;
  final int? fromAccountId;
  final int? toAccountId;
  final int amount;
  final Currency currency;
  final int? convertedAmount;
  final int? appliedRateX10000;
  final String? description;
  final DateTime createdAt;
  const Transaction({
    required this.id,
    required this.type,
    this.fromAccountId,
    this.toAccountId,
    required this.amount,
    required this.currency,
    this.convertedAmount,
    this.appliedRateX10000,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || fromAccountId != null) {
      map['from_account_id'] = Variable<int>(fromAccountId);
    }
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<int>(toAccountId);
    }
    map['amount'] = Variable<int>(amount);
    {
      map['currency'] = Variable<int>(
        $TransactionsTable.$convertercurrency.toSql(currency),
      );
    }
    if (!nullToAbsent || convertedAmount != null) {
      map['converted_amount'] = Variable<int>(convertedAmount);
    }
    if (!nullToAbsent || appliedRateX10000 != null) {
      map['applied_rate_x10000'] = Variable<int>(appliedRateX10000);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      fromAccountId: fromAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromAccountId),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      amount: Value(amount),
      currency: Value(currency),
      convertedAmount: convertedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(convertedAmount),
      appliedRateX10000: appliedRateX10000 == null && nullToAbsent
          ? const Value.absent()
          : Value(appliedRateX10000),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      type: $TransactionsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      fromAccountId: serializer.fromJson<int?>(json['fromAccountId']),
      toAccountId: serializer.fromJson<int?>(json['toAccountId']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: $TransactionsTable.$convertercurrency.fromJson(
        serializer.fromJson<int>(json['currency']),
      ),
      convertedAmount: serializer.fromJson<int?>(json['convertedAmount']),
      appliedRateX10000: serializer.fromJson<int?>(json['appliedRateX10000']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<int>(
        $TransactionsTable.$convertertype.toJson(type),
      ),
      'fromAccountId': serializer.toJson<int?>(fromAccountId),
      'toAccountId': serializer.toJson<int?>(toAccountId),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<int>(
        $TransactionsTable.$convertercurrency.toJson(currency),
      ),
      'convertedAmount': serializer.toJson<int?>(convertedAmount),
      'appliedRateX10000': serializer.toJson<int?>(appliedRateX10000),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith({
    int? id,
    TransactionType? type,
    Value<int?> fromAccountId = const Value.absent(),
    Value<int?> toAccountId = const Value.absent(),
    int? amount,
    Currency? currency,
    Value<int?> convertedAmount = const Value.absent(),
    Value<int?> appliedRateX10000 = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => Transaction(
    id: id ?? this.id,
    type: type ?? this.type,
    fromAccountId: fromAccountId.present
        ? fromAccountId.value
        : this.fromAccountId,
    toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    convertedAmount: convertedAmount.present
        ? convertedAmount.value
        : this.convertedAmount,
    appliedRateX10000: appliedRateX10000.present
        ? appliedRateX10000.value
        : this.appliedRateX10000,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      fromAccountId: data.fromAccountId.present
          ? data.fromAccountId.value
          : this.fromAccountId,
      toAccountId: data.toAccountId.present
          ? data.toAccountId.value
          : this.toAccountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      convertedAmount: data.convertedAmount.present
          ? data.convertedAmount.value
          : this.convertedAmount,
      appliedRateX10000: data.appliedRateX10000.present
          ? data.appliedRateX10000.value
          : this.appliedRateX10000,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('convertedAmount: $convertedAmount, ')
          ..write('appliedRateX10000: $appliedRateX10000, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    fromAccountId,
    toAccountId,
    amount,
    currency,
    convertedAmount,
    appliedRateX10000,
    description,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.type == this.type &&
          other.fromAccountId == this.fromAccountId &&
          other.toAccountId == this.toAccountId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.convertedAmount == this.convertedAmount &&
          other.appliedRateX10000 == this.appliedRateX10000 &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<TransactionType> type;
  final Value<int?> fromAccountId;
  final Value<int?> toAccountId;
  final Value<int> amount;
  final Value<Currency> currency;
  final Value<int?> convertedAmount;
  final Value<int?> appliedRateX10000;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.convertedAmount = const Value.absent(),
    this.appliedRateX10000 = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required TransactionType type,
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    required int amount,
    required Currency currency,
    this.convertedAmount = const Value.absent(),
    this.appliedRateX10000 = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       amount = Value(amount),
       currency = Value(currency);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? type,
    Expression<int>? fromAccountId,
    Expression<int>? toAccountId,
    Expression<int>? amount,
    Expression<int>? currency,
    Expression<int>? convertedAmount,
    Expression<int>? appliedRateX10000,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (fromAccountId != null) 'from_account_id': fromAccountId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (convertedAmount != null) 'converted_amount': convertedAmount,
      if (appliedRateX10000 != null) 'applied_rate_x10000': appliedRateX10000,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<TransactionType>? type,
    Value<int?>? fromAccountId,
    Value<int?>? toAccountId,
    Value<int>? amount,
    Value<Currency>? currency,
    Value<int?>? convertedAmount,
    Value<int?>? appliedRateX10000,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      appliedRateX10000: appliedRateX10000 ?? this.appliedRateX10000,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (fromAccountId.present) {
      map['from_account_id'] = Variable<int>(fromAccountId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<int>(toAccountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(
        $TransactionsTable.$convertercurrency.toSql(currency.value),
      );
    }
    if (convertedAmount.present) {
      map['converted_amount'] = Variable<int>(convertedAmount.value);
    }
    if (appliedRateX10000.present) {
      map['applied_rate_x10000'] = Variable<int>(appliedRateX10000.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('convertedAmount: $convertedAmount, ')
          ..write('appliedRateX10000: $appliedRateX10000, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DepositsTable extends Deposits with TableInfo<$DepositsTable, Deposit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepositsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> currency =
      GeneratedColumn<int>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($DepositsTable.$convertercurrency);
  static const VerificationMeta _termMonthsMeta = const VerificationMeta(
    'termMonths',
  );
  @override
  late final GeneratedColumn<int> termMonths = GeneratedColumn<int>(
    'term_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePercentX100Meta = const VerificationMeta(
    'ratePercentX100',
  );
  @override
  late final GeneratedColumn<int> ratePercentX100 = GeneratedColumn<int>(
    'rate_percent_x100',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DepositStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(DepositStatus.requested.index),
      ).withConverter<DepositStatus>($DepositsTable.$converterstatus);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta(
    'openedAt',
  );
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closesAtMeta = const VerificationMeta(
    'closesAt',
  );
  @override
  late final GeneratedColumn<DateTime> closesAt = GeneratedColumn<DateTime>(
    'closes_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    accountId,
    amount,
    currency,
    termMonths,
    ratePercentX100,
    status,
    createdAt,
    openedAt,
    closesAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'deposits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Deposit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('term_months')) {
      context.handle(
        _termMonthsMeta,
        termMonths.isAcceptableOrUnknown(data['term_months']!, _termMonthsMeta),
      );
    } else if (isInserting) {
      context.missing(_termMonthsMeta);
    }
    if (data.containsKey('rate_percent_x100')) {
      context.handle(
        _ratePercentX100Meta,
        ratePercentX100.isAcceptableOrUnknown(
          data['rate_percent_x100']!,
          _ratePercentX100Meta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('opened_at')) {
      context.handle(
        _openedAtMeta,
        openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta),
      );
    }
    if (data.containsKey('closes_at')) {
      context.handle(
        _closesAtMeta,
        closesAt.isAcceptableOrUnknown(data['closes_at']!, _closesAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Deposit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Deposit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: $DepositsTable.$convertercurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}currency'],
        )!,
      ),
      termMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}term_months'],
      )!,
      ratePercentX100: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_percent_x100'],
      )!,
      status: $DepositsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      openedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opened_at'],
      ),
      closesAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closes_at'],
      ),
    );
  }

  @override
  $DepositsTable createAlias(String alias) {
    return $DepositsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Currency, int, int> $convertercurrency =
      const EnumIndexConverter<Currency>(Currency.values);
  static JsonTypeConverter2<DepositStatus, int, int> $converterstatus =
      const EnumIndexConverter<DepositStatus>(DepositStatus.values);
}

class Deposit extends DataClass implements Insertable<Deposit> {
  final int id;
  final int clientId;
  final int? accountId;
  final int amount;
  final Currency currency;
  final int termMonths;
  final int ratePercentX100;
  final DepositStatus status;
  final DateTime createdAt;
  final DateTime? openedAt;
  final DateTime? closesAt;
  const Deposit({
    required this.id,
    required this.clientId,
    this.accountId,
    required this.amount,
    required this.currency,
    required this.termMonths,
    required this.ratePercentX100,
    required this.status,
    required this.createdAt,
    this.openedAt,
    this.closesAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    map['amount'] = Variable<int>(amount);
    {
      map['currency'] = Variable<int>(
        $DepositsTable.$convertercurrency.toSql(currency),
      );
    }
    map['term_months'] = Variable<int>(termMonths);
    map['rate_percent_x100'] = Variable<int>(ratePercentX100);
    {
      map['status'] = Variable<int>(
        $DepositsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || openedAt != null) {
      map['opened_at'] = Variable<DateTime>(openedAt);
    }
    if (!nullToAbsent || closesAt != null) {
      map['closes_at'] = Variable<DateTime>(closesAt);
    }
    return map;
  }

  DepositsCompanion toCompanion(bool nullToAbsent) {
    return DepositsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      amount: Value(amount),
      currency: Value(currency),
      termMonths: Value(termMonths),
      ratePercentX100: Value(ratePercentX100),
      status: Value(status),
      createdAt: Value(createdAt),
      openedAt: openedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(openedAt),
      closesAt: closesAt == null && nullToAbsent
          ? const Value.absent()
          : Value(closesAt),
    );
  }

  factory Deposit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Deposit(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: $DepositsTable.$convertercurrency.fromJson(
        serializer.fromJson<int>(json['currency']),
      ),
      termMonths: serializer.fromJson<int>(json['termMonths']),
      ratePercentX100: serializer.fromJson<int>(json['ratePercentX100']),
      status: $DepositsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      openedAt: serializer.fromJson<DateTime?>(json['openedAt']),
      closesAt: serializer.fromJson<DateTime?>(json['closesAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'accountId': serializer.toJson<int?>(accountId),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<int>(
        $DepositsTable.$convertercurrency.toJson(currency),
      ),
      'termMonths': serializer.toJson<int>(termMonths),
      'ratePercentX100': serializer.toJson<int>(ratePercentX100),
      'status': serializer.toJson<int>(
        $DepositsTable.$converterstatus.toJson(status),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'openedAt': serializer.toJson<DateTime?>(openedAt),
      'closesAt': serializer.toJson<DateTime?>(closesAt),
    };
  }

  Deposit copyWith({
    int? id,
    int? clientId,
    Value<int?> accountId = const Value.absent(),
    int? amount,
    Currency? currency,
    int? termMonths,
    int? ratePercentX100,
    DepositStatus? status,
    DateTime? createdAt,
    Value<DateTime?> openedAt = const Value.absent(),
    Value<DateTime?> closesAt = const Value.absent(),
  }) => Deposit(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    accountId: accountId.present ? accountId.value : this.accountId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    termMonths: termMonths ?? this.termMonths,
    ratePercentX100: ratePercentX100 ?? this.ratePercentX100,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    openedAt: openedAt.present ? openedAt.value : this.openedAt,
    closesAt: closesAt.present ? closesAt.value : this.closesAt,
  );
  Deposit copyWithCompanion(DepositsCompanion data) {
    return Deposit(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      termMonths: data.termMonths.present
          ? data.termMonths.value
          : this.termMonths,
      ratePercentX100: data.ratePercentX100.present
          ? data.ratePercentX100.value
          : this.ratePercentX100,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closesAt: data.closesAt.present ? data.closesAt.value : this.closesAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Deposit(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('termMonths: $termMonths, ')
          ..write('ratePercentX100: $ratePercentX100, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('openedAt: $openedAt, ')
          ..write('closesAt: $closesAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    accountId,
    amount,
    currency,
    termMonths,
    ratePercentX100,
    status,
    createdAt,
    openedAt,
    closesAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Deposit &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.accountId == this.accountId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.termMonths == this.termMonths &&
          other.ratePercentX100 == this.ratePercentX100 &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.openedAt == this.openedAt &&
          other.closesAt == this.closesAt);
}

class DepositsCompanion extends UpdateCompanion<Deposit> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<int?> accountId;
  final Value<int> amount;
  final Value<Currency> currency;
  final Value<int> termMonths;
  final Value<int> ratePercentX100;
  final Value<DepositStatus> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> openedAt;
  final Value<DateTime?> closesAt;
  const DepositsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.termMonths = const Value.absent(),
    this.ratePercentX100 = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closesAt = const Value.absent(),
  });
  DepositsCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    this.accountId = const Value.absent(),
    required int amount,
    required Currency currency,
    required int termMonths,
    this.ratePercentX100 = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closesAt = const Value.absent(),
  }) : clientId = Value(clientId),
       amount = Value(amount),
       currency = Value(currency),
       termMonths = Value(termMonths);
  static Insertable<Deposit> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<int>? accountId,
    Expression<int>? amount,
    Expression<int>? currency,
    Expression<int>? termMonths,
    Expression<int>? ratePercentX100,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closesAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (accountId != null) 'account_id': accountId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (termMonths != null) 'term_months': termMonths,
      if (ratePercentX100 != null) 'rate_percent_x100': ratePercentX100,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (openedAt != null) 'opened_at': openedAt,
      if (closesAt != null) 'closes_at': closesAt,
    });
  }

  DepositsCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<int?>? accountId,
    Value<int>? amount,
    Value<Currency>? currency,
    Value<int>? termMonths,
    Value<int>? ratePercentX100,
    Value<DepositStatus>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? openedAt,
    Value<DateTime?>? closesAt,
  }) {
    return DepositsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      termMonths: termMonths ?? this.termMonths,
      ratePercentX100: ratePercentX100 ?? this.ratePercentX100,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      openedAt: openedAt ?? this.openedAt,
      closesAt: closesAt ?? this.closesAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(
        $DepositsTable.$convertercurrency.toSql(currency.value),
      );
    }
    if (termMonths.present) {
      map['term_months'] = Variable<int>(termMonths.value);
    }
    if (ratePercentX100.present) {
      map['rate_percent_x100'] = Variable<int>(ratePercentX100.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $DepositsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closesAt.present) {
      map['closes_at'] = Variable<DateTime>(closesAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepositsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('accountId: $accountId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('termMonths: $termMonths, ')
          ..write('ratePercentX100: $ratePercentX100, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('openedAt: $openedAt, ')
          ..write('closesAt: $closesAt')
          ..write(')'))
        .toString();
  }
}

class $LoanApplicationsTable extends LoanApplications
    with TableInfo<$LoanApplicationsTable, LoanApplication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanApplicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _createdByEmployeeIdMeta =
      const VerificationMeta('createdByEmployeeId');
  @override
  late final GeneratedColumn<int> createdByEmployeeId = GeneratedColumn<int>(
    'created_by_employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _decidedByEmployeeIdMeta =
      const VerificationMeta('decidedByEmployeeId');
  @override
  late final GeneratedColumn<int> decidedByEmployeeId = GeneratedColumn<int>(
    'decided_by_employee_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Currency, int> currency =
      GeneratedColumn<int>(
        'currency',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Currency>($LoanApplicationsTable.$convertercurrency);
  static const VerificationMeta _termMonthsMeta = const VerificationMeta(
    'termMonths',
  );
  @override
  late final GeneratedColumn<int> termMonths = GeneratedColumn<int>(
    'term_months',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LoanApplicationStatus, int>
  status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(LoanApplicationStatus.pending.index),
      ).withConverter<LoanApplicationStatus>(
        $LoanApplicationsTable.$converterstatus,
      );
  static const VerificationMeta _rejectReasonMeta = const VerificationMeta(
    'rejectReason',
  );
  @override
  late final GeneratedColumn<String> rejectReason = GeneratedColumn<String>(
    'reject_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _decidedAtMeta = const VerificationMeta(
    'decidedAt',
  );
  @override
  late final GeneratedColumn<DateTime> decidedAt = GeneratedColumn<DateTime>(
    'decided_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    createdByEmployeeId,
    decidedByEmployeeId,
    amount,
    currency,
    termMonths,
    status,
    rejectReason,
    createdAt,
    decidedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_applications';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoanApplication> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('created_by_employee_id')) {
      context.handle(
        _createdByEmployeeIdMeta,
        createdByEmployeeId.isAcceptableOrUnknown(
          data['created_by_employee_id']!,
          _createdByEmployeeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdByEmployeeIdMeta);
    }
    if (data.containsKey('decided_by_employee_id')) {
      context.handle(
        _decidedByEmployeeIdMeta,
        decidedByEmployeeId.isAcceptableOrUnknown(
          data['decided_by_employee_id']!,
          _decidedByEmployeeIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('term_months')) {
      context.handle(
        _termMonthsMeta,
        termMonths.isAcceptableOrUnknown(data['term_months']!, _termMonthsMeta),
      );
    } else if (isInserting) {
      context.missing(_termMonthsMeta);
    }
    if (data.containsKey('reject_reason')) {
      context.handle(
        _rejectReasonMeta,
        rejectReason.isAcceptableOrUnknown(
          data['reject_reason']!,
          _rejectReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('decided_at')) {
      context.handle(
        _decidedAtMeta,
        decidedAt.isAcceptableOrUnknown(data['decided_at']!, _decidedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanApplication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanApplication(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      createdByEmployeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_by_employee_id'],
      )!,
      decidedByEmployeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}decided_by_employee_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: $LoanApplicationsTable.$convertercurrency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}currency'],
        )!,
      ),
      termMonths: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}term_months'],
      )!,
      status: $LoanApplicationsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      rejectReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reject_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      decidedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}decided_at'],
      ),
    );
  }

  @override
  $LoanApplicationsTable createAlias(String alias) {
    return $LoanApplicationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Currency, int, int> $convertercurrency =
      const EnumIndexConverter<Currency>(Currency.values);
  static JsonTypeConverter2<LoanApplicationStatus, int, int> $converterstatus =
      const EnumIndexConverter<LoanApplicationStatus>(
        LoanApplicationStatus.values,
      );
}

class LoanApplication extends DataClass implements Insertable<LoanApplication> {
  final int id;
  final int clientId;
  final int createdByEmployeeId;
  final int? decidedByEmployeeId;
  final int amount;
  final Currency currency;
  final int termMonths;
  final LoanApplicationStatus status;
  final String? rejectReason;
  final DateTime createdAt;
  final DateTime? decidedAt;
  const LoanApplication({
    required this.id,
    required this.clientId,
    required this.createdByEmployeeId,
    this.decidedByEmployeeId,
    required this.amount,
    required this.currency,
    required this.termMonths,
    required this.status,
    this.rejectReason,
    required this.createdAt,
    this.decidedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['created_by_employee_id'] = Variable<int>(createdByEmployeeId);
    if (!nullToAbsent || decidedByEmployeeId != null) {
      map['decided_by_employee_id'] = Variable<int>(decidedByEmployeeId);
    }
    map['amount'] = Variable<int>(amount);
    {
      map['currency'] = Variable<int>(
        $LoanApplicationsTable.$convertercurrency.toSql(currency),
      );
    }
    map['term_months'] = Variable<int>(termMonths);
    {
      map['status'] = Variable<int>(
        $LoanApplicationsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || rejectReason != null) {
      map['reject_reason'] = Variable<String>(rejectReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || decidedAt != null) {
      map['decided_at'] = Variable<DateTime>(decidedAt);
    }
    return map;
  }

  LoanApplicationsCompanion toCompanion(bool nullToAbsent) {
    return LoanApplicationsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      createdByEmployeeId: Value(createdByEmployeeId),
      decidedByEmployeeId: decidedByEmployeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedByEmployeeId),
      amount: Value(amount),
      currency: Value(currency),
      termMonths: Value(termMonths),
      status: Value(status),
      rejectReason: rejectReason == null && nullToAbsent
          ? const Value.absent()
          : Value(rejectReason),
      createdAt: Value(createdAt),
      decidedAt: decidedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(decidedAt),
    );
  }

  factory LoanApplication.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanApplication(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      createdByEmployeeId: serializer.fromJson<int>(
        json['createdByEmployeeId'],
      ),
      decidedByEmployeeId: serializer.fromJson<int?>(
        json['decidedByEmployeeId'],
      ),
      amount: serializer.fromJson<int>(json['amount']),
      currency: $LoanApplicationsTable.$convertercurrency.fromJson(
        serializer.fromJson<int>(json['currency']),
      ),
      termMonths: serializer.fromJson<int>(json['termMonths']),
      status: $LoanApplicationsTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      rejectReason: serializer.fromJson<String?>(json['rejectReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      decidedAt: serializer.fromJson<DateTime?>(json['decidedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'createdByEmployeeId': serializer.toJson<int>(createdByEmployeeId),
      'decidedByEmployeeId': serializer.toJson<int?>(decidedByEmployeeId),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<int>(
        $LoanApplicationsTable.$convertercurrency.toJson(currency),
      ),
      'termMonths': serializer.toJson<int>(termMonths),
      'status': serializer.toJson<int>(
        $LoanApplicationsTable.$converterstatus.toJson(status),
      ),
      'rejectReason': serializer.toJson<String?>(rejectReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'decidedAt': serializer.toJson<DateTime?>(decidedAt),
    };
  }

  LoanApplication copyWith({
    int? id,
    int? clientId,
    int? createdByEmployeeId,
    Value<int?> decidedByEmployeeId = const Value.absent(),
    int? amount,
    Currency? currency,
    int? termMonths,
    LoanApplicationStatus? status,
    Value<String?> rejectReason = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> decidedAt = const Value.absent(),
  }) => LoanApplication(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    createdByEmployeeId: createdByEmployeeId ?? this.createdByEmployeeId,
    decidedByEmployeeId: decidedByEmployeeId.present
        ? decidedByEmployeeId.value
        : this.decidedByEmployeeId,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    termMonths: termMonths ?? this.termMonths,
    status: status ?? this.status,
    rejectReason: rejectReason.present ? rejectReason.value : this.rejectReason,
    createdAt: createdAt ?? this.createdAt,
    decidedAt: decidedAt.present ? decidedAt.value : this.decidedAt,
  );
  LoanApplication copyWithCompanion(LoanApplicationsCompanion data) {
    return LoanApplication(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      createdByEmployeeId: data.createdByEmployeeId.present
          ? data.createdByEmployeeId.value
          : this.createdByEmployeeId,
      decidedByEmployeeId: data.decidedByEmployeeId.present
          ? data.decidedByEmployeeId.value
          : this.decidedByEmployeeId,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      termMonths: data.termMonths.present
          ? data.termMonths.value
          : this.termMonths,
      status: data.status.present ? data.status.value : this.status,
      rejectReason: data.rejectReason.present
          ? data.rejectReason.value
          : this.rejectReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      decidedAt: data.decidedAt.present ? data.decidedAt.value : this.decidedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanApplication(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('createdByEmployeeId: $createdByEmployeeId, ')
          ..write('decidedByEmployeeId: $decidedByEmployeeId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('termMonths: $termMonths, ')
          ..write('status: $status, ')
          ..write('rejectReason: $rejectReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('decidedAt: $decidedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    createdByEmployeeId,
    decidedByEmployeeId,
    amount,
    currency,
    termMonths,
    status,
    rejectReason,
    createdAt,
    decidedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanApplication &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.createdByEmployeeId == this.createdByEmployeeId &&
          other.decidedByEmployeeId == this.decidedByEmployeeId &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.termMonths == this.termMonths &&
          other.status == this.status &&
          other.rejectReason == this.rejectReason &&
          other.createdAt == this.createdAt &&
          other.decidedAt == this.decidedAt);
}

class LoanApplicationsCompanion extends UpdateCompanion<LoanApplication> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<int> createdByEmployeeId;
  final Value<int?> decidedByEmployeeId;
  final Value<int> amount;
  final Value<Currency> currency;
  final Value<int> termMonths;
  final Value<LoanApplicationStatus> status;
  final Value<String?> rejectReason;
  final Value<DateTime> createdAt;
  final Value<DateTime?> decidedAt;
  const LoanApplicationsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.createdByEmployeeId = const Value.absent(),
    this.decidedByEmployeeId = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.termMonths = const Value.absent(),
    this.status = const Value.absent(),
    this.rejectReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.decidedAt = const Value.absent(),
  });
  LoanApplicationsCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required int createdByEmployeeId,
    this.decidedByEmployeeId = const Value.absent(),
    required int amount,
    required Currency currency,
    required int termMonths,
    this.status = const Value.absent(),
    this.rejectReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.decidedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       createdByEmployeeId = Value(createdByEmployeeId),
       amount = Value(amount),
       currency = Value(currency),
       termMonths = Value(termMonths);
  static Insertable<LoanApplication> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<int>? createdByEmployeeId,
    Expression<int>? decidedByEmployeeId,
    Expression<int>? amount,
    Expression<int>? currency,
    Expression<int>? termMonths,
    Expression<int>? status,
    Expression<String>? rejectReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? decidedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (createdByEmployeeId != null)
        'created_by_employee_id': createdByEmployeeId,
      if (decidedByEmployeeId != null)
        'decided_by_employee_id': decidedByEmployeeId,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (termMonths != null) 'term_months': termMonths,
      if (status != null) 'status': status,
      if (rejectReason != null) 'reject_reason': rejectReason,
      if (createdAt != null) 'created_at': createdAt,
      if (decidedAt != null) 'decided_at': decidedAt,
    });
  }

  LoanApplicationsCompanion copyWith({
    Value<int>? id,
    Value<int>? clientId,
    Value<int>? createdByEmployeeId,
    Value<int?>? decidedByEmployeeId,
    Value<int>? amount,
    Value<Currency>? currency,
    Value<int>? termMonths,
    Value<LoanApplicationStatus>? status,
    Value<String?>? rejectReason,
    Value<DateTime>? createdAt,
    Value<DateTime?>? decidedAt,
  }) {
    return LoanApplicationsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      createdByEmployeeId: createdByEmployeeId ?? this.createdByEmployeeId,
      decidedByEmployeeId: decidedByEmployeeId ?? this.decidedByEmployeeId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      termMonths: termMonths ?? this.termMonths,
      status: status ?? this.status,
      rejectReason: rejectReason ?? this.rejectReason,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt ?? this.decidedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (createdByEmployeeId.present) {
      map['created_by_employee_id'] = Variable<int>(createdByEmployeeId.value);
    }
    if (decidedByEmployeeId.present) {
      map['decided_by_employee_id'] = Variable<int>(decidedByEmployeeId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<int>(
        $LoanApplicationsTable.$convertercurrency.toSql(currency.value),
      );
    }
    if (termMonths.present) {
      map['term_months'] = Variable<int>(termMonths.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $LoanApplicationsTable.$converterstatus.toSql(status.value),
      );
    }
    if (rejectReason.present) {
      map['reject_reason'] = Variable<String>(rejectReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (decidedAt.present) {
      map['decided_at'] = Variable<DateTime>(decidedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoanApplicationsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('createdByEmployeeId: $createdByEmployeeId, ')
          ..write('decidedByEmployeeId: $decidedByEmployeeId, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('termMonths: $termMonths, ')
          ..write('status: $status, ')
          ..write('rejectReason: $rejectReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('decidedAt: $decidedAt')
          ..write(')'))
        .toString();
  }
}

class $LoansTable extends Loans with TableInfo<$LoansTable, Loan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _applicationIdMeta = const VerificationMeta(
    'applicationId',
  );
  @override
  late final GeneratedColumn<int> applicationId = GeneratedColumn<int>(
    'application_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES loan_applications (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts (id)',
    ),
  );
  static const VerificationMeta _principalMeta = const VerificationMeta(
    'principal',
  );
  @override
  late final GeneratedColumn<int> principal = GeneratedColumn<int>(
    'principal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMeta = const VerificationMeta(
    'remaining',
  );
  @override
  late final GeneratedColumn<int> remaining = GeneratedColumn<int>(
    'remaining',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePercentX100Meta = const VerificationMeta(
    'ratePercentX100',
  );
  @override
  late final GeneratedColumn<int> ratePercentX100 = GeneratedColumn<int>(
    'rate_percent_x100',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LoanStatus, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(LoanStatus.active.index),
      ).withConverter<LoanStatus>($LoansTable.$converterstatus);
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    applicationId,
    accountId,
    principal,
    remaining,
    ratePercentX100,
    status,
    issuedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Loan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('application_id')) {
      context.handle(
        _applicationIdMeta,
        applicationId.isAcceptableOrUnknown(
          data['application_id']!,
          _applicationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_applicationIdMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('principal')) {
      context.handle(
        _principalMeta,
        principal.isAcceptableOrUnknown(data['principal']!, _principalMeta),
      );
    } else if (isInserting) {
      context.missing(_principalMeta);
    }
    if (data.containsKey('remaining')) {
      context.handle(
        _remainingMeta,
        remaining.isAcceptableOrUnknown(data['remaining']!, _remainingMeta),
      );
    } else if (isInserting) {
      context.missing(_remainingMeta);
    }
    if (data.containsKey('rate_percent_x100')) {
      context.handle(
        _ratePercentX100Meta,
        ratePercentX100.isAcceptableOrUnknown(
          data['rate_percent_x100']!,
          _ratePercentX100Meta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratePercentX100Meta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Loan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Loan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      applicationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}application_id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      principal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}principal'],
      )!,
      remaining: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining'],
      )!,
      ratePercentX100: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rate_percent_x100'],
      )!,
      status: $LoansTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      )!,
    );
  }

  @override
  $LoansTable createAlias(String alias) {
    return $LoansTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LoanStatus, int, int> $converterstatus =
      const EnumIndexConverter<LoanStatus>(LoanStatus.values);
}

class Loan extends DataClass implements Insertable<Loan> {
  final int id;
  final int applicationId;
  final int accountId;
  final int principal;
  final int remaining;
  final int ratePercentX100;
  final LoanStatus status;
  final DateTime issuedAt;
  const Loan({
    required this.id,
    required this.applicationId,
    required this.accountId,
    required this.principal,
    required this.remaining,
    required this.ratePercentX100,
    required this.status,
    required this.issuedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['application_id'] = Variable<int>(applicationId);
    map['account_id'] = Variable<int>(accountId);
    map['principal'] = Variable<int>(principal);
    map['remaining'] = Variable<int>(remaining);
    map['rate_percent_x100'] = Variable<int>(ratePercentX100);
    {
      map['status'] = Variable<int>($LoansTable.$converterstatus.toSql(status));
    }
    map['issued_at'] = Variable<DateTime>(issuedAt);
    return map;
  }

  LoansCompanion toCompanion(bool nullToAbsent) {
    return LoansCompanion(
      id: Value(id),
      applicationId: Value(applicationId),
      accountId: Value(accountId),
      principal: Value(principal),
      remaining: Value(remaining),
      ratePercentX100: Value(ratePercentX100),
      status: Value(status),
      issuedAt: Value(issuedAt),
    );
  }

  factory Loan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Loan(
      id: serializer.fromJson<int>(json['id']),
      applicationId: serializer.fromJson<int>(json['applicationId']),
      accountId: serializer.fromJson<int>(json['accountId']),
      principal: serializer.fromJson<int>(json['principal']),
      remaining: serializer.fromJson<int>(json['remaining']),
      ratePercentX100: serializer.fromJson<int>(json['ratePercentX100']),
      status: $LoansTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'applicationId': serializer.toJson<int>(applicationId),
      'accountId': serializer.toJson<int>(accountId),
      'principal': serializer.toJson<int>(principal),
      'remaining': serializer.toJson<int>(remaining),
      'ratePercentX100': serializer.toJson<int>(ratePercentX100),
      'status': serializer.toJson<int>(
        $LoansTable.$converterstatus.toJson(status),
      ),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
    };
  }

  Loan copyWith({
    int? id,
    int? applicationId,
    int? accountId,
    int? principal,
    int? remaining,
    int? ratePercentX100,
    LoanStatus? status,
    DateTime? issuedAt,
  }) => Loan(
    id: id ?? this.id,
    applicationId: applicationId ?? this.applicationId,
    accountId: accountId ?? this.accountId,
    principal: principal ?? this.principal,
    remaining: remaining ?? this.remaining,
    ratePercentX100: ratePercentX100 ?? this.ratePercentX100,
    status: status ?? this.status,
    issuedAt: issuedAt ?? this.issuedAt,
  );
  Loan copyWithCompanion(LoansCompanion data) {
    return Loan(
      id: data.id.present ? data.id.value : this.id,
      applicationId: data.applicationId.present
          ? data.applicationId.value
          : this.applicationId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      principal: data.principal.present ? data.principal.value : this.principal,
      remaining: data.remaining.present ? data.remaining.value : this.remaining,
      ratePercentX100: data.ratePercentX100.present
          ? data.ratePercentX100.value
          : this.ratePercentX100,
      status: data.status.present ? data.status.value : this.status,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Loan(')
          ..write('id: $id, ')
          ..write('applicationId: $applicationId, ')
          ..write('accountId: $accountId, ')
          ..write('principal: $principal, ')
          ..write('remaining: $remaining, ')
          ..write('ratePercentX100: $ratePercentX100, ')
          ..write('status: $status, ')
          ..write('issuedAt: $issuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    applicationId,
    accountId,
    principal,
    remaining,
    ratePercentX100,
    status,
    issuedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Loan &&
          other.id == this.id &&
          other.applicationId == this.applicationId &&
          other.accountId == this.accountId &&
          other.principal == this.principal &&
          other.remaining == this.remaining &&
          other.ratePercentX100 == this.ratePercentX100 &&
          other.status == this.status &&
          other.issuedAt == this.issuedAt);
}

class LoansCompanion extends UpdateCompanion<Loan> {
  final Value<int> id;
  final Value<int> applicationId;
  final Value<int> accountId;
  final Value<int> principal;
  final Value<int> remaining;
  final Value<int> ratePercentX100;
  final Value<LoanStatus> status;
  final Value<DateTime> issuedAt;
  const LoansCompanion({
    this.id = const Value.absent(),
    this.applicationId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.principal = const Value.absent(),
    this.remaining = const Value.absent(),
    this.ratePercentX100 = const Value.absent(),
    this.status = const Value.absent(),
    this.issuedAt = const Value.absent(),
  });
  LoansCompanion.insert({
    this.id = const Value.absent(),
    required int applicationId,
    required int accountId,
    required int principal,
    required int remaining,
    required int ratePercentX100,
    this.status = const Value.absent(),
    this.issuedAt = const Value.absent(),
  }) : applicationId = Value(applicationId),
       accountId = Value(accountId),
       principal = Value(principal),
       remaining = Value(remaining),
       ratePercentX100 = Value(ratePercentX100);
  static Insertable<Loan> custom({
    Expression<int>? id,
    Expression<int>? applicationId,
    Expression<int>? accountId,
    Expression<int>? principal,
    Expression<int>? remaining,
    Expression<int>? ratePercentX100,
    Expression<int>? status,
    Expression<DateTime>? issuedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (applicationId != null) 'application_id': applicationId,
      if (accountId != null) 'account_id': accountId,
      if (principal != null) 'principal': principal,
      if (remaining != null) 'remaining': remaining,
      if (ratePercentX100 != null) 'rate_percent_x100': ratePercentX100,
      if (status != null) 'status': status,
      if (issuedAt != null) 'issued_at': issuedAt,
    });
  }

  LoansCompanion copyWith({
    Value<int>? id,
    Value<int>? applicationId,
    Value<int>? accountId,
    Value<int>? principal,
    Value<int>? remaining,
    Value<int>? ratePercentX100,
    Value<LoanStatus>? status,
    Value<DateTime>? issuedAt,
  }) {
    return LoansCompanion(
      id: id ?? this.id,
      applicationId: applicationId ?? this.applicationId,
      accountId: accountId ?? this.accountId,
      principal: principal ?? this.principal,
      remaining: remaining ?? this.remaining,
      ratePercentX100: ratePercentX100 ?? this.ratePercentX100,
      status: status ?? this.status,
      issuedAt: issuedAt ?? this.issuedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (applicationId.present) {
      map['application_id'] = Variable<int>(applicationId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (principal.present) {
      map['principal'] = Variable<int>(principal.value);
    }
    if (remaining.present) {
      map['remaining'] = Variable<int>(remaining.value);
    }
    if (ratePercentX100.present) {
      map['rate_percent_x100'] = Variable<int>(ratePercentX100.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $LoansTable.$converterstatus.toSql(status.value),
      );
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoansCompanion(')
          ..write('id: $id, ')
          ..write('applicationId: $applicationId, ')
          ..write('accountId: $accountId, ')
          ..write('principal: $principal, ')
          ..write('remaining: $remaining, ')
          ..write('ratePercentX100: $ratePercentX100, ')
          ..write('status: $status, ')
          ..write('issuedAt: $issuedAt')
          ..write(')'))
        .toString();
  }
}

class $LoanPaymentsTable extends LoanPayments
    with TableInfo<$LoanPaymentsTable, LoanPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoanPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<int> loanId = GeneratedColumn<int>(
    'loan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES loans (id)',
    ),
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, int> method =
      GeneratedColumn<int>(
        'method',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<PaymentMethod>($LoanPaymentsTable.$convertermethod);
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    loanId,
    employeeId,
    amount,
    method,
    paidAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loan_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoanPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('loan_id')) {
      context.handle(
        _loanIdMeta,
        loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_loanIdMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoanPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoanPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      loanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loan_id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      method: $LoanPaymentsTable.$convertermethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}method'],
        )!,
      ),
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
    );
  }

  @override
  $LoanPaymentsTable createAlias(String alias) {
    return $LoanPaymentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, int, int> $convertermethod =
      const EnumIndexConverter<PaymentMethod>(PaymentMethod.values);
}

class LoanPayment extends DataClass implements Insertable<LoanPayment> {
  final int id;
  final int loanId;
  final int employeeId;
  final int amount;
  final PaymentMethod method;
  final DateTime paidAt;
  const LoanPayment({
    required this.id,
    required this.loanId,
    required this.employeeId,
    required this.amount,
    required this.method,
    required this.paidAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['loan_id'] = Variable<int>(loanId);
    map['employee_id'] = Variable<int>(employeeId);
    map['amount'] = Variable<int>(amount);
    {
      map['method'] = Variable<int>(
        $LoanPaymentsTable.$convertermethod.toSql(method),
      );
    }
    map['paid_at'] = Variable<DateTime>(paidAt);
    return map;
  }

  LoanPaymentsCompanion toCompanion(bool nullToAbsent) {
    return LoanPaymentsCompanion(
      id: Value(id),
      loanId: Value(loanId),
      employeeId: Value(employeeId),
      amount: Value(amount),
      method: Value(method),
      paidAt: Value(paidAt),
    );
  }

  factory LoanPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoanPayment(
      id: serializer.fromJson<int>(json['id']),
      loanId: serializer.fromJson<int>(json['loanId']),
      employeeId: serializer.fromJson<int>(json['employeeId']),
      amount: serializer.fromJson<int>(json['amount']),
      method: $LoanPaymentsTable.$convertermethod.fromJson(
        serializer.fromJson<int>(json['method']),
      ),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'loanId': serializer.toJson<int>(loanId),
      'employeeId': serializer.toJson<int>(employeeId),
      'amount': serializer.toJson<int>(amount),
      'method': serializer.toJson<int>(
        $LoanPaymentsTable.$convertermethod.toJson(method),
      ),
      'paidAt': serializer.toJson<DateTime>(paidAt),
    };
  }

  LoanPayment copyWith({
    int? id,
    int? loanId,
    int? employeeId,
    int? amount,
    PaymentMethod? method,
    DateTime? paidAt,
  }) => LoanPayment(
    id: id ?? this.id,
    loanId: loanId ?? this.loanId,
    employeeId: employeeId ?? this.employeeId,
    amount: amount ?? this.amount,
    method: method ?? this.method,
    paidAt: paidAt ?? this.paidAt,
  );
  LoanPayment copyWithCompanion(LoanPaymentsCompanion data) {
    return LoanPayment(
      id: data.id.present ? data.id.value : this.id,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      amount: data.amount.present ? data.amount.value : this.amount,
      method: data.method.present ? data.method.value : this.method,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoanPayment(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('employeeId: $employeeId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, loanId, employeeId, amount, method, paidAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoanPayment &&
          other.id == this.id &&
          other.loanId == this.loanId &&
          other.employeeId == this.employeeId &&
          other.amount == this.amount &&
          other.method == this.method &&
          other.paidAt == this.paidAt);
}

class LoanPaymentsCompanion extends UpdateCompanion<LoanPayment> {
  final Value<int> id;
  final Value<int> loanId;
  final Value<int> employeeId;
  final Value<int> amount;
  final Value<PaymentMethod> method;
  final Value<DateTime> paidAt;
  const LoanPaymentsCompanion({
    this.id = const Value.absent(),
    this.loanId = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.amount = const Value.absent(),
    this.method = const Value.absent(),
    this.paidAt = const Value.absent(),
  });
  LoanPaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int loanId,
    required int employeeId,
    required int amount,
    required PaymentMethod method,
    this.paidAt = const Value.absent(),
  }) : loanId = Value(loanId),
       employeeId = Value(employeeId),
       amount = Value(amount),
       method = Value(method);
  static Insertable<LoanPayment> custom({
    Expression<int>? id,
    Expression<int>? loanId,
    Expression<int>? employeeId,
    Expression<int>? amount,
    Expression<int>? method,
    Expression<DateTime>? paidAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loanId != null) 'loan_id': loanId,
      if (employeeId != null) 'employee_id': employeeId,
      if (amount != null) 'amount': amount,
      if (method != null) 'method': method,
      if (paidAt != null) 'paid_at': paidAt,
    });
  }

  LoanPaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? loanId,
    Value<int>? employeeId,
    Value<int>? amount,
    Value<PaymentMethod>? method,
    Value<DateTime>? paidAt,
  }) {
    return LoanPaymentsCompanion(
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      employeeId: employeeId ?? this.employeeId,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      paidAt: paidAt ?? this.paidAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<int>(loanId.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (method.present) {
      map['method'] = Variable<int>(
        $LoanPaymentsTable.$convertermethod.toSql(method.value),
      );
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoanPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('loanId: $loanId, ')
          ..write('employeeId: $employeeId, ')
          ..write('amount: $amount, ')
          ..write('method: $method, ')
          ..write('paidAt: $paidAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $BankCardsTable bankCards = $BankCardsTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $DepositsTable deposits = $DepositsTable(this);
  late final $LoanApplicationsTable loanApplications = $LoanApplicationsTable(
    this,
  );
  late final $LoansTable loans = $LoansTable(this);
  late final $LoanPaymentsTable loanPayments = $LoanPaymentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    clients,
    employees,
    accounts,
    bankCards,
    exchangeRates,
    transactions,
    deposits,
    loanApplications,
    loans,
    loanPayments,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('clients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'users',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('employees', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String login,
  required String passwordHash,
  required UserRole role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> login,
  Value<String> passwordHash,
  Value<UserRole> role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClientsTable, List<Client>> _clientsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.clients,
    aliasName: 'users__id__clients__user_id',
  );

  $$ClientsTableProcessedTableManager get clientsRefs {
    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_clientsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EmployeesTable, List<Employee>>
  _employeesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.employees,
    aliasName: 'users__id__employees__user_id',
  );

  $$EmployeesTableProcessedTableManager get employeesRefs {
    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_employeesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UserRole, UserRole, int> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> clientsRefs(
    Expression<bool> Function($$ClientsTableFilterComposer f) f,
  ) {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> employeesRefs(
    Expression<bool> Function($$EmployeesTableFilterComposer f) f,
  ) {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get login =>
      $composableBuilder(column: $table.login, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<UserRole, int> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> clientsRefs<T extends Object>(
    Expression<T> Function($$ClientsTableAnnotationComposer a) f,
  ) {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> employeesRefs<T extends Object>(
    Expression<T> Function($$EmployeesTableAnnotationComposer a) f,
  ) {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool clientsRefs, bool employeesRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> login = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<UserRole> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                login: login,
                passwordHash: passwordHash,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String login,
                required String passwordHash,
                required UserRole role,
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                login: login,
                passwordHash: passwordHash,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clientsRefs = false, employeesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (clientsRefs) db.clients,
                    if (employeesRefs) db.employees,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (clientsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Client>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._clientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(db, table, p0).clientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (employeesRefs)
                        await $_getPrefetchedData<User, $UsersTable, Employee>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._employeesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).employeesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool clientsRefs, bool employeesRefs})
    >;
typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  required int userId,
  required String fullName,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> passportNumber,
  Value<DateTime?> birthDate,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> fullName,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> passportNumber,
  Value<DateTime?> birthDate,
});

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('clients__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AccountsTable, List<Account>> _accountsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.accounts,
    aliasName: 'clients__id__accounts__client_id',
  );

  $$AccountsTableProcessedTableManager get accountsRefs {
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepositsTable, List<Deposit>> _depositsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.deposits,
    aliasName: 'clients__id__deposits__client_id',
  );

  $$DepositsTableProcessedTableManager get depositsRefs {
    final manager = $$DepositsTableTableManager(
      $_db,
      $_db.deposits,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_depositsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LoanApplicationsTable, List<LoanApplication>>
  _loanApplicationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.loanApplications,
    aliasName: 'clients__id__loan_applications__client_id',
  );

  $$LoanApplicationsTableProcessedTableManager get loanApplicationsRefs {
    final manager = $$LoanApplicationsTableTableManager(
      $_db,
      $_db.loanApplications,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _loanApplicationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> accountsRefs(
    Expression<bool> Function($$AccountsTableFilterComposer f) f,
  ) {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> depositsRefs(
    Expression<bool> Function($$DepositsTableFilterComposer f) f,
  ) {
    final $$DepositsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableFilterComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> loanApplicationsRefs(
    Expression<bool> Function($$LoanApplicationsTableFilterComposer f) f,
  ) {
    final $$LoanApplicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanApplications,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanApplicationsTableFilterComposer(
            $db: $db,
            $table: $db.loanApplications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passportNumber => $composableBuilder(
    column: $table.passportNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> accountsRefs<T extends Object>(
    Expression<T> Function($$AccountsTableAnnotationComposer a) f,
  ) {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> depositsRefs<T extends Object>(
    Expression<T> Function($$DepositsTableAnnotationComposer a) f,
  ) {
    final $$DepositsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableAnnotationComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> loanApplicationsRefs<T extends Object>(
    Expression<T> Function($$LoanApplicationsTableAnnotationComposer a) f,
  ) {
    final $$LoanApplicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanApplications,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanApplicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.loanApplications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({
            bool userId,
            bool accountsRefs,
            bool depositsRefs,
            bool loanApplicationsRefs,
          })
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passportNumber = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                userId: userId,
                fullName: fullName,
                phone: phone,
                email: email,
                passportNumber: passportNumber,
                birthDate: birthDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String fullName,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passportNumber = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                userId: userId,
                fullName: fullName,
                phone: phone,
                email: email,
                passportNumber: passportNumber,
                birthDate: birthDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClientsTable, Client>(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                accountsRefs = false,
                depositsRefs = false,
                loanApplicationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (accountsRefs) db.accounts,
                    if (depositsRefs) db.deposits,
                    if (loanApplicationsRefs) db.loanApplications,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$ClientsTableReferences
                                ._userIdTable(db),
                            referencedColumn: $$ClientsTableReferences
                                ._userIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (accountsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Account
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._accountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).accountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (depositsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          Deposit
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._depositsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).depositsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (loanApplicationsRefs)
                        await $_getPrefetchedData<
                          Client,
                          $ClientsTable,
                          LoanApplication
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._loanApplicationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).loanApplicationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.clientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({
        bool userId,
        bool accountsRefs,
        bool depositsRefs,
        bool loanApplicationsRefs,
      })
    >;
typedef $$EmployeesTableCreateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  required int userId,
  required String fullName,
  required String position,
});
typedef $$EmployeesTableUpdateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<String> fullName,
  Value<String> position,
});

final class $$EmployeesTableReferences
    extends BaseReferences<_$AppDatabase, $EmployeesTable, Employee> {
  $$EmployeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('employees__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LoanPaymentsTable, List<LoanPayment>>
  _loanPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.loanPayments,
    aliasName: 'employees__id__loan_payments__employee_id',
  );

  $$LoanPaymentsTableProcessedTableManager get loanPaymentsRefs {
    final manager = $$LoanPaymentsTableTableManager(
      $_db,
      $_db.loanPayments,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loanPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> loanPaymentsRefs(
    Expression<bool> Function($$LoanPaymentsTableFilterComposer f) f,
  ) {
    final $$LoanPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanPayments,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.loanPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> loanPaymentsRefs<T extends Object>(
    Expression<T> Function($$LoanPaymentsTableAnnotationComposer a) f,
  ) {
    final $$LoanPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanPayments,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.loanPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, $$EmployeesTableReferences),
          Employee,
          PrefetchHooks Function({bool userId, bool loanPaymentsRefs})
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> position = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                userId: userId,
                fullName: fullName,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String fullName,
                required String position,
              }) => EmployeesCompanion.insert(
                id: id,
                userId: userId,
                fullName: fullName,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmployeesTable, Employee>(table),
                  $$EmployeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, loanPaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (loanPaymentsRefs) db.loanPayments],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$EmployeesTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$EmployeesTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (loanPaymentsRefs)
                    await $_getPrefetchedData<
                      Employee,
                      $EmployeesTable,
                      LoanPayment
                    >(
                      currentTable: table,
                      referencedTable: $$EmployeesTableReferences
                          ._loanPaymentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EmployeesTableReferences(
                            db,
                            table,
                            p0,
                          ).loanPaymentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.employeeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, $$EmployeesTableReferences),
      Employee,
      PrefetchHooks Function({bool userId, bool loanPaymentsRefs})
    >;
typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  required int clientId,
  required String number,
  required AccountType type,
  required Currency currency,
  Value<int> balance,
  Value<AccountStatus> status,
  Value<DateTime> openedAt,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<int> id,
  Value<int> clientId,
  Value<String> number,
  Value<AccountType> type,
  Value<Currency> currency,
  Value<int> balance,
  Value<AccountStatus> status,
  Value<DateTime> openedAt,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, Account> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('accounts__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BankCardsTable, List<BankCard>>
  _bankCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bankCards,
    aliasName: 'accounts__id__bank_cards__account_id',
  );

  $$BankCardsTableProcessedTableManager get bankCardsRefs {
    final manager = $$BankCardsTableTableManager(
      $_db,
      $_db.bankCards,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bankCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepositsTable, List<Deposit>> _depositsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.deposits,
    aliasName: 'accounts__id__deposits__account_id',
  );

  $$DepositsTableProcessedTableManager get depositsRefs {
    final manager = $$DepositsTableTableManager(
      $_db,
      $_db.deposits,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_depositsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LoansTable, List<Loan>> _loansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.loans,
    aliasName: 'accounts__id__loans__account_id',
  );

  $$LoansTableProcessedTableManager get loansRefs {
    final manager = $$LoansTableTableManager(
      $_db,
      $_db.loans,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountType, AccountType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get currency =>
      $composableBuilder(
        column: $table.currency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AccountStatus, AccountStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bankCardsRefs(
    Expression<bool> Function($$BankCardsTableFilterComposer f) f,
  ) {
    final $$BankCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankCards,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankCardsTableFilterComposer(
            $db: $db,
            $table: $db.bankCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> depositsRefs(
    Expression<bool> Function($$DepositsTableFilterComposer f) f,
  ) {
    final $$DepositsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableFilterComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> loansRefs(
    Expression<bool> Function($$LoansTableFilterComposer f) f,
  ) {
    final $$LoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableFilterComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AccountStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bankCardsRefs<T extends Object>(
    Expression<T> Function($$BankCardsTableAnnotationComposer a) f,
  ) {
    final $$BankCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankCards,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> depositsRefs<T extends Object>(
    Expression<T> Function($$DepositsTableAnnotationComposer a) f,
  ) {
    final $$DepositsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.deposits,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepositsTableAnnotationComposer(
            $db: $db,
            $table: $db.deposits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> loansRefs<T extends Object>(
    Expression<T> Function($$LoansTableAnnotationComposer a) f,
  ) {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableAnnotationComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTable,
          Account,
          $$AccountsTableFilterComposer,
          $$AccountsTableOrderingComposer,
          $$AccountsTableAnnotationComposer,
          $$AccountsTableCreateCompanionBuilder,
          $$AccountsTableUpdateCompanionBuilder,
          (Account, $$AccountsTableReferences),
          Account,
          PrefetchHooks Function({
            bool clientId,
            bool bankCardsRefs,
            bool depositsRefs,
            bool loansRefs,
          })
        > {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<String> number = const Value.absent(),
                Value<AccountType> type = const Value.absent(),
                Value<Currency> currency = const Value.absent(),
                Value<int> balance = const Value.absent(),
                Value<AccountStatus> status = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
              }) => AccountsCompanion(
                id: id,
                clientId: clientId,
                number: number,
                type: type,
                currency: currency,
                balance: balance,
                status: status,
                openedAt: openedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                required String number,
                required AccountType type,
                required Currency currency,
                Value<int> balance = const Value.absent(),
                Value<AccountStatus> status = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
              }) => AccountsCompanion.insert(
                id: id,
                clientId: clientId,
                number: number,
                type: type,
                currency: currency,
                balance: balance,
                status: status,
                openedAt: openedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AccountsTable, Account>(table),
                  $$AccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                bankCardsRefs = false,
                depositsRefs = false,
                loansRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bankCardsRefs) db.bankCards,
                    if (depositsRefs) db.deposits,
                    if (loansRefs) db.loans,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.clientId,
                            referencedTable: $$AccountsTableReferences
                                ._clientIdTable(db),
                            referencedColumn: $$AccountsTableReferences
                                ._clientIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bankCardsRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          BankCard
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._bankCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).bankCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (depositsRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          Deposit
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._depositsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).depositsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (loansRefs)
                        await $_getPrefetchedData<
                          Account,
                          $AccountsTable,
                          Loan
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableReferences
                              ._loansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).loansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTable,
      Account,
      $$AccountsTableFilterComposer,
      $$AccountsTableOrderingComposer,
      $$AccountsTableAnnotationComposer,
      $$AccountsTableCreateCompanionBuilder,
      $$AccountsTableUpdateCompanionBuilder,
      (Account, $$AccountsTableReferences),
      Account,
      PrefetchHooks Function({
        bool clientId,
        bool bankCardsRefs,
        bool depositsRefs,
        bool loansRefs,
      })
    >;
typedef $$BankCardsTableCreateCompanionBuilder = BankCardsCompanion Function({
  Value<int> id,
  required int accountId,
  Value<String?> number,
  required String holderName,
  Value<DateTime?> expiresAt,
  Value<CardStatus> status,
  Value<DateTime> requestedAt,
  Value<DateTime?> blockedAt,
  Value<String?> blockReason,
});
typedef $$BankCardsTableUpdateCompanionBuilder = BankCardsCompanion Function({
  Value<int> id,
  Value<int> accountId,
  Value<String?> number,
  Value<String> holderName,
  Value<DateTime?> expiresAt,
  Value<CardStatus> status,
  Value<DateTime> requestedAt,
  Value<DateTime?> blockedAt,
  Value<String?> blockReason,
});

final class $$BankCardsTableReferences
    extends BaseReferences<_$AppDatabase, $BankCardsTable, BankCard> {
  $$BankCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('bank_cards__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BankCardsTableFilterComposer
    extends Composer<_$AppDatabase, $BankCardsTable> {
  $$BankCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CardStatus, CardStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get blockedAt => $composableBuilder(
    column: $table.blockedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $BankCardsTable> {
  $$BankCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get blockedAt => $composableBuilder(
    column: $table.blockedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankCardsTable> {
  $$BankCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get holderName => $composableBuilder(
    column: $table.holderName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CardStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
    column: $table.requestedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get blockedAt =>
      $composableBuilder(column: $table.blockedAt, builder: (column) => column);

  GeneratedColumn<String> get blockReason => $composableBuilder(
    column: $table.blockReason,
    builder: (column) => column,
  );

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankCardsTable,
          BankCard,
          $$BankCardsTableFilterComposer,
          $$BankCardsTableOrderingComposer,
          $$BankCardsTableAnnotationComposer,
          $$BankCardsTableCreateCompanionBuilder,
          $$BankCardsTableUpdateCompanionBuilder,
          (BankCard, $$BankCardsTableReferences),
          BankCard,
          PrefetchHooks Function({bool accountId})
        > {
  $$BankCardsTableTableManager(_$AppDatabase db, $BankCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> holderName = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<CardStatus> status = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<DateTime?> blockedAt = const Value.absent(),
                Value<String?> blockReason = const Value.absent(),
              }) => BankCardsCompanion(
                id: id,
                accountId: accountId,
                number: number,
                holderName: holderName,
                expiresAt: expiresAt,
                status: status,
                requestedAt: requestedAt,
                blockedAt: blockedAt,
                blockReason: blockReason,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                Value<String?> number = const Value.absent(),
                required String holderName,
                Value<DateTime?> expiresAt = const Value.absent(),
                Value<CardStatus> status = const Value.absent(),
                Value<DateTime> requestedAt = const Value.absent(),
                Value<DateTime?> blockedAt = const Value.absent(),
                Value<String?> blockReason = const Value.absent(),
              }) => BankCardsCompanion.insert(
                id: id,
                accountId: accountId,
                number: number,
                holderName: holderName,
                expiresAt: expiresAt,
                status: status,
                requestedAt: requestedAt,
                blockedAt: blockedAt,
                blockReason: blockReason,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BankCardsTable, BankCard>(table),
                  $$BankCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$BankCardsTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$BankCardsTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BankCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankCardsTable,
      BankCard,
      $$BankCardsTableFilterComposer,
      $$BankCardsTableOrderingComposer,
      $$BankCardsTableAnnotationComposer,
      $$BankCardsTableCreateCompanionBuilder,
      $$BankCardsTableUpdateCompanionBuilder,
      (BankCard, $$BankCardsTableReferences),
      BankCard,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$ExchangeRatesTableCreateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<int> id,
      required Currency baseCurrency,
      required Currency quoteCurrency,
      required int buyRateX10000,
      required int sellRateX10000,
      Value<DateTime> updatedAt,
    });
typedef $$ExchangeRatesTableUpdateCompanionBuilder =
    ExchangeRatesCompanion Function({
      Value<int> id,
      Value<Currency> baseCurrency,
      Value<Currency> quoteCurrency,
      Value<int> buyRateX10000,
      Value<int> sellRateX10000,
      Value<DateTime> updatedAt,
    });

class $$ExchangeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get baseCurrency =>
      $composableBuilder(
        column: $table.baseCurrency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get quoteCurrency =>
      $composableBuilder(
        column: $table.quoteCurrency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get buyRateX10000 => $composableBuilder(
    column: $table.buyRateX10000,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sellRateX10000 => $composableBuilder(
    column: $table.sellRateX10000,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExchangeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quoteCurrency => $composableBuilder(
    column: $table.quoteCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buyRateX10000 => $composableBuilder(
    column: $table.buyRateX10000,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sellRateX10000 => $composableBuilder(
    column: $table.sellRateX10000,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExchangeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get baseCurrency =>
      $composableBuilder(
        column: $table.baseCurrency,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Currency, int> get quoteCurrency =>
      $composableBuilder(
        column: $table.quoteCurrency,
        builder: (column) => column,
      );

  GeneratedColumn<int> get buyRateX10000 => $composableBuilder(
    column: $table.buyRateX10000,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sellRateX10000 => $composableBuilder(
    column: $table.sellRateX10000,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExchangeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTable,
          ExchangeRate,
          $$ExchangeRatesTableFilterComposer,
          $$ExchangeRatesTableOrderingComposer,
          $$ExchangeRatesTableAnnotationComposer,
          $$ExchangeRatesTableCreateCompanionBuilder,
          $$ExchangeRatesTableUpdateCompanionBuilder,
          (
            ExchangeRate,
            BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
          ),
          ExchangeRate,
          PrefetchHooks Function()
        > {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<Currency> baseCurrency = const Value.absent(),
                Value<Currency> quoteCurrency = const Value.absent(),
                Value<int> buyRateX10000 = const Value.absent(),
                Value<int> sellRateX10000 = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ExchangeRatesCompanion(
                id: id,
                baseCurrency: baseCurrency,
                quoteCurrency: quoteCurrency,
                buyRateX10000: buyRateX10000,
                sellRateX10000: sellRateX10000,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required Currency baseCurrency,
                required Currency quoteCurrency,
                required int buyRateX10000,
                required int sellRateX10000,
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ExchangeRatesCompanion.insert(
                id: id,
                baseCurrency: baseCurrency,
                quoteCurrency: quoteCurrency,
                buyRateX10000: buyRateX10000,
                sellRateX10000: sellRateX10000,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExchangeRatesTable, ExchangeRate>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExchangeRatesTable,
                    ExchangeRate
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExchangeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTable,
      ExchangeRate,
      $$ExchangeRatesTableFilterComposer,
      $$ExchangeRatesTableOrderingComposer,
      $$ExchangeRatesTableAnnotationComposer,
      $$ExchangeRatesTableCreateCompanionBuilder,
      $$ExchangeRatesTableUpdateCompanionBuilder,
      (
        ExchangeRate,
        BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate>,
      ),
      ExchangeRate,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required TransactionType type,
      Value<int?> fromAccountId,
      Value<int?> toAccountId,
      required int amount,
      required Currency currency,
      Value<int?> convertedAmount,
      Value<int?> appliedRateX10000,
      Value<String?> description,
      Value<DateTime> createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<TransactionType> type,
      Value<int?> fromAccountId,
      Value<int?> toAccountId,
      Value<int> amount,
      Value<Currency> currency,
      Value<int?> convertedAmount,
      Value<int?> appliedRateX10000,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _fromAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__from_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get fromAccountId {
    final $_column = $_itemColumn<int>('from_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _toAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('transactions__to_account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get toAccountId {
    final $_column = $_itemColumn<int>('to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get currency =>
      $composableBuilder(
        column: $table.currency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get appliedRateX10000 => $composableBuilder(
    column: $table.appliedRateX10000,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AccountsTableFilterComposer get fromAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get toAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get appliedRateX10000 => $composableBuilder(
    column: $table.appliedRateX10000,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AccountsTableOrderingComposer get fromAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get toAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get convertedAmount => $composableBuilder(
    column: $table.convertedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get appliedRateX10000 => $composableBuilder(
    column: $table.appliedRateX10000,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get fromAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fromAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get toAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.toAccountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({bool fromAccountId, bool toAccountId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<int?> fromAccountId = const Value.absent(),
                Value<int?> toAccountId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<Currency> currency = const Value.absent(),
                Value<int?> convertedAmount = const Value.absent(),
                Value<int?> appliedRateX10000 = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                type: type,
                fromAccountId: fromAccountId,
                toAccountId: toAccountId,
                amount: amount,
                currency: currency,
                convertedAmount: convertedAmount,
                appliedRateX10000: appliedRateX10000,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TransactionType type,
                Value<int?> fromAccountId = const Value.absent(),
                Value<int?> toAccountId = const Value.absent(),
                required int amount,
                required Currency currency,
                Value<int?> convertedAmount = const Value.absent(),
                Value<int?> appliedRateX10000 = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                type: type,
                fromAccountId: fromAccountId,
                toAccountId: toAccountId,
                amount: amount,
                currency: currency,
                convertedAmount: convertedAmount,
                appliedRateX10000: appliedRateX10000,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({fromAccountId = false, toAccountId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (fromAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.fromAccountId,
                            referencedTable: $$TransactionsTableReferences
                                ._fromAccountIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._fromAccountIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (toAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.toAccountId,
                            referencedTable: $$TransactionsTableReferences
                                ._toAccountIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._toAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({bool fromAccountId, bool toAccountId})
    >;
typedef $$DepositsTableCreateCompanionBuilder = DepositsCompanion Function({
  Value<int> id,
  required int clientId,
  Value<int?> accountId,
  required int amount,
  required Currency currency,
  required int termMonths,
  Value<int> ratePercentX100,
  Value<DepositStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime?> openedAt,
  Value<DateTime?> closesAt,
});
typedef $$DepositsTableUpdateCompanionBuilder = DepositsCompanion Function({
  Value<int> id,
  Value<int> clientId,
  Value<int?> accountId,
  Value<int> amount,
  Value<Currency> currency,
  Value<int> termMonths,
  Value<int> ratePercentX100,
  Value<DepositStatus> status,
  Value<DateTime> createdAt,
  Value<DateTime?> openedAt,
  Value<DateTime?> closesAt,
});

final class $$DepositsTableReferences
    extends BaseReferences<_$AppDatabase, $DepositsTable, Deposit> {
  $$DepositsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('deposits__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('deposits__account_id__accounts__id');

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DepositsTableFilterComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get currency =>
      $composableBuilder(
        column: $table.currency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DepositStatus, DepositStatus, int>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closesAt => $composableBuilder(
    column: $table.closesAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositsTableOrderingComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openedAt => $composableBuilder(
    column: $table.openedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closesAt => $composableBuilder(
    column: $table.closesAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepositsTable> {
  $$DepositsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DepositStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closesAt =>
      $composableBuilder(column: $table.closesAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepositsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepositsTable,
          Deposit,
          $$DepositsTableFilterComposer,
          $$DepositsTableOrderingComposer,
          $$DepositsTableAnnotationComposer,
          $$DepositsTableCreateCompanionBuilder,
          $$DepositsTableUpdateCompanionBuilder,
          (Deposit, $$DepositsTableReferences),
          Deposit,
          PrefetchHooks Function({bool clientId, bool accountId})
        > {
  $$DepositsTableTableManager(_$AppDatabase db, $DepositsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepositsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepositsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepositsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<Currency> currency = const Value.absent(),
                Value<int> termMonths = const Value.absent(),
                Value<int> ratePercentX100 = const Value.absent(),
                Value<DepositStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<DateTime?> closesAt = const Value.absent(),
              }) => DepositsCompanion(
                id: id,
                clientId: clientId,
                accountId: accountId,
                amount: amount,
                currency: currency,
                termMonths: termMonths,
                ratePercentX100: ratePercentX100,
                status: status,
                createdAt: createdAt,
                openedAt: openedAt,
                closesAt: closesAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                Value<int?> accountId = const Value.absent(),
                required int amount,
                required Currency currency,
                required int termMonths,
                Value<int> ratePercentX100 = const Value.absent(),
                Value<DepositStatus> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> openedAt = const Value.absent(),
                Value<DateTime?> closesAt = const Value.absent(),
              }) => DepositsCompanion.insert(
                id: id,
                clientId: clientId,
                accountId: accountId,
                amount: amount,
                currency: currency,
                termMonths: termMonths,
                ratePercentX100: ratePercentX100,
                status: status,
                createdAt: createdAt,
                openedAt: openedAt,
                closesAt: closesAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DepositsTable, Deposit>(table),
                  $$DepositsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false, accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.clientId,
                        referencedTable: $$DepositsTableReferences
                            ._clientIdTable(db),
                        referencedColumn: $$DepositsTableReferences
                            ._clientIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$DepositsTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$DepositsTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DepositsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepositsTable,
      Deposit,
      $$DepositsTableFilterComposer,
      $$DepositsTableOrderingComposer,
      $$DepositsTableAnnotationComposer,
      $$DepositsTableCreateCompanionBuilder,
      $$DepositsTableUpdateCompanionBuilder,
      (Deposit, $$DepositsTableReferences),
      Deposit,
      PrefetchHooks Function({bool clientId, bool accountId})
    >;
typedef $$LoanApplicationsTableCreateCompanionBuilder =
    LoanApplicationsCompanion Function({
      Value<int> id,
      required int clientId,
      required int createdByEmployeeId,
      Value<int?> decidedByEmployeeId,
      required int amount,
      required Currency currency,
      required int termMonths,
      Value<LoanApplicationStatus> status,
      Value<String?> rejectReason,
      Value<DateTime> createdAt,
      Value<DateTime?> decidedAt,
    });
typedef $$LoanApplicationsTableUpdateCompanionBuilder =
    LoanApplicationsCompanion Function({
      Value<int> id,
      Value<int> clientId,
      Value<int> createdByEmployeeId,
      Value<int?> decidedByEmployeeId,
      Value<int> amount,
      Value<Currency> currency,
      Value<int> termMonths,
      Value<LoanApplicationStatus> status,
      Value<String?> rejectReason,
      Value<DateTime> createdAt,
      Value<DateTime?> decidedAt,
    });

final class $$LoanApplicationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LoanApplicationsTable, LoanApplication> {
  $$LoanApplicationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('loan_applications__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<int>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EmployeesTable _createdByEmployeeIdTable(_$AppDatabase db) => db
      .employees
      .createAlias('loan_applications__created_by_employee_id__employees__id');

  $$EmployeesTableProcessedTableManager get createdByEmployeeId {
    final $_column = $_itemColumn<int>('created_by_employee_id')!;

    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByEmployeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EmployeesTable _decidedByEmployeeIdTable(_$AppDatabase db) => db
      .employees
      .createAlias('loan_applications__decided_by_employee_id__employees__id');

  $$EmployeesTableProcessedTableManager? get decidedByEmployeeId {
    final $_column = $_itemColumn<int>('decided_by_employee_id');
    if ($_column == null) return null;
    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_decidedByEmployeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LoansTable, List<Loan>> _loansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.loans,
    aliasName: 'loan_applications__id__loans__application_id',
  );

  $$LoansTableProcessedTableManager get loansRefs {
    final manager = $$LoansTableTableManager(
      $_db,
      $_db.loans,
    ).filter((f) => f.applicationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LoanApplicationsTableFilterComposer
    extends Composer<_$AppDatabase, $LoanApplicationsTable> {
  $$LoanApplicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Currency, Currency, int> get currency =>
      $composableBuilder(
        column: $table.currency,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    LoanApplicationStatus,
    LoanApplicationStatus,
    int
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get rejectReason => $composableBuilder(
    column: $table.rejectReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableFilterComposer get createdByEmployeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableFilterComposer get decidedByEmployeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decidedByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> loansRefs(
    Expression<bool> Function($$LoansTableFilterComposer f) f,
  ) {
    final $$LoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.applicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableFilterComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoanApplicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanApplicationsTable> {
  $$LoanApplicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectReason => $composableBuilder(
    column: $table.rejectReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get decidedAt => $composableBuilder(
    column: $table.decidedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableOrderingComposer get createdByEmployeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableOrderingComposer get decidedByEmployeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decidedByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanApplicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanApplicationsTable> {
  $$LoanApplicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Currency, int> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get termMonths => $composableBuilder(
    column: $table.termMonths,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LoanApplicationStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get rejectReason => $composableBuilder(
    column: $table.rejectReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get decidedAt =>
      $composableBuilder(column: $table.decidedAt, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableAnnotationComposer get createdByEmployeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.createdByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableAnnotationComposer get decidedByEmployeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.decidedByEmployeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> loansRefs<T extends Object>(
    Expression<T> Function($$LoansTableAnnotationComposer a) f,
  ) {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.applicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableAnnotationComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoanApplicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoanApplicationsTable,
          LoanApplication,
          $$LoanApplicationsTableFilterComposer,
          $$LoanApplicationsTableOrderingComposer,
          $$LoanApplicationsTableAnnotationComposer,
          $$LoanApplicationsTableCreateCompanionBuilder,
          $$LoanApplicationsTableUpdateCompanionBuilder,
          (LoanApplication, $$LoanApplicationsTableReferences),
          LoanApplication,
          PrefetchHooks Function({
            bool clientId,
            bool createdByEmployeeId,
            bool decidedByEmployeeId,
            bool loansRefs,
          })
        > {
  $$LoanApplicationsTableTableManager(
    _$AppDatabase db,
    $LoanApplicationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanApplicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanApplicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanApplicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int> createdByEmployeeId = const Value.absent(),
                Value<int?> decidedByEmployeeId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<Currency> currency = const Value.absent(),
                Value<int> termMonths = const Value.absent(),
                Value<LoanApplicationStatus> status = const Value.absent(),
                Value<String?> rejectReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> decidedAt = const Value.absent(),
              }) => LoanApplicationsCompanion(
                id: id,
                clientId: clientId,
                createdByEmployeeId: createdByEmployeeId,
                decidedByEmployeeId: decidedByEmployeeId,
                amount: amount,
                currency: currency,
                termMonths: termMonths,
                status: status,
                rejectReason: rejectReason,
                createdAt: createdAt,
                decidedAt: decidedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clientId,
                required int createdByEmployeeId,
                Value<int?> decidedByEmployeeId = const Value.absent(),
                required int amount,
                required Currency currency,
                required int termMonths,
                Value<LoanApplicationStatus> status = const Value.absent(),
                Value<String?> rejectReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> decidedAt = const Value.absent(),
              }) => LoanApplicationsCompanion.insert(
                id: id,
                clientId: clientId,
                createdByEmployeeId: createdByEmployeeId,
                decidedByEmployeeId: decidedByEmployeeId,
                amount: amount,
                currency: currency,
                termMonths: termMonths,
                status: status,
                rejectReason: rejectReason,
                createdAt: createdAt,
                decidedAt: decidedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LoanApplicationsTable, LoanApplication>(table),
                  $$LoanApplicationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                createdByEmployeeId = false,
                decidedByEmployeeId = false,
                loansRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (loansRefs) db.loans],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.clientId,
                            referencedTable: $$LoanApplicationsTableReferences
                                ._clientIdTable(db),
                            referencedColumn: $$LoanApplicationsTableReferences
                                ._clientIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (createdByEmployeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.createdByEmployeeId,
                            referencedTable: $$LoanApplicationsTableReferences
                                ._createdByEmployeeIdTable(db),
                            referencedColumn: $$LoanApplicationsTableReferences
                                ._createdByEmployeeIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (decidedByEmployeeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.decidedByEmployeeId,
                            referencedTable: $$LoanApplicationsTableReferences
                                ._decidedByEmployeeIdTable(db),
                            referencedColumn: $$LoanApplicationsTableReferences
                                ._decidedByEmployeeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (loansRefs)
                        await $_getPrefetchedData<
                          LoanApplication,
                          $LoanApplicationsTable,
                          Loan
                        >(
                          currentTable: table,
                          referencedTable: $$LoanApplicationsTableReferences
                              ._loansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LoanApplicationsTableReferences(
                                db,
                                table,
                                p0,
                              ).loansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.applicationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LoanApplicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoanApplicationsTable,
      LoanApplication,
      $$LoanApplicationsTableFilterComposer,
      $$LoanApplicationsTableOrderingComposer,
      $$LoanApplicationsTableAnnotationComposer,
      $$LoanApplicationsTableCreateCompanionBuilder,
      $$LoanApplicationsTableUpdateCompanionBuilder,
      (LoanApplication, $$LoanApplicationsTableReferences),
      LoanApplication,
      PrefetchHooks Function({
        bool clientId,
        bool createdByEmployeeId,
        bool decidedByEmployeeId,
        bool loansRefs,
      })
    >;
typedef $$LoansTableCreateCompanionBuilder = LoansCompanion Function({
  Value<int> id,
  required int applicationId,
  required int accountId,
  required int principal,
  required int remaining,
  required int ratePercentX100,
  Value<LoanStatus> status,
  Value<DateTime> issuedAt,
});
typedef $$LoansTableUpdateCompanionBuilder = LoansCompanion Function({
  Value<int> id,
  Value<int> applicationId,
  Value<int> accountId,
  Value<int> principal,
  Value<int> remaining,
  Value<int> ratePercentX100,
  Value<LoanStatus> status,
  Value<DateTime> issuedAt,
});

final class $$LoansTableReferences
    extends BaseReferences<_$AppDatabase, $LoansTable, Loan> {
  $$LoansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LoanApplicationsTable _applicationIdTable(_$AppDatabase db) => db
      .loanApplications
      .createAlias('loans__application_id__loan_applications__id');

  $$LoanApplicationsTableProcessedTableManager get applicationId {
    final $_column = $_itemColumn<int>('application_id')!;

    final manager = $$LoanApplicationsTableTableManager(
      $_db,
      $_db.loanApplications,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_applicationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTable _accountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias('loans__account_id__accounts__id');

  $$AccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableManager(
      $_db,
      $_db.accounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LoanPaymentsTable, List<LoanPayment>>
  _loanPaymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.loanPayments,
    aliasName: 'loans__id__loan_payments__loan_id',
  );

  $$LoanPaymentsTableProcessedTableManager get loanPaymentsRefs {
    final manager = $$LoanPaymentsTableTableManager(
      $_db,
      $_db.loanPayments,
    ).filter((f) => f.loanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loanPaymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LoansTableFilterComposer extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get principal => $composableBuilder(
    column: $table.principal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remaining => $composableBuilder(
    column: $table.remaining,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LoanStatus, LoanStatus, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LoanApplicationsTableFilterComposer get applicationId {
    final $$LoanApplicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.applicationId,
      referencedTable: $db.loanApplications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanApplicationsTableFilterComposer(
            $db: $db,
            $table: $db.loanApplications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableFilterComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> loanPaymentsRefs(
    Expression<bool> Function($$LoanPaymentsTableFilterComposer f) f,
  ) {
    final $$LoanPaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanPayments,
      getReferencedColumn: (t) => t.loanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanPaymentsTableFilterComposer(
            $db: $db,
            $table: $db.loanPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoansTableOrderingComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get principal => $composableBuilder(
    column: $table.principal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remaining => $composableBuilder(
    column: $table.remaining,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LoanApplicationsTableOrderingComposer get applicationId {
    final $$LoanApplicationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.applicationId,
      referencedTable: $db.loanApplications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanApplicationsTableOrderingComposer(
            $db: $db,
            $table: $db.loanApplications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableOrderingComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get principal =>
      $composableBuilder(column: $table.principal, builder: (column) => column);

  GeneratedColumn<int> get remaining =>
      $composableBuilder(column: $table.remaining, builder: (column) => column);

  GeneratedColumn<int> get ratePercentX100 => $composableBuilder(
    column: $table.ratePercentX100,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LoanStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  $$LoanApplicationsTableAnnotationComposer get applicationId {
    final $$LoanApplicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.applicationId,
      referencedTable: $db.loanApplications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanApplicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.loanApplications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.accounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> loanPaymentsRefs<T extends Object>(
    Expression<T> Function($$LoanPaymentsTableAnnotationComposer a) f,
  ) {
    final $$LoanPaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loanPayments,
      getReferencedColumn: (t) => t.loanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoanPaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.loanPayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoansTable,
          Loan,
          $$LoansTableFilterComposer,
          $$LoansTableOrderingComposer,
          $$LoansTableAnnotationComposer,
          $$LoansTableCreateCompanionBuilder,
          $$LoansTableUpdateCompanionBuilder,
          (Loan, $$LoansTableReferences),
          Loan,
          PrefetchHooks Function({
            bool applicationId,
            bool accountId,
            bool loanPaymentsRefs,
          })
        > {
  $$LoansTableTableManager(_$AppDatabase db, $LoansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> applicationId = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> principal = const Value.absent(),
                Value<int> remaining = const Value.absent(),
                Value<int> ratePercentX100 = const Value.absent(),
                Value<LoanStatus> status = const Value.absent(),
                Value<DateTime> issuedAt = const Value.absent(),
              }) => LoansCompanion(
                id: id,
                applicationId: applicationId,
                accountId: accountId,
                principal: principal,
                remaining: remaining,
                ratePercentX100: ratePercentX100,
                status: status,
                issuedAt: issuedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int applicationId,
                required int accountId,
                required int principal,
                required int remaining,
                required int ratePercentX100,
                Value<LoanStatus> status = const Value.absent(),
                Value<DateTime> issuedAt = const Value.absent(),
              }) => LoansCompanion.insert(
                id: id,
                applicationId: applicationId,
                accountId: accountId,
                principal: principal,
                remaining: remaining,
                ratePercentX100: ratePercentX100,
                status: status,
                issuedAt: issuedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LoansTable, Loan>(table),
                  $$LoansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                applicationId = false,
                accountId = false,
                loanPaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (loanPaymentsRefs) db.loanPayments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (applicationId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.applicationId,
                            referencedTable: $$LoansTableReferences
                                ._applicationIdTable(db),
                            referencedColumn: $$LoansTableReferences
                                ._applicationIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (accountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.accountId,
                            referencedTable: $$LoansTableReferences
                                ._accountIdTable(db),
                            referencedColumn: $$LoansTableReferences
                                ._accountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (loanPaymentsRefs)
                        await $_getPrefetchedData<
                          Loan,
                          $LoansTable,
                          LoanPayment
                        >(
                          currentTable: table,
                          referencedTable: $$LoansTableReferences
                              ._loanPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LoansTableReferences(
                                db,
                                table,
                                p0,
                              ).loanPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.loanId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LoansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoansTable,
      Loan,
      $$LoansTableFilterComposer,
      $$LoansTableOrderingComposer,
      $$LoansTableAnnotationComposer,
      $$LoansTableCreateCompanionBuilder,
      $$LoansTableUpdateCompanionBuilder,
      (Loan, $$LoansTableReferences),
      Loan,
      PrefetchHooks Function({
        bool applicationId,
        bool accountId,
        bool loanPaymentsRefs,
      })
    >;
typedef $$LoanPaymentsTableCreateCompanionBuilder =
    LoanPaymentsCompanion Function({
      Value<int> id,
      required int loanId,
      required int employeeId,
      required int amount,
      required PaymentMethod method,
      Value<DateTime> paidAt,
    });
typedef $$LoanPaymentsTableUpdateCompanionBuilder =
    LoanPaymentsCompanion Function({
      Value<int> id,
      Value<int> loanId,
      Value<int> employeeId,
      Value<int> amount,
      Value<PaymentMethod> method,
      Value<DateTime> paidAt,
    });

final class $$LoanPaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $LoanPaymentsTable, LoanPayment> {
  $$LoanPaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LoansTable _loanIdTable(_$AppDatabase db) =>
      db.loans.createAlias('loan_payments__loan_id__loans__id');

  $$LoansTableProcessedTableManager get loanId {
    final $_column = $_itemColumn<int>('loan_id')!;

    final manager = $$LoansTableTableManager(
      $_db,
      $_db.loans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EmployeesTable _employeeIdTable(_$AppDatabase db) =>
      db.employees.createAlias('loan_payments__employee_id__employees__id');

  $$EmployeesTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<int>('employee_id')!;

    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LoanPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, int>
  get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LoansTableFilterComposer get loanId {
    final $$LoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableFilterComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableFilterComposer get employeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LoansTableOrderingComposer get loanId {
    final $$LoansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableOrderingComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableOrderingComposer get employeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoanPaymentsTable> {
  $$LoanPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, int> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  $$LoansTableAnnotationComposer get loanId {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableAnnotationComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EmployeesTableAnnotationComposer get employeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoanPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoanPaymentsTable,
          LoanPayment,
          $$LoanPaymentsTableFilterComposer,
          $$LoanPaymentsTableOrderingComposer,
          $$LoanPaymentsTableAnnotationComposer,
          $$LoanPaymentsTableCreateCompanionBuilder,
          $$LoanPaymentsTableUpdateCompanionBuilder,
          (LoanPayment, $$LoanPaymentsTableReferences),
          LoanPayment,
          PrefetchHooks Function({bool loanId, bool employeeId})
        > {
  $$LoanPaymentsTableTableManager(_$AppDatabase db, $LoanPaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoanPaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoanPaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoanPaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> loanId = const Value.absent(),
                Value<int> employeeId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<PaymentMethod> method = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
              }) => LoanPaymentsCompanion(
                id: id,
                loanId: loanId,
                employeeId: employeeId,
                amount: amount,
                method: method,
                paidAt: paidAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int loanId,
                required int employeeId,
                required int amount,
                required PaymentMethod method,
                Value<DateTime> paidAt = const Value.absent(),
              }) => LoanPaymentsCompanion.insert(
                id: id,
                loanId: loanId,
                employeeId: employeeId,
                amount: amount,
                method: method,
                paidAt: paidAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LoanPaymentsTable, LoanPayment>(table),
                  $$LoanPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({loanId = false, employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (loanId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.loanId,
                        referencedTable: $$LoanPaymentsTableReferences
                            ._loanIdTable(db),
                        referencedColumn: $$LoanPaymentsTableReferences
                            ._loanIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (employeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.employeeId,
                        referencedTable: $$LoanPaymentsTableReferences
                            ._employeeIdTable(db),
                        referencedColumn: $$LoanPaymentsTableReferences
                            ._employeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LoanPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoanPaymentsTable,
      LoanPayment,
      $$LoanPaymentsTableFilterComposer,
      $$LoanPaymentsTableOrderingComposer,
      $$LoanPaymentsTableAnnotationComposer,
      $$LoanPaymentsTableCreateCompanionBuilder,
      $$LoanPaymentsTableUpdateCompanionBuilder,
      (LoanPayment, $$LoanPaymentsTableReferences),
      LoanPayment,
      PrefetchHooks Function({bool loanId, bool employeeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$BankCardsTableTableManager get bankCards =>
      $$BankCardsTableTableManager(_db, _db.bankCards);
  $$ExchangeRatesTableTableManager get exchangeRates =>
      $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$DepositsTableTableManager get deposits =>
      $$DepositsTableTableManager(_db, _db.deposits);
  $$LoanApplicationsTableTableManager get loanApplications =>
      $$LoanApplicationsTableTableManager(_db, _db.loanApplications);
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db, _db.loans);
  $$LoanPaymentsTableTableManager get loanPayments =>
      $$LoanPaymentsTableTableManager(_db, _db.loanPayments);
}
