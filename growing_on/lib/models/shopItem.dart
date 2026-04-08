import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/theme.dart';
import '../data/currency.dart';

import 'item.dart';
export 'item.dart';

class ShopItem extends StatelessWidget {
  final Item item;
  //final int coount;
  final int cost;
  final TypeOfCurrency type;

  const ShopItem({super.key, required this.item , required this.cost, this.type = TypeOfCurrency.coins});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}