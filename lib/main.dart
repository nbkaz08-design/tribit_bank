import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
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
        // 1. База: один экземпляр, закрывается при выходе из приложения.
        Provider<AppDatabase>(
          // Демо-данные только по флагу: flutter run --dart-define=SEED_DEMO=true
          create: (_) =>
              AppDatabase(seedDemo: const bool.fromEnvironment('SEED_DEMO')),
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
      child: const TriBitAppDemo(),
    ),
  );
}



class TriBitAppDemo extends StatelessWidget {
  const TriBitAppDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TriBit bank',
      home: RatesScreen(),
    );
  }
}

/// Пример экрана «Курсы валют» — работает через репозиторий, не через БД.
class RatesScreen extends StatelessWidget {
  const RatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rates = context.read<RatesRepository>();

    final users = context.read<AccountRepository>();


    return Scaffold(
      appBar: AppBar(title: const Text('Курсы валют')),
      body: Row(
        children: [
          Expanded(
            child: StreamBuilder<List<ExchangeRate>>(
              stream: rates.watchRates(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: [
                    for (final r in snapshot.data!)
                      ListTile(
                        title: Text('${r.baseCurrency.name.toUpperCase()} → '
                            '${r.quoteCurrency.name.toUpperCase()}'),
                        subtitle: Text(
                          'Покупка: ${(r.buyRateX10000 / 10000).toStringAsFixed(2)}   '
                          'Продажа: ${(r.sellRateX10000 / 10000).toStringAsFixed(2)}',
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: users.getAccountsOfClient(1),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children: [
                    for (final r in snapshot.data!)
                      ListTile(
                        title: Text('id: ${r.clientId} ${r.balance} ${r.currency.name}'),
                        subtitle: Text(
                          'opened at: ${r.openedAt}'
                          '\ncurrent status: ${r.status.name}',
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
