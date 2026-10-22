import 'package:drift/drift.dart';

import 'enums.dart';

// Денежные суммы хранятся целым числом в минимальных единицах
// (копейки/центы): 100.50 ₽ = 10050. Это исключает ошибки округления double.
// Курсы валют хранятся в тысячных долях (rate * 10000) по той же причине —
// см. поля buyRateX10000 / sellRateX10000.

/// Учётная запись для «Регистрация и авторизация».
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get login => text().withLength(min: 3, max: 50).unique()();
  TextColumn get passwordHash => text()(); // хэш, НЕ пароль в открытом виде
  IntColumn get role => intEnum<UserRole>()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

/// Профиль субъекта «Клиент» (физическое лицо).
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().unique().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get fullName => text().withLength(min: 1, max: 150)();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get passportNumber => text().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
}

/// Профиль субъекта «Сотрудник» (операционист, менеджер).
class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().unique().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get fullName => text().withLength(min: 1, max: 150)();
  TextColumn get position => text().withLength(min: 1, max: 100)();
}

/// Счета клиентов: текущие, депозитные, кредитные.
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get number => text().withLength(min: 20, max: 20).unique()();
  IntColumn get type => intEnum<AccountType>()();
  IntColumn get currency => intEnum<Currency>()();
  IntColumn get balance => integer().withDefault(const Constant(0))();
  IntColumn get status =>
      intEnum<AccountStatus>().withDefault(Constant(AccountStatus.active.index))();
  DateTimeColumn get openedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['CHECK (balance >= 0)'];
}

/// Банковские карты. Заявка на выпуск = карта со статусом requested.
class BankCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get accountId => integer().references(Accounts, #id)();
  // Номер заполняется банком при выпуске, поэтому nullable.
  TextColumn get number => text().withLength(min: 16, max: 16).nullable().unique()();
  TextColumn get holderName => text()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
  IntColumn get status =>
      intEnum<CardStatus>().withDefault(Constant(CardStatus.requested.index))();
  DateTimeColumn get requestedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get blockedAt => dateTime().nullable()();
  TextColumn get blockReason => text().nullable()(); // утеря, кража, мошенничество
}

/// Внутренние курсы валют банка («Просмотр курса валют»).
class ExchangeRates extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get baseCurrency => intEnum<Currency>()();
  IntColumn get quoteCurrency => intEnum<Currency>()();
  // Курс × 10000: 92.5000 ₽ за $ → 925000.
  IntColumn get buyRateX10000 => integer()();
  IntColumn get sellRateX10000 => integer()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {baseCurrency, quoteCurrency},
      ];
}

/// История операций («Просмотр истории операций»),
/// включая переводы, обмен валюты и платежи по кредиту.
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get type => intEnum<TransactionType>()();
  IntColumn get fromAccountId => integer().nullable().references(Accounts, #id)();
  IntColumn get toAccountId => integer().nullable().references(Accounts, #id)();
  IntColumn get amount => integer()(); // сумма списания в валюте счёта-отправителя
  IntColumn get currency => intEnum<Currency>()();
  // Только для обмена валюты:
  IntColumn get convertedAmount => integer().nullable()(); // сумма зачисления
  IntColumn get appliedRateX10000 => integer().nullable()(); // применённый курс
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => ['CHECK (amount > 0)'];
}

/// Вклады («Открытие вклада»): сумма, срок, валюта выбираются клиентом.
class Deposits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  IntColumn get accountId => integer().nullable().references(Accounts, #id)();
  IntColumn get amount => integer()();
  IntColumn get currency => intEnum<Currency>()();
  IntColumn get termMonths => integer()();
  IntColumn get ratePercentX100 => integer().withDefault(const Constant(0))(); // 7.25% → 725
  IntColumn get status =>
      intEnum<DepositStatus>().withDefault(Constant(DepositStatus.requested.index))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get openedAt => dateTime().nullable()();
  DateTimeColumn get closesAt => dateTime().nullable()();
}

/// Кредитные заявки. Создаёт сотрудник («Заявка на кредит»);
/// «Одобрение» и «Отклонение» — переходы статуса (<<расширить>> на диаграмме).
class LoanApplications extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  IntColumn get createdByEmployeeId => integer().references(Employees, #id)();
  IntColumn get decidedByEmployeeId => integer().nullable().references(Employees, #id)();
  IntColumn get amount => integer()();
  IntColumn get currency => intEnum<Currency>()();
  IntColumn get termMonths => integer()();
  IntColumn get status => intEnum<LoanApplicationStatus>()
      .withDefault(Constant(LoanApplicationStatus.pending.index))();
  TextColumn get rejectReason => text().nullable()(); // причина отказа
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get decidedAt => dateTime().nullable()();
}

/// Кредит, созданный после одобрения заявки.
class Loans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get applicationId => integer().unique().references(LoanApplications, #id)();
  IntColumn get accountId => integer().references(Accounts, #id)();
  IntColumn get principal => integer()();
  IntColumn get remaining => integer()(); // остаток задолженности
  IntColumn get ratePercentX100 => integer()();
  IntColumn get status =>
      intEnum<LoanStatus>().withDefault(Constant(LoanStatus.active.index))();
  DateTimeColumn get issuedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Платежи по кредиту («Оплата кредита»): наличные или безналичные.
class LoanPayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get loanId => integer().references(Loans, #id)();
  IntColumn get employeeId => integer().references(Employees, #id)();
  IntColumn get amount => integer()();
  IntColumn get method => intEnum<PaymentMethod>()();
  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();
}
