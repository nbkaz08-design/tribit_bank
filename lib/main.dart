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
      child: MaterialApp(home: const LoginScreen()),
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _login = TextEditingController();
  final _password = TextEditingController();
  String? _error;

  Future<void> _submit() async {
    final auth = context.read<AuthRepository>();
    final user = await auth.login(_login.text.trim(), _password.text);
    if (!mounted) return;
    if (user == null) {
      setState(() => _error = 'Неверный логин или пароль');
      return;
    }
    // Роль определяет, куда идти дальше.
    final page = user.role == UserRole.employee
        ? const Scaffold(body: Center(child: Text('Кабинет сотрудника')))
        : const Scaffold(body: Center(child: Text('Кабинет клиента')));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    // final db = context.read<AppDatabase>();
    // db.resetToDemo();

    return Scaffold(
        appBar: AppBar(title: const Text('Вход в TriBit bank')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextField(controller: _login,
                  decoration: const InputDecoration(labelText: 'Логин')),
              TextField(controller: _password, obscureText: true,
                  decoration: const InputDecoration(labelText: 'Пароль')),
              if (_error != null)
                Padding(padding: const EdgeInsets.only(top: 8),
                    child: Text(_error!, style: const TextStyle(color: Colors.red))),
              const SizedBox(height: 16),
              FilledButton(onPressed: _submit, child: const Text('Войти')),
            ]),
          ),
        ),
      );
  }
}