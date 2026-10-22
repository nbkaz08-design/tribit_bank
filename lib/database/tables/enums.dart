/// Перечисления предметной области TriBit bank.
/// Хранятся в БД как int (индекс) через `intEnum`.
/// Не менять порядок значений после релиза — только добавлять в конец.

/// Субъекты системы (раздел 2 отчёта).
enum UserRole { client, employee }

/// Валюты.
enum Currency { rub, usd, eur }

/// Тип счёта.
enum AccountType { current, deposit, loan }

/// Статус счёта.
enum AccountStatus { active, closed }

/// Статус банковской карты.
/// requested — заявка на выпуск, blocked — «Блокировка карты».
enum CardStatus { requested, active, blocked }

/// Тип операции в истории.
enum TransactionType {
  transferOwn, // перевод между своими счетами
  transferInternal, // перевод другому клиенту банка
  exchange, // обмен валюты
  depositOpen, // пополнение вклада при открытии
  loanIssue, // выдача кредита
  loanPayment, // оплата кредита
}

/// Статус вклада.
enum DepositStatus { requested, open, closed }

/// Статус кредитной заявки (одобрение / отклонение — расширения «Заявки на кредит»).
enum LoanApplicationStatus { pending, approved, rejected }

/// Статус кредита.
enum LoanStatus { active, paidOff }

/// Способ оплаты кредита: наличные через кассу или безналичный.
enum PaymentMethod { cash, cashless }
