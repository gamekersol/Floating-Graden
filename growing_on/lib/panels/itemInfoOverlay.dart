import 'dart:math';

import 'package:flutter/material.dart';
import '../models/item.dart';
import '../data/inventory.dart';
import '../theme.dart';

ValueNotifier <bool> isEnabled = ValueNotifier(false);
Item item = seedOfSunflowerItem;


class ItemInfoOverlay extends StatefulWidget {
  const ItemInfoOverlay({super.key});

  @override
  State<ItemInfoOverlay> createState() => _ItemInfoOverlayState();
}

class _ItemInfoOverlayState extends State<ItemInfoOverlay> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: isEnabled,
      builder: (context, child) => 
      AnimatedOpacity(
        opacity: isEnabled.value == false ? 0 : 1,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: IgnorePointer(
          ignoring: !isEnabled.value,
          child: dumbWidget(),
        ),
      )
    );
  }

  static const double BASE_SPACING = 15;

  Widget dumbWidget(){

    return SafeArea(
      child: GestureDetector(
        onTap: () => isEnabled.value = false,
        child: Container(
          margin: .fromLTRB(30, 80 , 30, 100),
          //padding: .all(20),
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: .all(.circular(50)),
            border: BoxBorder.all(color: darkGreen, width: 10),
          ),
          child: Column(
            children: [

              // ITEM NAME

              SizedBox(height: BASE_SPACING,),
              Text(
                item.name,
                textAlign: .center,
              ),
              SizedBox(height: BASE_SPACING,),

              // ITEM VIEW

              Expanded(
                flex: 4,
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [darkGreen,darkGreen.withAlpha(0)],
                      begin: .topCenter,
                      end: .bottomCenter,
                    )
                  ),
                  child: Padding(padding: .all(30), child: item.getImage(),),
                ),
              ),

              // PARAMS
              SizedBox(height: BASE_SPACING),
              paramWidget('Grow time :', item.imagePath),
              paramWidget('Grow time :', item.imagePath),
            ],
          ),
        ),
      ),
    );
  }

  Widget paramWidget(String paramName, Object value){
    return Expanded(
      flex: 1,
      child: Row(
        children:[ 
          // PARAM NAME
          Expanded(
            flex: 4,
            child: Container(
              height: 40,
              //margin: .symmetric(vertical: 0),
              padding: .symmetric(horizontal: 5, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(30)
              ),
              child: Text(
                paramName,
                textAlign: .left,
                style: TextStyle(
                  color: Color(0xFF5D8D69),
              ),
              ),
            ),
          ),

          // PARAM VALUE
          Expanded(
            flex: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: .circular(20),
              ),
              child: Text(
                value.toString(),
                textAlign: .center,
              ),
            ),
          ),
          SizedBox(height: BASE_SPACING,)
        ]
      ),
    );
  }
}