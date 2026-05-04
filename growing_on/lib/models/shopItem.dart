import 'package:flutter/material.dart';
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
  const PackItem({super.key, 
  required super.item,
  required super.cost,
  super.type = TypeOfCurrency.seeds,
  super.onBuy = wheelPanel,
  });
}

void _None() => print('None action');