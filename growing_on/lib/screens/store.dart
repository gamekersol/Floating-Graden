import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/data/store.dart';
import 'package:growing_on/theme.dart';
import '../data/currency.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      Padding(
        //padding: const EdgeInsets.fromLTRB(top: 90, horizontal: 17),
        padding: const EdgeInsets.fromLTRB(17,90,17,65),
        child: ListView.builder(
          itemCount:  shopItems.length,
          itemBuilder: (context,int i) => ItemWidget(item: shopItems[i],context: context,)
        ),
      )
    );
  }
}

class ItemWidget extends StatelessWidget {
  final ShopItem item;
  final BuildContext context;
  const ItemWidget({super.key, required this.item, required this.context});

  void Buy(){
    print("I BOUGHT SOME THING");
    currencys.change(item.type, -item.cost);
    item.onBuy();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(17),
      height: 270,
      decoration: BoxDecoration(
        color:  darkGreen,
        borderRadius: BorderRadius.circular(34),
        border: BoxBorder.all(
          color: inventoryOutlineColor,
          width: 8,
        )
      ),
      child: Row(
        spacing: 17,
        children: [
          // PLACEHOLDER FOR IMAGE
          Container(
            width:  140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: lightGreen,
            ),
            child: Padding(
              padding: .all(15),
              child: SvgPicture.asset(
                item.item.imagePath,
                //fit: BoxFit.contain,
                ),
            ),
          ),
          
          // NAME, DESC, RARITY
          Expanded(
            child: Column(
              spacing: 16,
              children: [
                // NAME
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightGreen,
                  ),
                  child: Center(
                    child: Text(
                      item.item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                          color: Colors.black.withAlpha(70),
                          offset: Offset.fromDirection(1)*2,
                          )
                        ]
                      ),
                    ),
                  ),
                ),
                      
                // DESC
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: shopDescriptionColor,
                    ),
                    child: Center(
                      child: Text(
                        item.item.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                            color: Colors.black.withAlpha(70),
                            offset: Offset.fromDirection(1)*2,
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                ),
                      
                // RARITY, BUY
                SizedBox(
                  height: 35,
                  child: Row(
                    spacing: 4,
                    children: [
                      
                      // RARITY
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: rarityColor,
                          ),
                          child: Center(
                            child: Text(
                              "Rarity?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                  color: Colors.black.withAlpha(70),
                                  offset: Offset.fromDirection(1)*2,
                                  )
                                ]
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // BUY BUTTON
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Buy(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: byuyItemColor, // Колір фону
                            foregroundColor: Colors.white,   // Колір тексту/іконок
                            elevation: 0,                   // Якщо не потрібна стандартна тінь кнопки
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Радіус
                            ),
                            padding: EdgeInsets.zero, // Щоб Center всередині працював коректно
                          ),
                          child: Row(
                            spacing: 6,
                            mainAxisAlignment: .center,
                            children: 
                            [
                              Text(
                                '${item.cost}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withAlpha(70),
                                      offset: Offset.fromDirection(1) * 2,
                                    )
                                  ],
                                ),
                              ),
                              currencys.values[item.type]!.getImage(),
                            ]
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}