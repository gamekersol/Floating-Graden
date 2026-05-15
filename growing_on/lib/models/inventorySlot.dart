import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/theme.dart';

import 'item.dart';
export 'item.dart';

class InventorySlot extends StatelessWidget{
  //final Item item;
  final ValueNotifier <Item?> item = ValueNotifier(null);
  int count;

  InventorySlot ({super.key ,Item? value, this.count = 1}){
    item.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder (
      valueListenable: item,
      builder: (context, value, child) {
        return Stack(
          children: [
            // ITEM ICON
            if (item.value != null) Padding(
              padding: EdgeInsetsGeometry.all(0),
              child: Center(
                child: SvgPicture.asset(
                  item.value!.imagePath,
                  //fit: BoxFit.fill,
                ),
              )
            ),

            // COUNT IMAGE
            if (item.value != null && count > 1)Align(
              alignment: Alignment(1, 1),
              child: Container(
                height: 200/5.4,
                width: 200/5.4,
                decoration: BoxDecoration(
                  color: lightGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  //padding: EdgeInsetsGeometry.all(1),
                  child: Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                        color: Colors.black.withAlpha(135),
                        offset: Offset.fromDirection(1)*2,
                        )
                      ]
                    ),
                  ),
                ),
              ),
            ),
          ]
        );
      },
    );
  }
}
