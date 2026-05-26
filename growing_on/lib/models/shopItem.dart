import 'package:flutter/material.dart';
import '../main.dart' as main;
import '../data/currency.dart';
import '../panels/fortuneWheelOverlay.dart';

import 'item.dart';
export 'item.dart';

class ShopItem extends StatelessWidget {
  final Item item;
  //final int coount;
  final int cost;
  final TypeOfCurrency type;
  final Function onBuy;

  const ShopItem({super.key,
   required this.item ,
   required this.cost, this.type = TypeOfCurrency.coins,
   this.onBuy = _None,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PackItem extends ShopItem{
  final List<Item> dropItems;


  const PackItem({super.key, 
  required super.item,
  required super.cost,
  required this.dropItems,
  super.type = TypeOfCurrency.seeds,
  });

  @override
  Function get onBuy => super.onBuy == _None ? _openWheelPanel : super.onBuy;

  void _openWheelPanel() => wheelPanel(main.navigatorKey.currentContext!, dropItems);
}

void _None() => print('None action');