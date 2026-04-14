import 'package:flutter/material.dart';
import 'package:growing_on/theme.dart';
import '../data/inventory.dart' as inv;

int maxCells = 7;

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          child: GridView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            children: List.generate(maxCells, (int i) => SlotWidget(slot: inv.instance.slots[i])),
          ),
        ),
      ),
    );
  }
}
class SlotWidget extends StatelessWidget {
  final inv.InventorySlot slot;

  const SlotWidget({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(34),
        color: inventorySlotColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(120),
            offset: Offset.fromDirection(1.6)*3,
            spreadRadius: 1.2,
            //blurRadius: 0.3,
          )
        ]
      ),
      //width: 30,
      //height: 30,
      child: slot,
    );
  }
}