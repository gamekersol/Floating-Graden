import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gyh_app/app/theme.dart';

class CurrencyItem {
  const CurrencyItem({
    required this.iconPath,
    required this.value,
  });

  final String iconPath;
  final int value;

  Widget buildWidget({
    double iconSize = 28,
    Color textColor = Colors.white,
    Color? backgroundColor,
  }) {
    return Container(
      width: 86,
      height: 35,
      //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      //margin: EdgeInsets.symmetric(horizontal: 1,vertical: 20),
      decoration: BoxDecoration(
        color: AppTheme.primaryLighter,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(

        mainAxisSize: MainAxisSize.max,
        children: [
          //const SizedBox(width: 10,),
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: SvgPicture.asset(iconPath),
          ),
          const SizedBox(width: 4),
          Align(alignment: Alignment.topCenter,child: Text(
              textAlign: TextAlign.center,
              '$value',
              style: TextStyle(
                color: textColor,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
