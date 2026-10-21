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

<<<<<<< HEAD
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
=======
// ============================================================================
// ЦВЕТА И ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
// ============================================================================

const bankBlue = Color(0xFF2563EB);
const bankGreen = Color(0xFF10B981);
const bankRed = Color(0xFFEF4444);
const bankGrey = Color(0xFF64748B);
const bankBackground = Color(0xFFF4F6FA);
const bankDark = Color(0xFF0A1429);

String money(num value) {
  final parts = value.toStringAsFixed(2).split('.');
  final integer = parts[0].replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]} ',
  );
  return '₽ $integer,${parts[1]}';
}

String dateText(DateTime date) {
  String two(int value) => value.toString().padLeft(2, '0');
  return '${two(date.day)}.${two(date.month)}.${date.year}';
}

String timeText(DateTime date) {
  String two(int value) => value.toString().padLeft(2, '0');
  return '${dateText(date)} ${two(date.hour)}:${two(date.minute)}';
}

Color statusColor(String status) {
  if (['Одобрена', 'Успешно', 'Активна', 'Активен'].contains(status)) {
    return bankGreen;
  }
  if (['Отклонена', 'Заблокирована'].contains(status)) {
    return bankRed;
  }
  return const Color(0xFFF59E0B);
}

Future<bool> confirmAction(
  BuildContext context,
  String title,
  String message,
) async {
  return await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Подтвердить'),
            ),
          ],
        ),
      ) ??
      false;
}

// ============================================================================
// ПРИЛОЖЕНИЕ
// ============================================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriBit Bank Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: bankBackground,
        fontFamily: 'Roboto',
        primaryColor: bankBlue,
        colorScheme: ColorScheme.fromSeed(seedColor: bankBlue),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

enum ActiveTab {
  auth,
  overview,
  clients,
  clientDetails,
  accounts,
  creditApplications,
  createCreditApplication,
  creditApplicationDetails,
  creditRepayment,
  actionLog,
  settings,
}

// ============================================================================
// МОДЕЛИ ДЕМОНСТРАЦИОННЫХ ДАННЫХ
// ============================================================================

class BankClient {
  final String id;
  final String name;
  final String initials;
  final String phone;
  final String email;
  final String products;
  final bool isPro;

  double balance;
  double debt;
  bool cardBlocked;

  BankClient({
    required this.id,
    required this.name,
    required this.initials,
    required this.phone,
    required this.email,
    required this.products,
    required this.balance,
    this.debt = 0,
    this.isPro = false,
    this.cardBlocked = false,
  });
}

class CreditApplication {
  final String id;
  final BankClient client;
  final String product;
  final double amount;
  final int months;
  final DateTime createdAt;

  String status;

  CreditApplication({
    required this.id,
    required this.client,
    required this.product,
    required this.amount,
    required this.months,
    required this.createdAt,
    this.status = 'На рассмотрении',
  });
}

class BankLog {
  final DateTime date;
  final String action;
  final String object;

  BankLog(this.action, this.object) : date = DateTime.now();
}

// ============================================================================
// ОСНОВНАЯ НАВИГАЦИЯ
// ============================================================================

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  ActiveTab _currentTab = ActiveTab.auth;

  final clients = <BankClient>[
    BankClient(
      id: '842910',
      name: 'Васильева Елена Сергеевна',
      initials: 'ЕВ',
      phone: '+7 (999) •••-45-21',
      email: 'e.vasileva@example.ru',
      products: '1 Карта, 1 Кредит',
      balance: 248560.80,
      debt: 186420,
      isPro: true,
    ),
    BankClient(
      id: '842911',
      name: 'Васильева Анна Игоревна',
      initials: 'АВ',
      phone: '+7 (921) •••-12-88',
      email: 'a.vasileva@example.ru',
      products: '2 Карты, 1 Кредит',
      balance: 1042100,
      debt: 320000,
    ),
    BankClient(
      id: '842912',
      name: 'Васильева Галина Петровна',
      initials: 'ГВ',
      phone: '+7 (905) •••-74-12',
      email: 'g.vasileva@example.ru',
      products: '1 Счёт',
      balance: 12400,
    ),
  ];

  late BankClient selectedClient;
  late List<CreditApplication> applications;
  CreditApplication? selectedApplication;

  final logs = <BankLog>[];

  int nextApplication = 15;
  bool emailNotifications = true;
  bool applicationNotifications = true;

  @override
  void initState() {
    super.initState();

    selectedClient = clients.first;

    applications = [
      CreditApplication(
        id: 'APP-2024-014',
        client: clients[0],
        product: 'Потребительский кредит',
        amount: 450000,
        months: 36,
        createdAt: DateTime(2024, 10, 24, 10, 15),
      ),
      CreditApplication(
        id: 'APP-2024-013',
        client: clients[1],
        product: 'Автокредит',
        amount: 1200000,
        months: 60,
        createdAt: DateTime(2024, 10, 24, 9, 40),
        status: 'Одобрена',
      ),
      CreditApplication(
        id: 'APP-2024-012',
        client: clients[2],
        product: 'Потребительский кредит',
        amount: 300000,
        months: 24,
        createdAt: DateTime(2024, 10, 23, 16, 20),
        status: 'Отклонена',
      ),
    ];
  }

  void navigate(ActiveTab tab) {
    setState(() {
      if (_currentTab == ActiveTab.auth && tab != ActiveTab.auth) {
        addLog('Вход в систему', 'Константин В.');
      }
      if (tab == ActiveTab.auth) {
        addLog('Выход из системы', 'Константин В.');
      }
      _currentTab = tab;
    });
  }

  void addLog(String action, String object) {
    logs.insert(0, BankLog(action, object));
  }

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void openClient(BankClient client) {
    setState(() {
      selectedClient = client;
      addLog('Просмотр клиента', 'ID ${client.id}');
      _currentTab = ActiveTab.clientDetails;
    });
  }

  void openApplication(CreditApplication application) {
    setState(() {
      selectedApplication = application;
      selectedClient = application.client;
      _currentTab = ActiveTab.creditApplicationDetails;
    });
  }

  void createApplication(
    BankClient client,
    String product,
    double amount,
    int months,
  ) {
    final now = DateTime.now();

    final application = CreditApplication(
      id: 'APP-${now.year}-'
          '${nextApplication.toString().padLeft(3, '0')}',
      client: client,
      product: product,
      amount: amount,
      months: months,
      createdAt: now,
    );

    setState(() {
      nextApplication++;
      applications.insert(0, application);
      selectedApplication = application;
      selectedClient = client;
      addLog('Создание заявки', application.id);
      _currentTab = ActiveTab.creditApplicationDetails;
    });

    message('Заявка создана');
  }

  Future<void> changeApplicationStatus(String status) async {
    final application = selectedApplication;

    if (application == null || application.status != 'На рассмотрении') {
      return;
    }

    final confirmed = await confirmAction(
      context,
      status == 'Одобрена' ? 'Одобрить заявку?' : 'Отклонить заявку?',
      '${application.id}\n'
          '${application.client.name}\n'
          '${money(application.amount)}',
    );

    if (!confirmed || !mounted) return;

    setState(() {
      application.status = status;
      addLog('Заявка: $status', application.id);
    });

    message('Статус заявки изменён');
  }

  Future<void> toggleCard() async {
    final client = selectedClient;
    final action = client.cardBlocked ? 'Разблокировать' : 'Заблокировать';

    final confirmed = await confirmAction(
      context,
      '$action карту?',
      '${client.name}\nКарта •••• ${client.id.substring(2)}',
    );

    if (!confirmed || !mounted) return;

    setState(() {
      client.cardBlocked = !client.cardBlocked;
      addLog('$action карту', 'Клиент ${client.id}');
    });

    message(
      client.cardBlocked ? 'Карта заблокирована' : 'Карта разблокирована',
    );
  }

  Future<bool> repay(double amount) async {
    final client = selectedClient;

    if (amount > client.balance || amount > client.debt) {
      message('Проверьте баланс и остаток задолженности');
      return false;
    }

    final confirmed = await confirmAction(
      context,
      'Подтвердить платёж?',
      '${client.name}\n'
          'Договор CR-${client.id}\n'
          'Сумма: ${money(amount)}',
    );

    if (!confirmed || !mounted) return false;

    setState(() {
      client.balance = ((client.balance - amount) * 100).round() / 100;
      client.debt = ((client.debt - amount) * 100).round() / 100;
      addLog(
        'Погашение кредита: ${money(amount)}',
        'CR-${client.id}',
      );
    });

    message('Платёж успешно проведён');
    return true;
  }

  Widget buildContent() {
    switch (_currentTab) {
      case ActiveTab.auth:
        return MainAuth(onTabChanged: navigate);

      case ActiveTab.overview:
        return OverviewScreen(
          onCreateApplication: () => navigate(
            ActiveTab.createCreditApplication,
          ),
          onClients: () => navigate(ActiveTab.clients),
          onAccounts: () => navigate(ActiveTab.accounts),
        );

      case ActiveTab.clients:
        return ClientsScreen(
          clients: clients,
          onOpenClient: openClient,
        );

      case ActiveTab.clientDetails:
        return ClientDetailsScreen(
          client: selectedClient,
          onBack: () => navigate(ActiveTab.clients),
          onCreateApplication: () => navigate(
            ActiveTab.createCreditApplication,
          ),
          onAccounts: () => navigate(ActiveTab.accounts),
          onRepayment: () => navigate(ActiveTab.creditRepayment),
        );

      case ActiveTab.accounts:
        return AccountsCardsScreen(
          client: selectedClient,
          onToggleCard: toggleCard,
        );

      case ActiveTab.creditApplications:
        return CreditApplicationsScreen(
          applications: applications,
          onOpen: openApplication,
          onCreate: () => navigate(ActiveTab.createCreditApplication),
        );

      case ActiveTab.createCreditApplication:
        return CreateCreditApplicationScreen(
          clients: clients,
          initialClient: selectedClient,
          onSubmit: createApplication,
          onBack: () => navigate(ActiveTab.creditApplications),
        );

      case ActiveTab.creditApplicationDetails:
        final application = selectedApplication;

        if (application == null) {
          return const Center(child: Text('Выберите заявку'));
        }

        return CreditApplicationDetailsScreen(
          application: application,
          onBack: () => navigate(ActiveTab.creditApplications),
          onApprove: () => changeApplicationStatus('Одобрена'),
          onReject: () => changeApplicationStatus('Отклонена'),
        );

      case ActiveTab.creditRepayment:
        return CreditRepaymentScreen(
          key: ValueKey(selectedClient.id),
          client: selectedClient,
          clients: clients,
          onClientChanged: (client) {
            setState(() => selectedClient = client);
          },
          onPay: repay,
        );

      case ActiveTab.actionLog:
        return ActionLogScreen(logs: logs);

      case ActiveTab.settings:
        return SettingsScreen(
          emailNotifications: emailNotifications,
          applicationNotifications: applicationNotifications,
          onSave: (email, application) {
            setState(() {
              emailNotifications = email;
              applicationNotifications = application;
              addLog('Изменение настроек', 'Профиль сотрудника');
            });
            message('Настройки сохранены');
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (_currentTab != ActiveTab.auth)
            SideInfo(
              currentTab: _currentTab,
              onTabChanged: navigate,
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final minimumWidth =
                    _currentTab == ActiveTab.auth ? 1150.0 : 1050.0;

                final width = constraints.maxWidth < minimumWidth
                    ? minimumWidth
                    : constraints.maxWidth;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: width,
                    height: constraints.maxHeight,
                    child: buildContent(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// БОКОВАЯ ПАНЕЛЬ
// ============================================================================

class SideInfo extends StatelessWidget {
  final ActiveTab currentTab;
  final ValueChanged<ActiveTab> onTabChanged;

  const SideInfo({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });
>>>>>>> 5f2d5c40d7858a6fd0114220828d4ee7c8e32069

  bool isSelected(ActiveTab tab) {
    if (tab == ActiveTab.clients) {
      return currentTab == tab || currentTab == ActiveTab.clientDetails;
    }

    if (tab == ActiveTab.creditApplications) {
      return [
        ActiveTab.creditApplications,
        ActiveTab.createCreditApplication,
        ActiveTab.creditApplicationDetails,
      ].contains(currentTab);
    }

    return currentTab == tab;
  }

  Widget menuItem(IconData icon, String title, ActiveTab tab) {
    final selected = isSelected(tab);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        dense: true,
        selected: selected,
        selectedTileColor: bankBlue.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: Icon(
          icon,
          color: selected ? bankBlue : Colors.grey[500],
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey[400],
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: selected
            ? Container(width: 3, height: 16, color: bankBlue)
            : null,
        onTap: () => onTabChanged(tab),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Container(
      width: 260,
      color: bankDark,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BankLogo(),
          const SizedBox(height: 35),
          Expanded(
            child: ListView(
              children: [
                menuItem(Icons.grid_view_rounded, 'Обзор', ActiveTab.overview),
                menuItem(
                  Icons.people_alt_outlined,
                  'Клиенты',
                  ActiveTab.clients,
                ),
                menuItem(
                  Icons.credit_card_rounded,
                  'Счета и карты',
                  ActiveTab.accounts,
                ),
                menuItem(
                  Icons.assignment_outlined,
                  'Кредитные заявки',
                  ActiveTab.creditApplications,
                ),
                menuItem(
                  Icons.swap_horiz_rounded,
                  'Платежи по кредитам',
                  ActiveTab.creditRepayment,
                ),
                menuItem(
                  Icons.history,
                  'Журнал действий',
                  ActiveTab.actionLog,
                ),
                menuItem(
                  Icons.settings_outlined,
                  'Настройки',
                  ActiveTab.settings,
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF263449)),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueGrey,
                child: Text(
                  'КВ',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Константин В.',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Старший андеррайтер',
                      style: TextStyle(color: Colors.grey[500], fontSize: 10),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Выйти',
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.grey,
                  size: 18,
                ),
                onPressed: () => onTabChanged(ActiveTab.auth),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BankLogo extends StatelessWidget {
  final bool large;

  const BankLogo({super.key, this.large = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'images/Logo-Mark.png',
          width: large ? 48 : 32,
          height: large ? 48 : 32,
          errorBuilder: (_, __, ___) => Icon(
            Icons.account_balance,
            color: Colors.lightBlue,
            size: large ? 44 : 30,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'TriBit Bank',
          style: TextStyle(
            color: Colors.white,
            fontSize: large ? 30 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// ОБЩИЕ КОМПОНЕНТЫ
// ============================================================================

class PageLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? action;

  const PageLayout({
    super.key,
    required this.title,
    required this.child,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final String? title;
  final Widget child;
  final Color? borderColor;

  const Panel({
    super.key,
    this.title,
    required this.child,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor ?? const Color(0xFFEDF1F6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
          ],
          child,
        ],
      ),
    );
  }
}

class BankButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool outlined;
  final Color color;

  const BankButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.outlined = false,
    this.color = bankBlue,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7),
    );

    if (outlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: shape,
        ),
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: shape,
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String text;
  final Color? color;

  const StatusBadge(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? statusColor(text);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: c.withOpacity(0.10),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: c,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class InfoLine extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const InfoLine(this.label, this.value, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: bankGrey),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color ?? const Color(0xFF334155),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String label;
  final Widget child;

  const FieldLabel({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: bankGrey),
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}

class BankTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;

  const BankTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              showCheckboxColumn: false,
              horizontalMargin: 10,
              columnSpacing: 22,
              headingRowHeight: 44,
              dataRowMinHeight: 56,
              dataRowMaxHeight: 68,
              headingTextStyle: const TextStyle(
                fontSize: 10,
                color: bankGrey,
                fontWeight: FontWeight.bold,
              ),
              dataTextStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xFF334155),
              ),
              columns: columns
                  .map((text) => DataColumn(label: Text(text)))
                  .toList(),
              rows: rows,
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// АВТОРИЗАЦИЯ
// ============================================================================

class MainAuth extends StatelessWidget {
  final ValueChanged<ActiveTab> onTabChanged;

  const MainAuth({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: double.infinity,
            color: const Color(0xFF060D1A),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BankLogo(large: true),
                  const SizedBox(height: 100),
                  const Text(
                    'Внутренний\nзащищенный портал',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Доступ к операционной системе TriBit Bank разрешен '
                    'только авторизованным сотрудникам бэк-офиса '
                    'и филиальной сети.',
                    style: TextStyle(
                      color: bankGrey,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 50),
                  for (final text in [
                    'Шифрование канала по стандарту ГОСТ',
                    'Обязательная 2FA авторизация',
                    'Автоматическое логирование сессий',
                  ])
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shield_outlined,
                            color: bankBlue,
                            size: 19,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              text,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 70,
                vertical: 35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Авторизация сотрудника',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Введите учетные данные для доступа в систему',
                    style: TextStyle(color: bankGrey, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  const FieldLabel(
                    label: 'Корпоративный ID / E-mail',
                    child: TextFormFieldEmail(),
                  ),
                  const SizedBox(height: 18),
                  FieldLabel(
                    label: 'Пароль',
                    child: TextFormField(
                      initialValue: 'demo-password',
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Второй фактор защиты (2FA)',
                          style: TextStyle(
                            color: Color(0xFF1E40AF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Введите 6-значный пароль из приложения Authenticator',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1E40AF),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: List.generate(6, (index) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index == 5 ? 0 : 8,
                                ),
                                child: TextFormField(
                                  initialValue: '482910'[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  BankButton(
                    'Подтвердить и войти',
                    onPressed: () => onTabChanged(ActiveTab.overview),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Демонстрационный вход без проверки учётных данных',
                    style: TextStyle(fontSize: 11, color: bankGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFormFieldEmail extends StatelessWidget {
  const TextFormFieldEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: 'k.vorobiev@tribit.ru',
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person_outline, size: 20),
      ),
    );
  }
}

// ============================================================================
// ОБЗОР
// ============================================================================

class OverviewScreen extends StatelessWidget {
  final VoidCallback onCreateApplication;
  final VoidCallback onClients;
  final VoidCallback onAccounts;

  const OverviewScreen({
    super.key,
    required this.onCreateApplication,
    required this.onClients,
    required this.onAccounts,
  });

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Обзор показателей',
      child: Column(
        children: [
          const Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'НОВЫЕ ЗАЯВКИ',
                  value: '14 заявок',
                  sub: '+ 4 за последний час',
                  isAccent: true,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'НА ПРОВЕРКЕ',
                  value: '8 клиентов',
                  sub: 'Ожидают скоринг СБ',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'ОДОБРЕНО СЕГОДНЯ',
                  value: '24 кредита',
                  sub: 'Сумма: ₽ 18.4 млн',
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'ПРОСРОЧКИ ПЛАТЕЖЕЙ',
                  value: '3 случая',
                  sub: 'Требуется созвон',
                  isWarning: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 2,
                child: Panel(
                  title: 'Обработка кредитных заявок за неделю',
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BarChartGroup(label: 'Пн', val1: 60, val2: 30),
                        BarChartGroup(label: 'Вт', val1: 90, val2: 20),
                        BarChartGroup(label: 'Ср', val1: 80, val2: 45),
                        BarChartGroup(label: 'Чт', val1: 110, val2: 25),
                        BarChartGroup(label: 'Пт', val1: 95, val2: 15),
                        BarChartGroup(label: 'Сб', val1: 40, val2: 10),
                        BarChartGroup(label: 'Вс', val1: 70, val2: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Panel(
                  title: 'Быстрые действия',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BankButton(
                        'Открыть базу клиентов',
                        outlined: true,
                        onPressed: onClients,
                      ),
                      const SizedBox(height: 12),
                      BankButton(
                        'Создать заявку на кредит',
                        onPressed: onCreateApplication,
                      ),
                      const SizedBox(height: 12),
                      BankButton(
                        'Блокировка карты СБ',
                        outlined: true,
                        color: bankRed,
                        onPressed: onAccounts,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final bool isAccent;
  final bool isWarning;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.sub,
    this.isAccent = false,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Panel(
      borderColor: isAccent
          ? bankBlue
          : isWarning
              ? bankRed
              : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: bankGrey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            sub,
            style: TextStyle(
              fontSize: 11,
              color: isAccent
                  ? bankGreen
                  : isWarning
                      ? bankRed
                      : bankGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartGroup extends StatelessWidget {
  final String label;
  final double val1;
  final double val2;

  const BarChartGroup({
    super.key,
    required this.label,
    required this.val1,
    required this.val2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 12, height: val1, color: bankGreen),
            const SizedBox(width: 4),
            Container(width: 12, height: val2, color: bankRed),
          ],
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 12, color: bankGrey)),
      ],
    );
  }
}

// ============================================================================
// БАЗА КЛИЕНТОВ
// ============================================================================

class ClientsScreen extends StatefulWidget {
  final List<BankClient> clients;
  final ValueChanged<BankClient> onOpenClient;

  const ClientsScreen({
    super.key,
    required this.clients,
    required this.onOpenClient,
  });

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();

  String nameQuery = '';
  String phoneQuery = '';
  String idQuery = '';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    idController.dispose();
    super.dispose();
  }

  void search() {
    setState(() {
      nameQuery = nameController.text.trim().toLowerCase();
      phoneQuery = phoneController.text.trim();
      idQuery = idController.text.trim().replaceAll('#', '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.clients.where((client) {
      return client.name.toLowerCase().contains(nameQuery) &&
          client.phone.contains(phoneQuery) &&
          client.id.contains(idQuery);
    }).toList();

    return PageLayout(
      title: 'База клиентов',
      child: Column(
        children: [
          Panel(
            title: 'Параметры поиска клиентов',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: FieldLabel(
                    label: 'ФИО клиента',
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Васильева'),
                      onSubmitted: (_) => search(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FieldLabel(
                    label: 'Номер телефона',
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: '+7 (999) •••-••-••',
                      ),
                      onSubmitted: (_) => search(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FieldLabel(
                    label: 'ID клиента',
                    child: TextField(
                      controller: idController,
                      decoration: const InputDecoration(hintText: '842910'),
                      onSubmitted: (_) => search(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                BankButton('Найти', onPressed: search),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Panel(
            title: 'Найдено: ${filtered.length}',
            child: BankTable(
              columns: const [
                'ID',
                'ФИО КЛИЕНТА',
                'ТЕЛЕФОН',
                'ПРОДУКТЫ',
                'БАЛАНС',
                'СТАТУС',
              ],
              rows: filtered.map((client) {
                return DataRow(
                  onSelectChanged: (_) => widget.onOpenClient(client),
                  cells: [
                    DataCell(Text('#${client.id}')),
                    DataCell(
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFFEFF6FF),
                            child: Text(
                              client.initials,
                              style: const TextStyle(
                                fontSize: 10,
                                color: bankBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(client.name),
                        ],
                      ),
                    ),
                    DataCell(Text(client.phone)),
                    DataCell(Text(client.products)),
                    DataCell(Text(money(client.balance))),
                    DataCell(
                      StatusBadge(
                        client.isPro ? 'PRO-статус' : 'Обычный',
                        color: client.isPro ? bankBlue : bankGreen,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// КАРТОЧКА КЛИЕНТА
// ============================================================================

class ClientDetailsScreen extends StatelessWidget {
  final BankClient client;
  final VoidCallback onBack;
  final VoidCallback onCreateApplication;
  final VoidCallback onAccounts;
  final VoidCallback onRepayment;

  const ClientDetailsScreen({
    super.key,
    required this.client,
    required this.onBack,
    required this.onCreateApplication,
    required this.onAccounts,
    required this.onRepayment,
  });

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Карточка клиента • ID ${client.id}',
      action: BankButton(
        '← К клиентам',
        outlined: true,
        onPressed: onBack,
      ),
      child: Column(
        children: [
          Panel(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFEFF6FF),
                  child: Text(
                    client.initials,
                    style: const TextStyle(color: bankBlue, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${client.phone} • ${client.email}',
                        style: const TextStyle(color: bankGrey, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      StatusBadge(
                        client.isPro ? 'PRO-статус' : 'Обычный клиент',
                        color: bankBlue,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'ДОСТУПНО НА СЧЁТЕ',
                      style: TextStyle(color: bankGrey, fontSize: 10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      money(client.balance),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Panel(
                  title: 'Данные и продукты клиента',
                  child: Column(
                    children: [
                      InfoLine('ID клиента', client.id),
                      InfoLine('Телефон', client.phone),
                      InfoLine('E-mail', client.email),
                      InfoLine('Продукты', client.products),
                      InfoLine('Баланс счёта', money(client.balance)),
                      InfoLine('Кредитная задолженность', money(client.debt)),
                      const Divider(height: 30),
                      const InfoLine(
                        'Последняя операция',
                        'Оплата в супермаркете',
                      ),
                      const InfoLine('Сумма операции', '− ₽ 2 450,00'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Panel(
                  title: 'Операции с клиентом',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BankButton(
                        'Новая заявка на кредит',
                        onPressed: onCreateApplication,
                      ),
                      const SizedBox(height: 12),
                      BankButton(
                        'Счета и карты',
                        outlined: true,
                        onPressed: onAccounts,
                      ),
                      const SizedBox(height: 12),
                      BankButton(
                        'Погашение кредита',
                        outlined: true,
                        onPressed: onRepayment,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// СЧЕТА И КАРТЫ
// ============================================================================

class AccountsCardsScreen extends StatelessWidget {
  final BankClient client;
  final VoidCallback onToggleCard;

  const AccountsCardsScreen({
    super.key,
    required this.client,
    required this.onToggleCard,
  });

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Счета и карты',
      child: Column(
        children: [
          Panel(
            title: client.name,
            child: BankTable(
              columns: const ['СЧЁТ', 'ТИП', 'ВАЛЮТА', 'БАЛАНС', 'СТАТУС'],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text('40817 •••• ${client.id}')),
                    const DataCell(Text('Текущий счёт')),
                    const DataCell(Text('RUB')),
                    DataCell(Text(money(client.balance))),
                    const DataCell(StatusBadge('Активен')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Panel(
            title: 'Банковская карта',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 310,
                  height: 185,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: client.cardBlocked
                          ? const [Color(0xFF64748B), Color(0xFF1E293B)]
                          : const [Color(0xFF2563EB), Color(0xFF10234B)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TriBit Bank',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '••••  ••••  ••••  ${client.id.substring(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '08/29',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'МИР',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StatusBadge(
                        client.cardBlocked ? 'Заблокирована' : 'Активна',
                      ),
                      const SizedBox(height: 12),
                      InfoLine('Держатель', client.name),
                      const InfoLine('Тип карты', 'MIR Classic'),
                      const InfoLine('Срок действия', '08/29'),
                      const SizedBox(height: 12),
                      BankButton(
                        client.cardBlocked
                            ? 'Разблокировать карту'
                            : 'Заблокировать карту',
                        outlined: true,
                        color: client.cardBlocked ? bankGreen : bankRed,
                        onPressed: onToggleCard,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// СПИСОК КРЕДИТНЫХ ЗАЯВОК
// ============================================================================

class CreditApplicationsScreen extends StatefulWidget {
  final List<CreditApplication> applications;
  final ValueChanged<CreditApplication> onOpen;
  final VoidCallback onCreate;

  const CreditApplicationsScreen({
    super.key,
    required this.applications,
    required this.onOpen,
    required this.onCreate,
  });

  @override
  State<CreditApplicationsScreen> createState() =>
      _CreditApplicationsScreenState();
}

class _CreditApplicationsScreenState
    extends State<CreditApplicationsScreen> {
  String query = '';
  String status = 'Все статусы';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.applications.where((application) {
      return '${application.id} ${application.client.name}'
              .toLowerCase()
              .contains(query.toLowerCase()) &&
          (status == 'Все статусы' || application.status == status);
    }).toList();

    return PageLayout(
      title: 'Управление кредитными заявками',
      action: BankButton(
        '＋ Создать заявку',
        onPressed: widget.onCreate,
      ),
      child: Panel(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => query = value),
                    decoration: const InputDecoration(
                      hintText: 'Номер заявки или ФИО клиента',
                      prefixIcon: Icon(Icons.search, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  width: 210,
                  child: DropdownButtonFormField<String>(
                    value: status,
                    items: const [
                      'Все статусы',
                      'На рассмотрении',
                      'Одобрена',
                      'Отклонена',
                    ].map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => status = value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BankTable(
              columns: const [
                'НОМЕР',
                'КЛИЕНТ',
                'СУММА',
                'СРОК',
                'ДАТА',
                'СТАТУС',
              ],
              rows: filtered.map((application) {
                return DataRow(
                  onSelectChanged: (_) => widget.onOpen(application),
                  cells: [
                    DataCell(
                      Text(
                        application.id,
                        style: const TextStyle(color: bankBlue),
                      ),
                    ),
                    DataCell(Text(application.client.name)),
                    DataCell(Text(money(application.amount))),
                    DataCell(Text('${application.months} мес.')),
                    DataCell(Text(dateText(application.createdAt))),
                    DataCell(StatusBadge(application.status)),
                  ],
                );
              }).toList(),
            ),
            if (filtered.isEmpty)
              const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Заявки не найдены',
                  style: TextStyle(color: bankGrey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// СОЗДАНИЕ КРЕДИТНОЙ ЗАЯВКИ
// ============================================================================

class CreateCreditApplicationScreen extends StatefulWidget {
  final List<BankClient> clients;
  final BankClient initialClient;
  final void Function(
    BankClient client,
    String product,
    double amount,
    int months,
  ) onSubmit;
  final VoidCallback onBack;

  const CreateCreditApplicationScreen({
    super.key,
    required this.clients,
    required this.initialClient,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<CreateCreditApplicationScreen> createState() =>
      _CreateCreditApplicationScreenState();
}

class _CreateCreditApplicationScreenState
    extends State<CreateCreditApplicationScreen> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController(text: '450000');

  late BankClient selectedClient;
  String product = 'Потребительский кредит';
  int months = 36;
  bool consent = false;

  @override
  void initState() {
    super.initState();
    selectedClient = widget.initialClient;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  double? get amount => double.tryParse(
    amountController.text.replaceAll(' ', '').replaceAll(',', '.'),
  );

  void submit() {
    if (!formKey.currentState!.validate()) return;

    if (!consent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Подтвердите согласие клиента')),
      );
      return;
    }

    widget.onSubmit(selectedClient, product, amount!, months);
  }

  @override
  Widget build(BuildContext context) {
    final currentAmount = amount;

    return PageLayout(
      title: 'Создание кредитной заявки',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Panel(
              title: 'Параметры кредита',
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldLabel(
                      label: 'Клиент',
                      child: DropdownButtonFormField<BankClient>(
                        value: selectedClient,
                        isExpanded: true,
                        items: widget.clients.map((client) {
                          return DropdownMenuItem(
                            value: client,
                            child: Text(
                              client.name,
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (client) {
                          if (client != null) {
                            setState(() => selectedClient = client);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    FieldLabel(
                      label: 'Кредитный продукт',
                      child: DropdownButtonFormField<String>(
                        value: product,
                        items: const [
                          'Потребительский кредит',
                          'Автокредит',
                          'Рефинансирование',
                        ].map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => product = value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: FieldLabel(
                            label: 'Сумма кредита, ₽',
                            child: TextFormField(
                              controller: amountController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              onChanged: (_) => setState(() {}),
                              validator: (_) {
                                final value = amount;

                                if (value == null ||
                                    !value.isFinite ||
                                    value < 10000 ||
                                    value > 5000000) {
                                  return 'От 10 000 до 5 000 000 ₽';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FieldLabel(
                            label: 'Срок кредитования',
                            child: DropdownButtonFormField<int>(
                              value: months,
                              items: [12, 24, 36, 48, 60].map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text('$value месяцев'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => months = value);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: consent,
                      onChanged: (value) {
                        setState(() => consent = value ?? false);
                      },
                      title: const Text(
                        'Согласие клиента на обработку данных получено',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BankButton(
                          'Назад',
                          outlined: true,
                          onPressed: widget.onBack,
                        ),
                        const SizedBox(width: 12),
                        BankButton(
                          'Создать заявку',
                          onPressed: submit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Panel(
              title: 'Текущий клиент',
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFEFF6FF),
                    child: Text(
                      selectedClient.initials,
                      style: const TextStyle(color: bankBlue),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    selectedClient.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InfoLine('ID', selectedClient.id),
                  InfoLine('Продукт', product),
                  InfoLine(
                    'Сумма',
                    currentAmount != null && currentAmount.isFinite
                        ? money(currentAmount)
                        : '—',
                  ),
                  InfoLine('Срок', '$months мес.'),
                  const SizedBox(height: 16),
                  const Text(
                    'Демонстрационная заявка. Расчёт ставки '
                    'и графика платежей не подключён.',
                    style: TextStyle(
                      fontSize: 11,
                      color: bankGrey,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ДЕТАЛИ КРЕДИТНОЙ ЗАЯВКИ
// ============================================================================

class CreditApplicationDetailsScreen extends StatelessWidget {
  final CreditApplication application;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const CreditApplicationDetailsScreen({
    super.key,
    required this.application,
    required this.onBack,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final pending = application.status == 'На рассмотрении';

    return PageLayout(
      title: 'Детали заявки ${application.id}',
      action: BankButton(
        '← К заявкам',
        outlined: true,
        onPressed: onBack,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Panel(
              title: 'Сведения о заявителе и параметрах',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusBadge(application.status),
                  const SizedBox(height: 18),
                  InfoLine('Клиент', application.client.name),
                  InfoLine('ID клиента', application.client.id),
                  InfoLine('Продукт', application.product),
                  InfoLine('Сумма кредита', money(application.amount)),
                  InfoLine('Срок', '${application.months} месяцев'),
                  InfoLine('Дата создания', timeText(application.createdAt)),
                  const InfoLine('Ответственный', 'Константин В.'),
                  const Divider(height: 32),
                  const Text(
                    'Решение по заявке',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Одобрение изменяет только статус демонстрационной '
                    'заявки. Выдача денег не выполняется.',
                    style: TextStyle(
                      fontSize: 12,
                      color: bankGrey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: BankButton(
                          'Отклонить заявку',
                          outlined: true,
                          color: bankRed,
                          onPressed: pending ? onReject : null,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: BankButton(
                          'Одобрить заявку',
                          color: bankGreen,
                          onPressed: pending ? onApprove : null,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Panel(
              title: 'Проверки и скоринг',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoLine('Проверка паспорта', 'Не подключена'),
                  InfoLine('Кредитная история', 'Не подключена'),
                  InfoLine('Проверка дохода', 'Не подключена'),
                  InfoLine('Проверка СБ', 'Не подключена'),
                  SizedBox(height: 18),
                  Text(
                    'В этом прототипе внешние проверки '
                    'клиента не выполняются.',
                    style: TextStyle(
                      fontSize: 12,
                      color: bankGrey,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ПОГАШЕНИЕ КРЕДИТА
// ============================================================================

class CreditRepaymentScreen extends StatefulWidget {
  final BankClient client;
  final List<BankClient> clients;
  final ValueChanged<BankClient> onClientChanged;
  final Future<bool> Function(double amount) onPay;

  const CreditRepaymentScreen({
    super.key,
    required this.client,
    required this.clients,
    required this.onClientChanged,
    required this.onPay,
  });

  @override
  State<CreditRepaymentScreen> createState() => _CreditRepaymentScreenState();
}

class _CreditRepaymentScreenState extends State<CreditRepaymentScreen> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController(text: '12500');

  bool fullRepayment = false;
  bool processing = false;
  double? lastPayment;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  double? get amount => double.tryParse(
    amountController.text.replaceAll(' ', '').replaceAll(',', '.'),
  );

  Future<void> pay() async {
    if (!formKey.currentState!.validate()) return;

    final payment = amount!;
    setState(() => processing = true);

    final success = await widget.onPay(payment);

    if (!mounted) return;

    setState(() {
      processing = false;

      if (success) {
        lastPayment = payment;
        if (fullRepayment) {
          amountController.text = widget.client.debt.toStringAsFixed(2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Погашение кредита',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Panel(
              title: 'Оформление платежа',
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldLabel(
                      label: 'Клиент',
                      child: DropdownButtonFormField<BankClient>(
                        value: widget.client,
                        isExpanded: true,
                        items: widget.clients.map((client) {
                          return DropdownMenuItem(
                            value: client,
                            child: Text(
                              client.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: processing
                            ? null
                            : (client) {
                                if (client != null) {
                                  widget.onClientChanged(client);
                                }
                              },
                      ),
                    ),
                    const SizedBox(height: 20),
                    InfoLine('Договор', 'CR-${widget.client.id}'),
                    InfoLine('Доступно на счёте', money(widget.client.balance)),
                    InfoLine('Остаток долга', money(widget.client.debt)),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Полное погашение',
                        style: TextStyle(fontSize: 13),
                      ),
                      value: fullRepayment,
                      onChanged: processing
                          ? null
                          : (value) {
                              setState(() {
                                fullRepayment = value;
                                amountController.text = value
                                    ? widget.client.debt.toStringAsFixed(2)
                                    : '12500';
                              });
                            },
                    ),
                    const SizedBox(height: 14),
                    FieldLabel(
                      label: 'Сумма платежа, ₽',
                      child: TextFormField(
                        controller: amountController,
                        readOnly: fullRepayment || processing,
                        keyboardType:
                            const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (_) {
                          final value = amount;

                          if (value == null ||
                              !value.isFinite ||
                              value <= 0) {
                            return 'Введите положительную сумму';
                          }

                          if (value > widget.client.balance) {
                            return 'Недостаточно средств';
                          }

                          if (value > widget.client.debt) {
                            return 'Сумма больше остатка долга';
                          }

                          if ((value * 100 - (value * 100).round()).abs() >
                              0.000001) {
                            return 'Не больше двух знаков после запятой';
                          }

                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: BankButton(
                        processing ? 'Обработка...' : 'Провести платёж',
                        onPressed:
                            processing || widget.client.debt <= 0 ? null : pay,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Panel(
              title: lastPayment == null
                  ? 'Информация по кредиту'
                  : '✓ Платёж успешно проведён',
              borderColor: lastPayment == null
                  ? null
                  : const Color(0xFFA7F3D0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusBadge(
                    widget.client.debt <= 0 ? 'Погашен' : 'Действующий',
                    color: bankGreen,
                  ),
                  const SizedBox(height: 16),
                  InfoLine('Клиент', widget.client.name),
                  InfoLine('Договор', 'CR-${widget.client.id}'),
                  InfoLine('Остаток долга', money(widget.client.debt)),
                  if (lastPayment != null)
                    InfoLine(
                      'Последний платёж',
                      money(lastPayment!),
                      color: bankGreen,
                    ),
                  const InfoLine('Комиссия в демо', '₽ 0,00'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ЖУРНАЛ ДЕЙСТВИЙ
// ============================================================================

class ActionLogScreen extends StatefulWidget {
  final List<BankLog> logs;

  const ActionLogScreen({super.key, required this.logs});

  @override
  State<ActionLogScreen> createState() => _ActionLogScreenState();
}

class _ActionLogScreenState extends State<ActionLogScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.logs.where((log) {
      return '${log.action} ${log.object}'
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    return PageLayout(
      title: 'Журнал действий персонала',
      child: Panel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                hintText: 'Поиск по действию или объекту',
                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
            const SizedBox(height: 20),
            BankTable(
              columns: const [
                'ДАТА И ВРЕМЯ',
                'СОТРУДНИК',
                'ДЕЙСТВИЕ',
                'ОБЪЕКТ',
                'РЕЗУЛЬТАТ',
              ],
              rows: filtered.map((log) {
                return DataRow(
                  cells: [
                    DataCell(Text(timeText(log.date))),
                    const DataCell(Text('Константин В.')),
                    DataCell(Text(log.action)),
                    DataCell(Text(log.object)),
                    const DataCell(StatusBadge('Успешно')),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              'Записей: ${filtered.length}',
              style: const TextStyle(fontSize: 12, color: bankGrey),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// НАСТРОЙКИ
// ============================================================================

class SettingsScreen extends StatefulWidget {
  final bool emailNotifications;
  final bool applicationNotifications;
  final void Function(bool email, bool applications) onSave;

  const SettingsScreen({
    super.key,
    required this.emailNotifications,
    required this.applicationNotifications,
    required this.onSave,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool emailNotifications;
  late bool applicationNotifications;

  @override
  void initState() {
    super.initState();
    emailNotifications = widget.emailNotifications;
    applicationNotifications = widget.applicationNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Настройки',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Panel(
              title: 'Уведомления',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Уведомления по электронной почте',
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: const Text(
                      'Демонстрационная настройка',
                      style: TextStyle(fontSize: 11, color: bankGrey),
                    ),
                    value: emailNotifications,
                    onChanged: (value) {
                      setState(() => emailNotifications = value);
                    },
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Уведомления о новых заявках',
                      style: TextStyle(fontSize: 13),
                    ),
                    subtitle: const Text(
                      'Демонстрационная настройка',
                      style: TextStyle(fontSize: 11, color: bankGrey),
                    ),
                    value: applicationNotifications,
                    onChanged: (value) {
                      setState(() => applicationNotifications = value);
                    },
                  ),
                  const SizedBox(height: 24),
                  BankButton(
                    'Сохранить настройки',
                    onPressed: () => widget.onSave(
                      emailNotifications,
                      applicationNotifications,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Panel(
              title: 'Профиль сотрудника',
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFEFF6FF),
                    child: Text('КВ', style: TextStyle(color: bankBlue)),
                  ),
                  SizedBox(height: 20),
                  InfoLine('Сотрудник', 'Константин В.'),
                  InfoLine('Должность', 'Старший андеррайтер'),
                  InfoLine('E-mail', 'k.vorobiev@tribit.ru'),
                  InfoLine('Язык', 'Русский'),
                  InfoLine('Режим', 'Демонстрационный'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
>>>>>>> 5f2d5c40d7858a6fd0114220828d4ee7c8e32069
}