import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tribit_bank/MyApp.dart';

import 'database/app_database.dart';

import 'repositories/account_repository.dart';
import 'repositories/auth_repository.dart';
import 'repositories/card_repository.dart';
import 'repositories/loan_repository.dart';
import 'repositories/payment_repository.dart';
import 'repositories/rates_repository.dart';

import 'repositories/local/local_account_repository.dart';
import 'repositories/local/local_auth_repository.dart';
import 'repositories/local/local_card_repository.dart';
import 'repositories/local/local_loan_repository.dart';
import 'repositories/local/local_payment_repository.dart';
import 'repositories/local/local_rates_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // 1. База данных: один экземпляр, закрывается при выходе.
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
          dispose: (_, db) => db.close(),
        ),

        // 2. Репозитории. Тип провайдера — ИНТЕРФЕЙС, реализация — Local*.
        //    Чтобы перейти на сервер, замените Local* на Remote* в нужной строке.
        Provider<AuthRepository>(
          create: (c) => LocalAuthRepository(c.read<AppDatabase>()),
        ),
        Provider<AccountRepository>(
          create: (c) => LocalAccountRepository(c.read<AppDatabase>()),
        ),
        Provider<PaymentRepository>(
          create: (c) => LocalPaymentRepository(c.read<AppDatabase>()),
        ),
        Provider<RatesRepository>(
          create: (c) => LocalRatesRepository(c.read<AppDatabase>()),
        ),
        Provider<CardRepository>(
          create: (c) => LocalCardRepository(c.read<AppDatabase>()),
        ),
        Provider<LoanRepository>(
          create: (c) => LocalLoanRepository(c.read<AppDatabase>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
