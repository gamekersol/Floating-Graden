import 'package:flutter/material.dart';
import '../data/currency.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

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
  super.onBuy = _wheelPanel,
  });
}

void _wheelPanel(BuildContext context){

  var controller = InfiniteScrollController();

  showDialog(
    fullscreenDialog: false,
    barrierColor: Colors.black.withAlpha(150),
    context: context,
    builder: (context) => 
    SafeArea(
      child: 
    )
  );
}

void _None() => print('None action');