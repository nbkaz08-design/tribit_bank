import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriBit Bank Portal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        fontFamily: 'Roboto', // Или любой другой стандартный шрифт
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// Перечисление для управления текущим экраном системы
enum ActiveTab { auth, overview, clients }

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  ActiveTab _currentTab = ActiveTab.auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Боковая панель отображается всегда
          //44 zagluska
          _currentTab == ActiveTab.auth? Container(): SideInfo(
            currentTab: _currentTab,
            onTabChanged: (tab) {
              setState(() {
                _currentTab = tab;
              });
            },
          ),
          // Правая динамическая часть контента
          Expanded(flex: 5, child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentTab) {
      case ActiveTab.auth:
        return MainAuth(
          onTabChanged: (tab) {
              setState(() {
                _currentTab = tab;
              });
            }
        );
      case ActiveTab.overview:
        return const OverviewScreen();
      case ActiveTab.clients:
        return const ClientsScreen();
    }
  }
}

// --- БОКОВАЯ ПАНЕЛЬ (SIDEBAR) ---
class SideInfo extends StatelessWidget {
  final ActiveTab currentTab;
  final ValueChanged<ActiveTab> onTabChanged;

  const SideInfo({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: const Color(0xFF0A1429),
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Логотип компании
          Image.asset("images/Logo-Mark.png"),
          const SizedBox(height: 40.0),

          // Меню навигации
          _buildMenuItem(Icons.grid_view_rounded, 'Обзор', ActiveTab.overview),
          _buildMenuItem(
            Icons.people_alt_outlined,
            'Клиенты',
            ActiveTab.clients,
          ),
          _buildMenuItem(Icons.credit_card_rounded, 'Счета и карты', null),
          _buildMenuItem(Icons.assignment_outlined, 'Кредитные заявки', null),
          _buildMenuItem(Icons.swap_horiz_rounded, 'Платежи по кредитам', null),
          _buildMenuItem(
            Icons.history_toggle_off_rounded,
            'Журнал действий',
            null,
          ),
          _buildMenuItem(Icons.settings_outlined, 'Настройки', null),

          const Spacer(),

          // Профиль пользователя внизу
          Row(
            children: [
              const CircleAvatar(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Старший андеррайтер',
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    ),
                  ],
                ),
              ),
              IconButton(
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

  Widget _buildMenuItem(IconData icon, String title, ActiveTab? tab) {
    final bool isSelected = tab != null && currentTab == tab;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        dense: true,
        selected: isSelected,
        selectedTileColor: Colors.blue.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey[500],
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? Container(width: 4, height: 16, color: Colors.blue)
            : null,
        onTap: tab != null ? () => onTabChanged(tab) : null,
      ),
    );
  }
}

// --- ЭКРАН 1: АВТОРblocksИЗАЦИЯ ---
class MainAuth extends StatelessWidget {
    final ValueChanged<ActiveTab> onTabChanged;
    const MainAuth({super.key, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Row(
        children: [
          // Левая информационная часть
          Expanded(
            flex: 4,
            child: Container(
              color: const Color(0xFF060D1A),
              padding: const EdgeInsets.all(60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("images/Logo-Mark.png"),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('TriBit Bank', style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                                            )),
                      )
                    ],
                  ),
                  Spacer(flex: 3),
                  Text(
                    'Внутренний\nзащищенный портал',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Доступ к операционной системе TriBit Bank разрешен только авторизованным сотрудникам бэк-офиса и филиальной сети.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 14.0,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 60.0),
                  _SecurityFeatureRow(
                    text: 'Шифрование канала по стандарту ГОСТ',
                  ),
                  _SecurityFeatureRow(text: 'Обязательная 2FA авторизация'),
                  _SecurityFeatureRow(
                    text: 'Автоматическое логирование сессий',
                  ),
                ],
              ),
            ),
          ),
          // Правая часть с формой входа
          Expanded(
            flex: 5,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Авторизация сотрудника',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Введите учетные данные для доступа в систему',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    const AuthForm(),
                    const SizedBox(height: 24.0),
                    const TwoFactorAuthWidget(),
                    const SizedBox(height: 24.0),
                    //const Warning2FA(),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        minimumSize: const Size.fromHeight(52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        onTabChanged(ActiveTab.overview);
                      },
                      child: const Text(
                        'Подтвердить и войти',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityFeatureRow extends StatelessWidget {
  final String text;
  const _SecurityFeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.shield_outlined, color: Colors.blue, size: 18),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Корпоративный ID / E-mail',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: TextEditingController(text: 'k.vorobiev@tribit.ru'),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Пароль',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: true,
          controller: TextEditingController(text: '••••••••••••••'),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}

class TwoFactorAuthWidget extends StatelessWidget {
  const TwoFactorAuthWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Второй фактор защиты (2FA)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E40AF),
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Введите 6-значный одноразовый пароль из корпоративного приложения Authenticator',
            style: TextStyle(color: Color(0xFF1E40AF), fontSize: 12),
          ),
          SizedBox(height: 16),
          DigitBoxes(),
        ],
      ),
    );
  }
}

class DigitBoxes extends StatelessWidget {
  const DigitBoxes({super.key});
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DigitBox(digit: '4'),
        DigitBox(digit: '8'),
        DigitBox(digit: '2'),
        DigitBox(digit: '9'),
        DigitBox(digit: '1'),
        DigitBox(digit: '0'),
      ],
    );
  }
}

class DigitBox extends StatelessWidget {
  final String digit;
  const DigitBox({super.key, required this.digit});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: CenterAlignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.5, color: const Color(0xFFCBD5E1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        digit,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }
}

// --- ЭКРАН 2: ОБЗОР ПОКАЗАТЕЛЕЙ (ДАШБОРД) ---
class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Обзор показателей',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Ряд верхних аналитических карточек
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
                  sub: 'Требуется созвон soft-collection',
                  isWarning: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // График и быстрые действия
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Обработка кредитных заявок за неделю',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          BarChartGroup(label: 'Пн', val1: 60, val2: 30),
                          BarChartGroup(label: 'Вт', val1: 90, val2: 20),
                          BarChartGroup(label: 'Ср', val1: 80, val2: 45),
                          BarChartGroup(label: 'Чт', val1: 110, val2: 25),
                          BarChartGroup(label: 'Пт', val1: 95, val2: 15),
                          BarChartGroup(label: 'Сб', val1: 40, val2: 10),
                          BarChartGroup(label: 'Вс', val1: 70, val2: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Быстрые действия',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildQuickAction(
                        Icons.person_add_alt,
                        'Регистрация нового клиента',
                      ),
                      _buildQuickAction(
                        Icons.note_add_outlined,
                        'Создать заявку на кредит',
                      ),
                      _buildQuickAction(
                        Icons.block_flipped,
                        'Блокировка карты СБ',
                        isCritical: true,
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

  Widget _buildQuickAction(
    IconData icon,
    String text, {
    bool isCritical = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(
            color: isCritical ? Colors.red.shade200 : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        icon: Icon(
          icon,
          size: 18,
          color: isCritical ? Colors.red : Colors.blue,
        ),
        label: Text(
          text,
          style: TextStyle(
            color: isCritical ? Colors.red : Colors.black87,
            fontSize: 13,
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value, sub;
  final bool isAccent, isWarning;
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isAccent
            ? Border.all(color: Colors.blue, width: 1.5)
            : isWarning
            ? Border.all(color: Colors.red, width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            sub,
            style: TextStyle(
              color: isAccent
                  ? Colors.green
                  : isWarning
                  ? Colors.red
                  : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class BarChartGroup extends StatelessWidget {
  final String label;
  final double val1, val2;
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
            Container(width: 12, height: val1, color: const Color(0xFF10B981)),
            const SizedBox(width: 4),
            Container(width: 12, height: val2, color: const Color(0xFFEF4444)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

// --- ЭКРАН 3: БАЗА КЛИЕНТОВ ---
class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'База клиентов',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Фильтры поиска
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Параметры поиска клиентов',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterField('ФИО Клиента', 'Васильева'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFilterField(
                        'Номер телефона',
                        '+7 (999) •••-••-••',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildFilterField(
                        'ID / Паспорт',
                        'Введите серию и номер',
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(120, 46),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Найти',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Таблица результатов
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Найдено: 3 совпадения',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: const [
                        _ClientRow(
                          id: '#842910',
                          name: 'Васильева Елена Сергеевна',
                          phone: '+7 (999) •••-45-21',
                          products: '1 Карта, 1 Депозит',
                          balance: '₽ 248 560',
                          status: 'PRO-статус',
                          isPro: true,
                        ),
                        _ClientRow(
                          id: '#842911',
                          name: 'Васильева Анна Игоревна',
                          phone: '+7 (921) •••-12-88',
                          products: '2 Карты, 1 Кредит',
                          balance: '₽ 1 042 100',
                          status: 'Обычный',
                          isPro: false,
                        ),
                        _ClientRow(
                          id: '#842912',
                          name: 'Васильева Галина Петровна',
                          phone: '+7 (905) •••-74-12',
                          products: '1 Счёт',
                          balance: '₽ 12 400',
                          status: 'Обычный',
                          isPro: false,
                        ),
                      ],
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

  Widget _buildFilterField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
    );
  }
}

class _ClientRow extends StatelessWidget {
  final String id, name, phone, products, balance, status;
  final bool isPro;
  const _ClientRow({
    required this.id,
    required this.name,
    required this.phone,
    required this.products,
    required this.balance,
    required this.status,
    required this.isPro,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        children: [
          Text(id, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 24),
          const CircleAvatar(radius: 14, backgroundColor: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(phone, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(products, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              balance,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isPro ? Colors.blue.shade50 : Colors.green.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isPro ? Colors.blue : Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- ВСПОМОГАТЕЛЬНЫЙ ЦЕНТРИРУЮЩИЙ КЛАСС ---
class CenterAlignment {
  static const Alignment center = Alignment.center;
}
