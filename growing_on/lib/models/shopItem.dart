import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/currency.dart';
import '../data/inventory.dart' as inv;

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

var controller = InfiniteScrollController();

void _wheelPanel(BuildContext context){

  List<Item> items = [inv.seedOfSunflowerItem, inv.seedOfSunflowerItem, inv.pickMeDiamond];

  int randIndex = Random().nextInt(items.length);
  double itemWidth = 70;

  showDialog(
    fullscreenDialog: false,
    barrierColor: Colors.black.withAlpha(150),
    context: context,
    builder: (context) => 
    SafeArea(
      child: InfiniteCarousel.builder(itemCount: items.length
      , itemExtent: itemWidth
      , itemBuilder: (context, itemIndex, realIndex) => CarouselItemWidget(containedItem: items[itemIndex]),
      axisDirection: Axis.horizontal,
      center: true,
      loop: true,
      physics: NeverScrollableScrollPhysics(),
      controller: controller,
      ),
    )
  );

  //roll
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.animateToItem(
      100 + randIndex,
      duration: const Duration(milliseconds: 3000),
      curve: Curves.decelerate,
    );
  });

  inv.instance.Add(items[randIndex]);
}

class CarouselItemWidget extends StatelessWidget {
  const CarouselItemWidget({super.key, required this.containedItem});
  
  final Item containedItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SvgPicture.asset(containedItem.imagePath, fit: BoxFit.contain,),
    );
  }
}

void _None() => print('None action');