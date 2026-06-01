import 'package:flutter/material.dart';
import 'package:growing_on/data/garden.dart';

import '../models/inventorySlot.dart';
export '../models/inventorySlot.dart';

InventoryInstance instance = InventoryInstance(
  slots: 
    [
      InventorySlot(),
      InventorySlot(),
      InventorySlot(),
      InventorySlot(),
      InventorySlot(),
      InventorySlot(),
    ]
);

class InventoryInstance extends ChangeNotifier{
  List<InventorySlot> slots;
  InventoryInstance({required this.slots});

  void add(Item item, {int count = 1}){
    InventorySlot? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref != null) {
      ref.count += count;
      notifyListeners();
    }
    else {
      //slots.add(InventorySlot(count: count, value: item,));
      ref = slots.where((e) => e.item.value == null).firstOrNull;

      ref?.item.value = item;
    }

    
  }

  bool removeSeed(Species spec, int count){
      InventorySlot? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;

      if (ref == null || ref.count < count) return false;
      ref.count -= count;
      if (ref.count == 0) {
        ref.item.value = null;
        // HOT FIX TO PREVENT ADDING NEW ITEM BUG
        ref.count = 1;
      }
      notifyListeners();
      return true;
  }
  bool remove(Item item, int count){
    InventorySlot? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref == null || ref.count < count) return false;
    ref.count -= count;
    if (ref.count == 0) {
      ref.item.value = null;
      // HOT FIX TO PREVENT ADDING NEW ITEM BUG
      ref.count = 1;
    }
    notifyListeners();
    return true;

  }

  int getSeedCount(Species spec){
    InventorySlot? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;
    return ref?.count ?? 0;
  }
}

