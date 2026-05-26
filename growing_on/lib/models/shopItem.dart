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

  const ShopItem({super.key,
   required this.item ,
   required this.cost, this.type = TypeOfCurrency.coins,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void onBuy() => print("no special buy action");
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
  void onBuy() {
    wheelPanel(main.navigatorKey.currentContext!, dropItems);
  }
}