import 'package:flutter/material.dart';
import 'package:growing_on/theme.dart';
import '../data/inventory.dart' as inv;
import '../panels/itemInfoOverlay.dart' as infoOverlay;

//int maxCells = 6;

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 17),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color:  inventoryBgColor,
              borderRadius: BorderRadius.circular(34),
              border: BoxBorder.all(
                color: inventoryOutlineColor,
                width: 8,
              )
            ),
      
            child: ListenableBuilder(
              listenable: inv.instance,
              builder: (_,_) => GridView(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                children: List.generate(inv.instance.slots.length, (int i) => CellWidget(content: inv.instance.slots[i])),
              ),
            ),
          ),
        ),
      ),
      infoOverlay.ItemInfoOverlay(),
      ]
    );
  }
}
class CellWidget extends StatelessWidget {
  final inv.CellContent content;

  const CellWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(34),
          border: .all(
            color: content.item.value != null ? RARITY_COLOR[content.item.value!.rarity]! : Colors.transparent,
            width: 5,
          ),
          color: inventorySlotColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(120),
              offset: Offset.fromDirection(1.6)*3,
              spreadRadius: 1.2,
            )
          ]
        ),

        // DUMB PART
        child: Stack(
          children: [
            // CELL CONTENT
            content,
            // ITEM COUNT
            if (content.item.value != null && content.count > 1) ItemCountWidget()
          ],
        ),
      ),
    );
  }

  Widget ItemCountWidget() =>
    Align(
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
            content.count.toString(),
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
    );

  void onTap(){
    print("slot tap");
    if (content.item.value == null) return;
    print('on item info panel');

    infoOverlay.item = content.item.value!; 
    infoOverlay.isEnabled.value = true;
  }
}