import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/nav_item.dart';
import '../models/currency_item.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/main_header.dart';
import '../widgets/placeholder_screen.dart';
import 'inventory_screen.dart';
import 'garden_screen.dart';

const List<CurrencyItem> _currencies = [
  CurrencyItem(iconPath: 'assets/trinckets/coin.svg', value: 10),
  CurrencyItem(iconPath: 'assets/trinckets/seed.svg', value: 5),
  CurrencyItem(iconPath: 'assets/trinckets/diamond.svg', value: 2),
];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;
  late final PageController _pageController;



  static final List<NavItem> _navItems = [
    NavItem(
      icon: SvgPicture.asset('assets/navigation/bag.svg', width: 100, height: 100),
      label: 'Calendar',
    ),
    NavItem(
      icon: SvgPicture.asset('assets/navigation/home.svg', width: 100, height: 100),
      label: 'Home',
    ),
    NavItem(
      icon: SvgPicture.asset('assets/navigation/tasks.svg', width: 100, height: 100),
      label: 'List',
    ),
    NavItem(
      icon: SvgPicture.asset('assets/navigation/store.svg', width: 100, height: 100),
      label: 'Lock',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            MainHeader(
              onMenuTap: () => Scaffold.of(context).openDrawer(),
              currency: _currencies
                  .map((c) => c.buildWidget(textColor: Colors.white))
                  .toList(),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  InventoryScreen(),
                  const GardenScreen(),
                  PlaceholderScreen(
                    title: 'List',
                    icon: SvgPicture.asset('assets/navigation/tasks.svg'),
                  ),
                  PlaceholderScreen(
                    title: 'Lock',
                    icon: SvgPicture.asset('assets/navigation/store.svg'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        navItems: _navItems,
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}