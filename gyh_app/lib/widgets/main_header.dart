import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/theme.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    super.key,
    required this.onMenuTap,
    required this.currency,
  });

  final VoidCallback onMenuTap;
  final List<Widget> currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Row(
        children: [
          Material(
            color: AppTheme.primary,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onMenuTap,
              customBorder: const CircleBorder(),
                child: SizedBox(
                width: 65,
                height: 65,
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SvgPicture.asset("assets/navigation/menu.svg"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currency,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
