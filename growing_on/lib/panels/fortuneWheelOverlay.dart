import 'dart:async';
import 'dart:math';

import '../data/inventory.dart' as inv;
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';

var controller = InfiniteScrollController();

void wheelPanel(BuildContext context){

  List<Item> items = [inv.seedOfUtrica, inv.seedOfUtrica, inv.pickMeDiamond];

  int randIndex = Random().nextInt(items.length);
  double itemWidth = 70;

  showDialog(
    fullscreenDialog: false,
    barrierColor: Colors.black.withAlpha(150),
    context: context,
    builder: (context) => 
    SafeArea(
      child: Stack(
        children: [
          InfiniteCarousel.builder(itemCount: items.length
            , itemExtent: itemWidth
            , itemBuilder: (context, itemIndex, realIndex) => CarouselItemWidget(containedItem: items[itemIndex]),
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
      100 + randIndex,
      duration: rollTime,
      curve: Curves.decelerate,
    );
  });

  inv.instance.Add(items[randIndex]);
  Timer(Duration(milliseconds: rollTime.inMilliseconds + 1200 ), ()=> Navigator.pop(context));
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