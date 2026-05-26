import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../data/seedItems.dart';
import '../data/inventory.dart';
import '../theme.dart';

ValueNotifier <bool> isEnabled = ValueNotifier(false);
Item item = seedOfUtrica;


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
        duration: Duration(milliseconds: 150),
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
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: .w700,
                ),
              ),
              SizedBox(height: BASE_SPACING,),

              // ITEM VIEW

              Flexible(
                flex: 5,
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

              ...switch (item) {
                SeedItem s => [
                  paramWidget('Grow time :', s.species.getGrowTime().toString()),
                  SizedBox(height: BASE_SPACING / 2),
                  paramWidget('Stages :', (s.species.stages.length+1).toString()),
                ],
                _ => [
                  titledFieldWidget('Description :', item.description),
                ],
              },
              
              // BUTTONS
              SizedBox(height: BASE_SPACING/2),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    actionButton('Use', item.use, color: inventoryBgColor),
                    actionButton('Details', ()=>print(item.description), color: Color(0xFFB495BA), textStyle: TextStyle(fontWeight: .w400)),                  
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget titledFieldWidget(String title, String body){
    return Flexible(
      flex: 6,
      fit: .tight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TITLE
          Expanded(
            child:  ColoredBox(
              color: Colors.black.withAlpha(50),
              child: AutoSizeText(title, textAlign: .center,),
            )
          ),
          Flexible(
            fit: .tight,
            flex: 4,
            child: ColoredBox(
              color: Colors.black.withAlpha(20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Scrollable(
                  axisDirection: .down,
                  viewportBuilder: (context, position) => Text(body),
                ),
              ),
            ),
          ),
        ],
      )
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
              height: 45,
              //margin: .symmetric(vertical: 15),
              padding: .symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(30)
              ),
              child: Text(
                paramName,
                textAlign: .left,
                style: TextStyle(
                  color: Color(0xFF5D8D69),
                  fontWeight: .w600
              ),
              ),
            ),
          ),

          // PARAM VALUE
          Expanded(
            flex: 3,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: .circular(10),
              ),
              child: Text(
                value.toString(),
                textAlign: .center,
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget actionButton(String name, VoidCallback action,{Color color = Colors.white, TextStyle? textStyle}){
    return Expanded(
      flex: 1,
      child: Container(
        margin: .symmetric(horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: .circular(30),
          boxShadow: [BoxShadow(
            blurRadius: 0,
            offset: .fromDirection(1, 5),
            color: Colors.black.withAlpha(50)
          )]
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: .fromHeight(70),
            backgroundColor: color,
            textStyle: basicTextStyle,
            foregroundColor: Colors.white,
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Color.fromARGB(255, 90, 112, 28), width: 6, strokeAlign: BorderSide.strokeAlignInside),
            ),
          ),
          onPressed: action,
          child: Text(name, 
          textAlign: .center, 
          style: textStyle,
          ),
        ),
      )
    );
  }
}