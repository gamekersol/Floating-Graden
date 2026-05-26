import 'dart:async';
import 'dart:math';

import 'package:growing_on/theme.dart';

import '../data/inventory.dart' as inv;
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../constraints.dart';

var controller = InfiniteScrollController();
const int ITERATIONS = 3;

void wheelPanel(BuildContext context, List<Item> items){

  Random random = Random();
  // MULTIPLYING ITEMS FOR RARITY THINGS
  List<Item> rollItems = List.empty();
  for (int i = 0; i < ITERATIONS; i ++){
    for (var item in items){
    if (random.nextInt(RARITY_CHANSE[Rarity.common]!) < RARITY_CHANSE[item.rarity]!) rollItems.add(item);
    }
  }

  int randIndex = random.nextInt(rollItems.length);
  double itemWidth = 70;

  showDialog(
    fullscreenDialog: false,
    barrierColor: Colors.black.withAlpha(150),
    context: context,
    builder: (context) => 
    SafeArea(
      child: Stack(
        children: [
          InfiniteCarousel.builder(itemCount: rollItems.length
            , itemExtent: itemWidth
            , itemBuilder: (context, itemIndex, realIndex) => CarouselItemWidget(containedItem: rollItems[itemIndex]),
            axisDirection: Axis.horizontal,
            center: true,
            loop: true,
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
          ),
          // ARROW ON MIDDLE ITEM
          Center(
            child: SizedBox(
              height: 150,
              child: RotatedBox(
                quarterTurns: 1,
                child: Divider(
                  color: Colors.white,
                  thickness: 3,
                )
                ),
            ),
          )
        ]
      ),
    )
  );

  const Duration rollTime = Duration(milliseconds: 5000);

  //roll
  WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.animateToItem(
      rollItems.length * 30 + randIndex,
      duration: rollTime,
      curve: Curves.decelerate,
    );
  });

  inv.instance.add(rollItems[randIndex]);
  Timer(Duration(milliseconds: rollTime.inMilliseconds + 1200 ), ()=> Navigator.pop(context));
}

class CarouselItemWidget extends StatelessWidget {
  const CarouselItemWidget({super.key, required this.containedItem});
  
  final Item containedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: RARITY_COLOR[containedItem.rarity]! ,
      child: SvgPicture.asset(containedItem.imagePath, fit: BoxFit.contain,),
    );
  }
}