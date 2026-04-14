import 'dart:async';

import 'package:flutter/material.dart';

import '../models/inventorySlot.dart';
export '../models/inventorySlot.dart';

Item seedOfSunflowerItem = Item(
  name: "Sunflower seed", 
  imagePath: 'assets/images/trinckets/seed.svg'
);
Item pickMeDiamond = Item(
  name: "Diamond", 
  imagePath: 'assets/images/trinckets/diamond.svg'
);

InventoryInstance instance = InventoryInstance(
  slots: 
    [
      InventorySlot(
        value: seedOfSunflowerItem,
        count: 1,
      ),
      InventorySlot(
        value: seedOfSunflowerItem,
        count: 2,
      ),
      InventorySlot(
        value: seedOfSunflowerItem,
        count: 11,
      ),
      InventorySlot(
        value: seedOfSunflowerItem,
        count: 99,
      ),
      InventorySlot(
        count: 0,
      ),
      InventorySlot(
        count: 0,
      ),
      InventorySlot(
        count: 0,
      ),
    ]
);

class InventoryInstance extends ChangeNotifier{
  List<InventorySlot> slots;
  InventoryInstance({required this.slots});

  void Add(Item item){
    InventorySlot? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref != null) {
      ref.count ++;
    }
    else {
      slots.add(InventorySlot(count: 1, value: item,));
    }

    notifyListeners();
  }
}

