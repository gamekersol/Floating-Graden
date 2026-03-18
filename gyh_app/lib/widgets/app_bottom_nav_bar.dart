import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../app/theme.dart';
import '../models/nav_item.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.navItems,
    required this.selectedIndex,
    required this.onTap,
  });

  final List<NavItem> navItems;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.primary,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navItems.length,
              (index) => _NavItem(
                item: navItems[index],
                isSelected: selectedIndex == index,
                onTap: () => onTap(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        width: 90,
        height: 90,
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(15),
        //margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.navSelectedIcon : AppTheme.navUnselectedIcon,
          borderRadius: BorderRadius.circular(35),
        ),
        child: SvgPicture.asset(
          item.icon,
          width: item.size,
          height: item.size,
          fit : BoxFit.contain
          ),
      ),
    );
  }
}
