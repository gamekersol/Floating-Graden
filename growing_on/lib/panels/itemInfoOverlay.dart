import 'package:flutter/material.dart';
import '../models/item.dart';
import '../theme.dart';

ValueNotifier <bool> isEnabled = ValueNotifier(false);
late Item item;


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

  Widget dumbWidget(){
    return SafeArea(
      child: GestureDetector(
        onTap: () => isEnabled.value = false,
        child: Container(
          padding: .fromLTRB(30, 500, 30, 350),
          margin: .all(20),
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: .all(.circular(50)),
            border: BoxBorder.all(color: darkGreen, width: 10),
          ),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text(
                item.name,
                textAlign: .center,
                // style: TextStyle(
                  
                // ),
              ),
              SizedBox(height: 40,),

              // ITEM VIEW
              Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [darkGreen,darkGreen.withAlpha(0)]
                    //transform: GradientRotation(radians)
                  )
                ),
                child: Padding(padding: .all(30), child: item.getImage(),),
              ),

              // PARAMS
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}