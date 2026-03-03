import 'package:flutter/material.dart';

void main() {
  runApp(const GrowYourHabitsApp());
}

class GrowYourHabitsApp extends StatelessWidget {
  const GrowYourHabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grow your Habits',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xAA849E33),
          brightness: Brightness.light,
          primary: const Color(0xAA849E33),
          surface: const Color.fromARGB(255, 255, 255, 255),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8D2A1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xAA849E33),
          selectedItemColor: Color.fromARGB(170, 183, 191, 161),
          unselectedItemColor: Color.fromARGB(170, 146, 170, 73),
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    int _selectedIndex = 1; // Home selected by default

    static const List<NavItem> _navItems = [
      NavItem(icon: Icons.calendar_today_outlined, label: 'Calendar'),
      NavItem(icon: Icons.home_outlined, label: 'Home'),
      NavItem(icon: Icons.list_alt_outlined, label: 'List'),
      NavItem(icon: Icons.lock_outline, label: 'Lock'),
    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: Drawer(
          backgroundColor: const Color(0xFFF8D2A1),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xAA849E33)),
                child: Text(
                  'Grow your Habits',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    _buildPlaceholderScreen('Calendar', Icons.calendar_today),
                    _buildPlaceholderScreen('Home', Icons.home),
                    _buildPlaceholderScreen('List', Icons.list),
                    _buildPlaceholderScreen('Lock', Icons.lock),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      );
    }

    Widget _buildHeader() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Row(
          children: [
            // Circular menu button
            Material(
              color: const Color(0xAA849E33),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                customBorder: const CircleBorder(),
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Pill-shaped search bar
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xAA849E33),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 15,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildPlaceholderScreen(String title, IconData icon) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: const Color(0xAA849E33).withOpacity(0.5)),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildBottomNavBar() {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xAA849E33),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _navItems.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildNavItem(int index) { 
    final isSelected = _selectedIndex == index;
    final item = _navItems[index];

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(170, 205, 222, 151)
              : const Color.fromARGB(32, 255, 255, 255),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Icon(
          item.icon,
          size: 26,
          color: isSelected ? Colors.white : const Color(0xFFB8D4B8),
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}
