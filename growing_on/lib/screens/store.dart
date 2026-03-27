import 'package:flutter/material.dart';
import 'package:growing_on/data/store.dart';
import 'package:growing_on/theme.dart';


class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 17),
        child: Column(
              
          children: List.generate(shopItems.length, (int i) => ItemWidget(item: shopItems[i])),
        )
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final ShopItem item;
  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color:  inventoryBgColor,
        borderRadius: BorderRadius.circular(34),
        border: BoxBorder.all(
          color: inventoryOutlineColor,
          width: 8,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 20,
          children: [
            // PLACEHOLDER FOR IMAGE
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: lightGreen,
              ),
            ),
            
            // NAME, DESC, RARITY
            Column(
              spacing: 8,
              children: [
                // NAME
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightGreen,
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
                  height: 60,
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
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: byuyItemColor,
                          ),
                          child: Center(
                            child: Text(
                              "Buy",
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
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}