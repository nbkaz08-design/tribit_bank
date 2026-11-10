import 'dart:convert';
import 'dart:io';
import 'dart:ui' show instantiateImageCodec;
import 'package:bcrypt/bcrypt.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await workplace.load();
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(1000, 650));

  runApp(
    MultiProvider(
      providers: [
        // 1. База: один экземпляр, закрывается при выходе из приложения.
        Provider<AppDatabase>(
          // Если флаг не передан, база создаётся с демо-данными по умолчанию,
          // чтобы приложение сразу могло работать через реальные таблицы БД.
          create: (_) => AppDatabase(
            seedDemo: const bool.fromEnvironment(
              'SEED_DEMO',
              defaultValue: false,
            ),
          ),
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
      child: MaterialApp(home: const MyApp()),
    ),
  );
}

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

String cardTail(String rawId) {
  final digits = rawId.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return '0000';
  if (digits.length <= 4) return digits.padLeft(4, '0');
  return digits.substring(digits.length - 4);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode get _themeMode => workplace.theme;
  set _themeMode(ThemeMode value) { workplace.theme = value; workplace.save(); }
  void refreshAppearance() { if (mounted) setState(() {}); }
  @override
  void initState() { super.initState(); workplace.addListener(refreshAppearance); }
  @override
  void dispose() { workplace.removeListener(refreshAppearance); super.dispose(); }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriBit Bank Portal',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      darkTheme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bankDark,
        fontFamily: 'Roboto',
        primaryColor: workplace.accent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: workplace.accent,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF14213D),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(7)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFF263449)),
          ),
        ),
      ),
      builder: (context, child) => Stack(
        children: [
          child ?? const SizedBox.shrink(),
          Positioned(
            top: 16,
            right: 16,
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              shape: const CircleBorder(),
              child: IconButton(
                tooltip: 'Переключить тему',
                onPressed: _toggleTheme,
                icon: Icon(
                  Theme.of(context).brightness == Brightness.dark
                      ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: bankBackground,
        fontFamily: 'Roboto',
        primaryColor: workplace.accent,
        colorScheme: ColorScheme.fromSeed(seedColor: workplace.accent),
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
  final ScrollController _desktopHorizontalScroll = ScrollController();

  @override
  void dispose() {
    _desktopHorizontalScroll.dispose();
    super.dispose();
  }

  ActiveTab _currentTab = ActiveTab.auth;

  final clients = <BankClient>[];

  late BankClient selectedClient;
  late List<CreditApplication> applications;
  CreditApplication? selectedApplication;

  final logs = <BankLog>[];
  String currentEmployeeName = 'Неизвестный сотрудник';
  String currentEmployeePosition = 'Сотрудник';

  int nextApplication = 15;
  bool emailNotifications = true;
  bool applicationNotifications = true;

  BankClient _emptyClient() => BankClient(
        id: '0',
        name: 'Нет клиента',
        initials: '—',
        phone: '',
        email: '',
        products: '0',
        balance: 0,
      );

  String _initials(String fullName) {
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '—';
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'
        .toUpperCase();
  }

  String _uiStatus(LoanApplicationStatus status) {
    switch (status) {
      case LoanApplicationStatus.pending:
        return 'На рассмотрении';
      case LoanApplicationStatus.approved:
        return 'Одобрена';
      case LoanApplicationStatus.rejected:
        return 'Отклонена';
    }
  }

  Future<void> _loadDbData() async {
    final db = context.read<AppDatabase>();
    final clientRows = await db.select(db.clients).get();
    final mappedClients = <BankClient>[];

    for (final clientRow in clientRows) {
      final accounts = await (db.select(db.accounts)
            ..where((a) => a.clientId.equals(clientRow.id)))
          .get();

      final debtQuery = db.select(db.loans).join([
        innerJoin(db.accounts, db.accounts.id.equalsExp(db.loans.accountId)),
      ])
        ..where(db.accounts.clientId.equals(clientRow.id));
      final debtRows = await debtQuery.get();
      final debt = debtRows.fold<int>(0, (sum, row) {
        final loan = row.readTable(db.loans);
        return sum + loan.remaining;
      });

      final balance = accounts.fold<int>(0, (sum, account) => sum + account.balance);

      mappedClients.add(
        BankClient(
          id: clientRow.id.toString(),
          name: clientRow.fullName,
          initials: _initials(clientRow.fullName),
          phone: clientRow.phone ?? '+7 (000) •••-••-••',
          email: clientRow.email ?? 'no-email@tribit.local',
          products: '${accounts.length} ${accounts.length == 1 ? 'счёт' : 'счёта'}',
          balance: balance / 100,
          debt: debt / 100,
          isPro: false,
        ),
      );
    }

    final applicationRows = await db.select(db.loanApplications).get();
    final loadedApplications = <CreditApplication>[];

    for (final appRow in applicationRows) {
      final client = mappedClients.firstWhere(
        (item) => item.id == appRow.clientId.toString(),
        orElse: () => _emptyClient(),
      );

      loadedApplications.add(
        CreditApplication(
          id: 'APP-${appRow.id}',
          client: client,
          product: appRow.amount >= 1000000 ? 'Автокредит' : 'Потребительский кредит',
          amount: appRow.amount / 100,
          months: appRow.termMonths,
          createdAt: appRow.createdAt,
          status: _uiStatus(appRow.status),
        ),
      );
    }

    if (!mounted) return;
    setState(() {
      clients
        ..clear()
        ..addAll(mappedClients);
      selectedClient = clients.isNotEmpty ? clients.first : _emptyClient();
      applications = loadedApplications;
      if (applications.isNotEmpty) {
        selectedApplication = applications.first;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    selectedClient = _emptyClient();
    applications = [];
    _loadDbData();
  }

  void setCurrentEmployee(String name, String position) {
    setState(() {
      currentEmployeeName = name;
      currentEmployeePosition = position;
    });
  }

  void navigate(ActiveTab tab) {
    if (tab == ActiveTab.createCreditApplication) {
      message('Сотрудник не может создавать кредитные заявки');
      return;
    }
    setState(() {
      if (_currentTab == ActiveTab.auth && tab != ActiveTab.auth) {
        addLog('Вход в систему', currentEmployeeName);
      }
      if (tab == ActiveTab.auth) {
        addLog('Выход из системы', currentEmployeeName);
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
      '${client.name}\nКарта •••• ${cardTail(client.id)}',
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
        return MainAuth(
          onTabChanged: navigate,
          onEmployeeLoggedIn: (name) => setCurrentEmployee(name, 'Сотрудник'),
          onEmployeePositionLoggedIn: (position) {
            setState(() => currentEmployeePosition = position);
          },
        );

      case ActiveTab.overview:
        return OverviewScreen(
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
          onAccounts: () => navigate(ActiveTab.accounts),
        );

      case ActiveTab.accounts:
        return AccountsCardsScreen(
          clients: clients,
          onClientChanged: (client) => setState(() => selectedClient = client),
          client: selectedClient,
          onToggleCard: toggleCard,
        );

      case ActiveTab.creditApplications:
        return CreditApplicationsScreen(
          applications: applications,
          onOpen: openApplication,
        );

      case ActiveTab.createCreditApplication:
        return const Center(
          child: Text('Создание кредитной заявки сотрудником недоступно'),
        );

      case ActiveTab.creditApplicationDetails:
        final application = selectedApplication;

        if (application == null) {
          return const Center(child: Text('Выберите заявку'));
        }

        return CreditApplicationDetailsScreen(
          application: application,
          employeeName: currentEmployeeName,
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
        return ActionLogScreen(
          logs: logs,
          employeeName: currentEmployeeName,
        );

      case ActiveTab.settings:
        return SettingsScreen(
          employeeName: currentEmployeeName,
          employeePosition: currentEmployeePosition,
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
              employeeName: currentEmployeeName,
              employeePosition: currentEmployeePosition,
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

                return Scrollbar(
                  controller: _desktopHorizontalScroll,
                  thumbVisibility: constraints.maxWidth < minimumWidth,
                  trackVisibility: constraints.maxWidth < minimumWidth,
                  interactive: true,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  notificationPredicate: (notification) => notification.depth == 0,
                  child: SingleChildScrollView(
                    controller: _desktopHorizontalScroll,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: width,
                      height: constraints.maxHeight,
                      child: buildContent(),
                    ),
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
  final String employeeName;
  final String employeePosition;
  final ValueChanged<ActiveTab> onTabChanged;

  const SideInfo({
    super.key,
    required this.currentTab,
    required this.employeeName,
    required this.employeePosition,
    required this.onTabChanged,
  });

  String _initials(String fullName) {
    final words = fullName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || words.first.isEmpty) return '—';
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'
        .toUpperCase();
  }

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
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueGrey,
                child: Text(
                  _initials(employeeName),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employeeName,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employeePosition,
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
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor ?? Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: TextStyle(
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
                color: color ?? Theme.of(context).colorScheme.onSurface,
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
              dataTextStyle: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurface,
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

class MainAuth extends StatefulWidget {
  final ValueChanged<ActiveTab> onTabChanged;
  final ValueChanged<String> onEmployeeLoggedIn;
  final ValueChanged<String> onEmployeePositionLoggedIn;

  const MainAuth({
    super.key,
    required this.onTabChanged,
    required this.onEmployeeLoggedIn,
    required this.onEmployeePositionLoggedIn,
  });

  @override
  State<MainAuth> createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth> {
  final _loginController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'password');
  bool _isLoading = false;

  Future<void> _login() async {
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    if (login.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите логин и пароль')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authRepo = context.read<AuthRepository>();
      final user = await authRepo.login(login, password);
      if (!mounted) return;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный логин или пароль')),
        );
        return;
      }

      workplace.userId = user.id;
      workplace.login = user.login;
      workplace.event('Вход в приложение');
      try { await workplace.save(); } catch (_) {}
      if (!mounted) return;
      final employee = await authRepo.getEmployeeByUserId(user.id);
      widget.onEmployeeLoggedIn(employee?.fullName ?? user.login);
      widget.onEmployeePositionLoggedIn(employee?.position ?? 'Сотрудник');
      widget.onTabChanged(ActiveTab.overview);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка авторизации: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                  Text(
                    'Авторизация сотрудника',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Введите учетные данные для доступа в систему',
                    style: TextStyle(color: bankGrey, fontSize: 14),
                  ),
                  const SizedBox(height: 32),
                  FieldLabel(
                    label: 'Логин',
                    child: TextFormField(
                      controller: _loginController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  FieldLabel(
                    label: 'Пароль',
                    child: TextFormField(
                      controller: _passwordController,
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
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: bankBlue,
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
                    _isLoading ? 'Входим...' : 'Подтвердить и войти',
                    onPressed: _isLoading ? null : _login,
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
  final VoidCallback onClients;
  final VoidCallback onAccounts;

  const OverviewScreen({
    super.key,
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
  final VoidCallback onAccounts;

  const ClientDetailsScreen({
    super.key,
    required this.client,
    required this.onBack,
    required this.onAccounts,
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
                        'Счета и карты',
                        outlined: true,
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

// ============================================================================
// СЧЕТА И КАРТЫ
// ============================================================================

class AccountsCardsScreen extends StatelessWidget {
  final List<BankClient> clients;
  final ValueChanged<BankClient> onClientChanged;
  final BankClient client;
  final VoidCallback onToggleCard;

  const AccountsCardsScreen({
    super.key,
    required this.clients,
    required this.onClientChanged,
    required this.client,
    required this.onToggleCard,
  });

  @override
  Widget build(BuildContext context) {
    if (clients.isEmpty) {
      return const PageLayout(title: 'Счета и карты',
        child: Panel(child: Text('Клиенты ещё не загружены или отсутствуют.')));
    }
    final ids = clients.map((c) => c.id).toList()..sort();
    final rank = ids.indexOf(client.id);
    final style = (rank < 0 ? 0 : rank) % 3;
    final cardName = ['Classic', 'Aurora', 'Black Gold'][style];
    return PageLayout(
      title: 'Счета и карты',
      child: Column(
        children: [
          ClientSearchPanel(clients: clients, selectedClient: client,
            onSelected: onClientChanged),
          const SizedBox(height: 20),
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
                ClientCardArtwork(client: client, style: style),
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
                      InfoLine('Оформление карты', 'MIR $cardName'),
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

  const CreditApplicationsScreen({
    super.key,
    required this.applications,
    required this.onOpen,
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
  final String employeeName;
  final VoidCallback onBack;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const CreditApplicationDetailsScreen({
    super.key,
    required this.application,
    required this.employeeName,
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
                  InfoLine('Ответственный', employeeName),
                  const Divider(height: 32),
                  const Text(
                    'Решение по заявке',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
  final String employeeName;

  const ActionLogScreen({
    super.key,
    required this.logs,
    required this.employeeName,
  });

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
                    DataCell(Text(widget.employeeName)),
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
  final String employeeName;
  final String employeePosition;
  final bool emailNotifications;
  final bool applicationNotifications;
  final void Function(bool email, bool applications) onSave;
  const SettingsScreen({super.key, required this.employeeName,
    required this.employeePosition, required this.emailNotifications,
    required this.applicationNotifications, required this.onSave});
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

  void note(String text) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> saveLocal(String text) async {
    try { await workplace.save(); if (mounted) setState(() {}); note(text); }
    catch (_) { note('Не удалось сохранить локальные настройки'); }
  }

  Future<List<String>?> fields(String title, List<String> labels,
      {List<String>? initial, bool secret = false}) async {
    final controls = List.generate(labels.length,
      (i) => TextEditingController(text: initial == null ? '' : initial[i]));
    final result = await showDialog<List<String>>(context: context, builder: (ctx) => AlertDialog(
      title: Text(title),
      content: SizedBox(width: 460, child: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: TextField(controller: controls[i], obscureText: secret,
            autocorrect: !secret, enableSuggestions: !secret,
            maxLines: secret ? 1 : null,
            decoration: InputDecoration(labelText: labels[i])),
        )),
      ))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
        TextButton(onPressed: () => Navigator.pop(ctx,
          controls.map((c) => c.text).toList()), child: const Text('Продолжить')),
      ],
    ));
    await Future<void>.delayed(const Duration(milliseconds: 350));
    for (final c in controls) { c.dispose(); }
    return result;
  }

  Future<void> info(String title, String text) => showDialog<void>(context: context,
    builder: (ctx) => AlertDialog(title: Text(title),
      content: SizedBox(width: 500, child: SingleChildScrollView(child: SelectableText(text))),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Закрыть'))]));

  Future<void> editContacts() async {
    final p = workplace.profile;
    final values = await fields('Мои контакты', ['Рабочий телефон', 'E-mail'],
      initial: ['${p['phone'] ?? ''}', '${p['email'] ?? ''}']);
    if (values == null || !mounted) return;
    final email = values[1].trim();
    if (email.isNotEmpty && !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      note('Введите корректный e-mail'); return;
    }
    p['phone'] = values[0].trim(); p['email'] = email;
    await saveLocal('Контакты сохранены локально. Кадровая запись БД не изменена.');
  }

  Future<void> loadPhoto() async {
    final values = await fields('Фото профиля', ['Полный путь к JPG или PNG (до 5 МБ)']);
    if (values == null || !mounted) return;
    try {
      final file = File(values[0].trim().replaceAll('"', ''));
      if (await file.length() > 5 * 1024 * 1024) { note('Размер фото должен быть до 5 МБ'); return; }
      final bytes = await file.readAsBytes();
      final codec = await instantiateImageCodec(bytes); codec.dispose();
      workplace.profile['photo'] = base64Encode(bytes);
      await saveLocal('Фото сохранено');
    } catch (_) { note('Не удалось открыть изображение. Проверьте путь и формат.'); }
  }

  Future<void> changePassword() async {
    if (workplace.userId == null) { note('Войдите заново'); return; }
    final values = await fields('Смена пароля',
      ['Текущий пароль', 'Новый пароль — минимум 10 символов', 'Повторите новый пароль'], secret: true);
    if (values == null || !mounted) return;
    if (values[1].length < 10 || values[1] != values[2] || values[0] == values[1]) {
      note('Новый пароль: от 10 символов, отличается от старого; повторы должны совпадать'); return;
    }
    try {
      final db = context.read<AppDatabase>();
      final user = await context.read<AuthRepository>().login(workplace.login, values[0]);
      if (user == null || user.id != workplace.userId) { note('Текущий пароль неверный'); return; }
      await (db.update(db.users)..where((u) => u.id.equals(user.id))).write(
        UsersCompanion(passwordHash: Value(BCrypt.hashpw(values[1], BCrypt.gensalt()))));
      workplace.event('Пароль изменён');
      try { await workplace.save(); } catch (_) {}
      note('Пароль изменён в БД');
    } catch (_) { note('Не удалось изменить пароль'); }
  }

  Future<void> lockWorkplace() async {
    if (workplace.userId == null) { note('Войдите заново'); return; }
    final repo = context.read<AuthRepository>();
    final userId = workplace.userId;
    final login = workplace.login;
    final control = TextEditingController();
    String? error;
    bool busy = false;
    workplace.event('Рабочее место заблокировано');
    await showDialog<void>(context: context, barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(builder: (ctx, update) {
        Future<void> unlock() async {
          if (busy) return;
          update(() { busy = true; error = null; });
          try {
            final user = await repo.login(login, control.text);
            if (!ctx.mounted) return;
            if (user != null && user.id == userId) {
              workplace.event('Рабочее место разблокировано');
              Navigator.pop(dialogContext);
            } else { update(() => error = 'Неверный пароль или аккаунт отключён'); }
          } catch (_) { if (ctx.mounted) update(() => error = 'Не удалось проверить пароль'); }
          finally { if (ctx.mounted) update(() => busy = false); }
        }
        return PopScope(canPop: false, child: AlertDialog(
          title: const Text('Рабочее место заблокировано'),
          content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Введите пароль аккаунта $login'), const SizedBox(height: 16),
            TextField(controller: control, obscureText: true, autocorrect: false,
              enableSuggestions: false, onSubmitted: (_) => unlock(),
              decoration: InputDecoration(labelText: 'Пароль', errorText: error)),
          ])),
          actions: [TextButton(onPressed: busy ? null : unlock,
            child: Text(busy ? 'Проверка…' : 'Разблокировать'))],
        ));
      }));
    await Future<void>.delayed(const Duration(milliseconds: 350));
    control.dispose();
    try { await workplace.save(); } catch (_) {}
  }

  Future<void> history() async {
    final events = List<dynamic>.from(workplace.profile['events'] ?? []);
    await info('История входов и безопасности',
      'Только события этой версии на этом компьютере. Не является журналом аудита.\n\n' +
      (events.isEmpty ? 'Событий пока нет' : events.reversed.map((e) =>
        '${e['time']} — ${e['action']}').join('\n\n')));
  }

  Future<void> support() async {
    final result = await fields('Черновик обращения — без отправки',
      ['Тема', 'Описание — без паролей и данных клиентов']);
    if (result == null || !mounted) return;
    if (result.any((v) => v.trim().isEmpty)) { note('Заполните тему и описание'); return; }
    final drafts = List<dynamic>.from(workplace.profile['drafts'] ?? []);
    drafts.add({'subject': result[0].trim(), 'text': result[1].trim(),
      'time': DateTime.now().toIso8601String()});
    workplace.profile['drafts'] = drafts;
    await saveLocal('Черновик сохранён локально. Обращение не отправлено.');
  }

  Widget section(String title, IconData icon, String subtitle, Widget child) {
    final color = Theme.of(context).colorScheme.primary;
    return Panel(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 22)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 11, color: bankGrey)),
        ])),
      ]),
      const SizedBox(height: 20), child,
    ]));
  }

  Widget actionRow(IconData icon, String title, String subtitle, VoidCallback action) =>
    ListTile(contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 21),
      title: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
      trailing: const Icon(Icons.chevron_right, size: 20), onTap: action);

  String value(String key) {
    final text = '${workplace.profile[key] ?? ''}'.trim();
    return text.isEmpty ? 'Не указан' : text;
  }

  Widget profileCard() {
    final photo = workplace.profile['photo'] as String?;
    final words = widget.employeeName.trim().split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty).take(2);
    final initials = words.map((w) => w[0]).join();
    return section('Мой профиль', Icons.person_outline, 'Личные данные и контакты',
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          CircleAvatar(radius: 34,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.10),
            backgroundImage: photo == null ? null : MemoryImage(base64Decode(photo)),
            child: photo == null ? Text(initials,
              style: TextStyle(fontSize: 19, color: Theme.of(context).colorScheme.primary)) : null),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.employeeName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(widget.employeePosition, style: const TextStyle(color: bankGrey, fontSize: 12)),
            const SizedBox(height: 5),
            Text('Логин: ${workplace.login}', style: const TextStyle(color: bankGrey, fontSize: 11)),
          ])),
        ]),
        const SizedBox(height: 16),
        const Divider(height: 1), const SizedBox(height: 12),
        InfoLine('Телефон', value('phone')), InfoLine('E-mail', value('email')),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          OutlinedButton.icon(onPressed: editContacts, icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text('Изменить контакты')),
          TextButton.icon(onPressed: loadPhoto, icon: const Icon(Icons.photo_camera_outlined, size: 16),
            label: const Text('Изменить фото')),
          if (photo != null) TextButton(onPressed: () async {
            workplace.profile.remove('photo'); await saveLocal('Фото удалено');
          }, child: const Text('Удалить фото')),
        ]),
        const SizedBox(height: 8),
        const Text('Фото и контакты сохраняются локально, отдельно от кадровой записи БД.',
          style: TextStyle(color: bankGrey, fontSize: 10, height: 1.5)),
      ]));
  }

  Widget securityCard() => section('Безопасность', Icons.lock_outline,
    'Защита аккаунта и рабочего места', Column(children: [
      actionRow(Icons.key_outlined, 'Сменить пароль', 'Потребуется текущий пароль', changePassword),
      const Divider(height: 1),
      actionRow(Icons.lock_outline, 'Заблокировать окно', 'Продолжение работы по паролю', lockWorkplace),
      const Divider(height: 1),
      actionRow(Icons.history, 'История входов', 'События на этом компьютере', history),
      const SizedBox(height: 8),
      const Text('Блокировка окна не заменяет блокировку Windows.',
        style: TextStyle(fontSize: 10, color: bankGrey)),
    ]));

  Widget appearanceCard() {
    final modes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
    final labels = ['Светлая', 'Тёмная', 'Системная'];
    final icons = [Icons.light_mode_outlined, Icons.dark_mode_outlined, Icons.settings_brightness];
    final accents = [bankBlue, const Color(0xFF0D9488), const Color(0xFF7C3AED), const Color(0xFFDB2777)];
    final accentLabels = ['Синий', 'Бирюзовый', 'Фиолетовый', 'Розовый'];
    final primary = Theme.of(context).colorScheme.primary;
    return section('Оформление', Icons.palette_outlined, 'Тема и акцентный цвет',
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Тема', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Row(children: List.generate(3, (i) {
          final selected = workplace.theme == modes[i];
          return Expanded(child: Padding(padding: EdgeInsets.only(right: i == 2 ? 0 : 8),
            child: Material(color: selected ? primary.withOpacity(0.10) : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: selected ? primary : Theme.of(context).dividerColor)),
              clipBehavior: Clip.antiAlias,
              child: InkWell(onTap: () async {
                workplace.theme = modes[i]; await saveLocal('Тема сохранена');
              }, child: Padding(padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 4),
                child: Column(children: [
                  Icon(icons[i], color: selected ? primary : bankGrey, size: 23),
                  const SizedBox(height: 7),
                  Text(labels[i], style: TextStyle(fontSize: 11,
                    color: selected ? primary : Theme.of(context).colorScheme.onSurface)),
                ]))),
            )));
        })),
        const SizedBox(height: 20),
        const Text('Акцентный цвет', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 8, children: List.generate(accents.length, (i) => Tooltip(
          message: accentLabels[i], child: Semantics(button: true,
            selected: workplace.accent.value == accents[i].value, label: accentLabels[i],
            child: InkWell(borderRadius: BorderRadius.circular(22), onTap: () async {
              workplace.accent = accents[i]; await saveLocal('Цвет сохранён');
            }, child: CircleAvatar(radius: 20, backgroundColor: accents[i],
              child: workplace.accent.value == accents[i].value
                ? const Icon(Icons.check, color: Colors.white, size: 20) : null)),
          )))),
        const SizedBox(height: 14),
        const Text('Применяется сразу. Цвета статусов, карт и элементов с фиксированным цветом сохраняются.',
          style: TextStyle(fontSize: 10, color: bankGrey, height: 1.5)),
      ]));
  }

  Widget notificationsCard() => section('Уведомления', Icons.notifications_outlined,
    'Параметры оповещений', Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SwitchListTile(contentPadding: EdgeInsets.zero,
        title: const Text('Уведомления по электронной почте', style: TextStyle(fontSize: 13)),
        subtitle: const Text('Демонстрационная настройка', style: TextStyle(fontSize: 11, color: bankGrey)),
        value: emailNotifications, onChanged: (v) => setState(() => emailNotifications = v)),
      const Divider(height: 16),
      SwitchListTile(contentPadding: EdgeInsets.zero,
        title: const Text('Уведомления о новых заявках', style: TextStyle(fontSize: 13)),
        subtitle: const Text('Демонстрационная настройка', style: TextStyle(fontSize: 11, color: bankGrey)),
        value: applicationNotifications, onChanged: (v) => setState(() => applicationNotifications = v)),
      const SizedBox(height: 16),
      ElevatedButton.icon(onPressed: () => widget.onSave(emailNotifications, applicationNotifications),
        icon: const Icon(Icons.check, size: 17), label: const Text('Сохранить настройки'),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15))),
    ]));

  Widget helpCard() => section('Помощь', Icons.help_outline, 'Инструкции и информация о приложении',
    Wrap(spacing: 10, runSpacing: 10, children: [
      OutlinedButton.icon(icon: const Icon(Icons.menu_book_outlined, size: 18),
        onPressed: () => info('Инструкция',
          'Клиенты: найдите клиента и откройте его карточку.\n\n'
          'Счета и карты: выберите поле поиска. По ID — только точное совпадение.\n\n'
          'Фото профиля: укажите полный путь к JPG или PNG до 5 МБ.\n\n'
          'Смена пароля: потребуется текущий пароль.'), label: const Text('Инструкция')),
      OutlinedButton.icon(icon: const Icon(Icons.edit_note, size: 18), onPressed: support,
        label: const Text('Создать обращение')),
      OutlinedButton.icon(icon: const Icon(Icons.drafts_outlined, size: 18), onPressed: () {
        final drafts = List<dynamic>.from(workplace.profile['drafts'] ?? []);
        info('Мои черновики', drafts.isEmpty ? 'Черновиков нет' : drafts.map((d) =>
          '${d['time']}\n${d['subject']}\n${d['text']}').join('\n\n────────\n\n'));
      }, label: const Text('Черновики')),
      OutlinedButton.icon(icon: const Icon(Icons.info_outline, size: 18), onPressed: () => info('О приложении',
        'TriBit Bank Portal\nВерсия: ${const String.fromEnvironment('APP_VERSION', defaultValue: 'не указана')}\n\n'
        'Фото, контакты и черновики хранятся локально. Отправка обращений не подключена.'),
        label: const Text('О приложении')),
    ]));

  @override
  Widget build(BuildContext context) => PageLayout(title: 'Настройки',
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Профиль, безопасность и параметры приложения',
        style: TextStyle(color: bankGrey, fontSize: 13)),
      const SizedBox(height: 24),
      LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(children: [
            profileCard(), const SizedBox(height: 20), securityCard(),
            const SizedBox(height: 20), appearanceCard(),
            const SizedBox(height: 20), notificationsCard(),
          ]);
        }
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Column(children: [profileCard(), const SizedBox(height: 20), securityCard()])),
          const SizedBox(width: 20),
          Expanded(child: Column(children: [appearanceCard(), const SizedBox(height: 20), notificationsCard()])),
        ]);
      }),
      const SizedBox(height: 20), helpCard(),
    ]));
}

class ClientCardArtwork extends StatelessWidget {
  final BankClient client;
  final int style;
  const ClientCardArtwork({super.key, required this.client, required this.style});

  @override
  Widget build(BuildContext context) {
    final names = ['Classic', 'Aurora', 'Black Gold'];
    final colors = <List<Color>>[
      [const Color(0xFF2563EB), const Color(0xFF0B204A)],
      [const Color(0xFF7C3AED), const Color(0xFF192458)],
      [const Color(0xFF242424), const Color(0xFF090B10)],
    ];
    final accents = [const Color(0xFFBFDBFE), const Color(0xFF67E8F9), const Color(0xFFE7C57C)];
    final accent = client.cardBlocked ? Colors.white60 : accents[style];
    return Container(
      width: 340, height: 214, clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withOpacity(0.45)),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: client.cardBlocked
            ? [const Color(0xFF64748B), const Color(0xFF1E293B)] : colors[style]),
      ),
      child: Stack(children: [
        Positioned(right: -40, top: -65, child: Container(
          width: 220, height: 220,
          decoration: BoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: accent.withOpacity(0.15), width: 28)))),
        Positioned(right: 25, bottom: -80, child: Container(
          width: 200, height: 200,
          decoration: BoxDecoration(shape: BoxShape.circle,
            border: Border.all(color: accent.withOpacity(0.1), width: 20)))),
        Padding(padding: const EdgeInsets.all(22),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('TriBit Bank', style: TextStyle(color: Colors.white,
                fontSize: 18, fontWeight: FontWeight.bold)),
              Text(names[style].toUpperCase(), style: TextStyle(color: accent,
                fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 1)),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Container(width: 34, height: 26,
                decoration: BoxDecoration(color: const Color(0xFFE7C57C),
                  borderRadius: BorderRadius.circular(5)),
                child: const Icon(Icons.grid_view, size: 21, color: Color(0xFF8D713D))),
              const SizedBox(width: 12),
              Icon(client.cardBlocked ? Icons.lock_outline : Icons.wifi, size: 23, color: accent),
            ]),
            const Spacer(),
            Text('••••  ••••  ••••  ${cardTail(client.id)}',
              style: const TextStyle(color: Colors.white, fontSize: 21, letterSpacing: 1.5)),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: Text(client.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 10))),
              const SizedBox(width: 12),
              const Text('08/29', style: TextStyle(color: Colors.white70, fontSize: 11)),
              const SizedBox(width: 14),
              Text('МИР', style: TextStyle(color: accent, fontSize: 17, fontWeight: FontWeight.bold)),
            ]),
          ])),
      ]),
    );
  }
}

enum ClientSearchField { fullName, id, phone, email }

class ClientSearchPanel extends StatefulWidget {
  final List<BankClient> clients;
  final BankClient selectedClient;
  final ValueChanged<BankClient> onSelected;
  const ClientSearchPanel({super.key, required this.clients,
    required this.selectedClient, required this.onSelected});
  @override
  State<ClientSearchPanel> createState() => _ClientSearchPanelState();
}

class _ClientSearchPanelState extends State<ClientSearchPanel> {
  final controller = TextEditingController();
  String query = '';
  ClientSearchField field = ClientSearchField.fullName;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String normalize(String value) => value.toLowerCase().replaceAll('ё', 'е')
    .trim().replaceAll(RegExp(r'\s+'), ' ');

  String phone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length == 11 && (digits.startsWith('7') || digits.startsWith('8'))
      ? digits.substring(1) : digits;
  }

  String get hint {
    switch (field) {
      case ClientSearchField.fullName: return 'Введите ФИО или часть имени';
      case ClientSearchField.id: return 'Введите точный ID клиента';
      case ClientSearchField.phone: return 'Введите телефон или часть номера';
      case ClientSearchField.email: return 'Введите e-mail или его часть';
    }
  }

  bool matches(BankClient client) {
    final q = normalize(query);
    if (q.isEmpty) return false;
    switch (field) {
      case ClientSearchField.fullName:
        final name = normalize(client.name);
        return q.split(' ').every((word) => name.contains(word));
      case ClientSearchField.id:
        return client.id.trim() == query.trim();
      case ClientSearchField.phone:
        if (!RegExp(r'^[+\d\s()\-]+$').hasMatch(q)) return false;
        final digits = phone(q);
        return digits.isNotEmpty && phone(client.phone).contains(digits);
      case ClientSearchField.email:
        return normalize(client.email).contains(q);
    }
  }

  void select(BankClient client) {
    widget.onSelected(client);
    setState(() { query = ''; controller.clear(); });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final searching = query.trim().isNotEmpty;
    final results = searching ? widget.clients.where(matches).toList() : <BankClient>[];
    final count = results.length > 30 ? 30 : results.length;
    return Panel(title: 'Поиск клиента',
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: 180, child: DropdownButtonFormField<ClientSearchField>(
            value: field, isExpanded: true,
            decoration: const InputDecoration(labelText: 'Искать по'),
            items: const [
              DropdownMenuItem(value: ClientSearchField.fullName, child: Text('ФИО')),
              DropdownMenuItem(value: ClientSearchField.id, child: Text('ID')),
              DropdownMenuItem(value: ClientSearchField.phone, child: Text('Телефону')),
              DropdownMenuItem(value: ClientSearchField.email, child: Text('E-mail')),
            ],
            onChanged: (value) {
              if (value != null) setState(() {
                field = value; query = ''; controller.clear();
              });
            },
          )),
          const SizedBox(width: 12),
          Expanded(child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            keyboardType: field == ClientSearchField.id ? TextInputType.number
              : field == ClientSearchField.phone ? TextInputType.phone
              : field == ClientSearchField.email ? TextInputType.emailAddress : TextInputType.text,
            onChanged: (value) => setState(() => query = value),
            onSubmitted: (_) { if (results.length == 1) select(results.first); },
            decoration: InputDecoration(
              labelText: 'Запрос', hintText: hint,
              prefixIcon: const Icon(Icons.search, size: 21),
              suffixIcon: query.isEmpty ? null : IconButton(
                tooltip: 'Очистить поиск', icon: const Icon(Icons.close),
                onPressed: () => setState(() { query = ''; controller.clear(); })),
            ),
          )),
        ]),
        const SizedBox(height: 12),
        if (!searching)
          Text(field == ClientSearchField.id
            ? 'По ID используется только точное совпадение.'
            : 'Выберите поле и введите запрос. Можно искать по части значения.',
            style: const TextStyle(color: bankGrey, fontSize: 12)),
        if (searching) ...[
          Text(results.isEmpty ? 'Клиенты не найдены. Проверьте запрос и выбранное поле.'
            : 'Найдено клиентов: ${results.length}',
            style: const TextStyle(color: bankGrey, fontSize: 12)),
          if (results.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).dividerColor)),
              clipBehavior: Clip.antiAlias,
              child: ConstrainedBox(constraints: const BoxConstraints(maxHeight: 300),
                child: ListView.separated(
                  shrinkWrap: true, primary: false, itemCount: count,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final client = results[index];
                    final selected = client.id == widget.selectedClient.id;
                    return ListTile(
                      selected: selected, selectedTileColor: bankBlue.withOpacity(0.08),
                      leading: CircleAvatar(child: Text(client.initials,
                        style: const TextStyle(fontSize: 12))),
                      title: Text(client.name, style: const TextStyle(fontSize: 13,
                        fontWeight: FontWeight.w600)),
                      subtitle: Text('ID: ${client.id} • ${client.phone}\n${client.email}',
                        style: const TextStyle(fontSize: 11)),
                      isThreeLine: true,
                      trailing: Icon(selected ? Icons.check_circle : Icons.chevron_right,
                        color: selected ? bankGreen : bankGrey),
                      onTap: () => select(client),
                    );
                  },
                )),
            ),
            if (results.length > 30)
              const Padding(padding: EdgeInsets.only(top: 8),
                child: Text('Показаны первые 30 совпадений. Уточните запрос.',
                  style: TextStyle(color: bankGrey, fontSize: 11))),
          ],
        ],
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 12),
        Row(children: [
          const Icon(Icons.person_outline, color: bankBlue),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Выбранный клиент', style: TextStyle(color: bankGrey, fontSize: 11)),
            const SizedBox(height: 3),
            Text(widget.selectedClient.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text('ID: ${widget.selectedClient.id} • ${widget.selectedClient.phone}',
              style: const TextStyle(color: bankGrey, fontSize: 11)),
          ])),
        ]),
      ]),
    );
  }
}

final workplace = WorkplacePreferences();

class WorkplacePreferences extends ChangeNotifier {
  Map<String, dynamic> data = {};
  int? userId;
  String login = '';
  ThemeMode theme = ThemeMode.light;
  Color accent = bankBlue;
  Future<void> _pending = Future<void>.value();

  File get file {
    final root = Platform.environment['LOCALAPPDATA'] ??
      Platform.environment['HOME'] ?? Directory.current.path;
    return File('$root${Platform.pathSeparator}TriBitBank${Platform.pathSeparator}workplace.json');
  }
  Map<String, dynamic> get profile {
    final key = 'user_${userId ?? 'guest'}';
    final existing = data[key];
    if (existing is Map<String, dynamic>) return existing;
    final created = <String, dynamic>{}; data[key] = created; return created;
  }
  Future<void> load() async {
    try {
      if (!await file.exists()) return;
      data = Map<String, dynamic>.from(jsonDecode(await file.readAsString()));
      theme = ThemeMode.values.firstWhere((v) => v.name == data['theme'], orElse: () => ThemeMode.light);
      if (data['accent'] is int) accent = Color(data['accent'] as int);
    } catch (_) { data = {}; }
  }
  Future<void> save() {
    data['theme'] = theme.name; data['accent'] = accent.value;
    final content = jsonEncode(data);
    notifyListeners();
    final write = _pending.then((_) async {
      final target = file;
      await target.parent.create(recursive: true);
      await target.writeAsString(content, flush: true);
    });
    _pending = write.catchError((Object _) {});
    return write;
  }
  void event(String action) {
    final events = List<dynamic>.from(profile['events'] ?? []);
    events.add({'time': DateTime.now().toIso8601String(), 'action': action});
    if (events.length > 100) events.removeRange(0, events.length - 100);
    profile['events'] = events;
  }
}
