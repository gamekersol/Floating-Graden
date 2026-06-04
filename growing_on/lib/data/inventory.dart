import 'package:flutter/material.dart';
import 'package:growing_on/models/species.dart';
import '../constraints.dart';

import '../tools/jsonStorage.dart';
import '../models/cellContent.dart';
export '../models/cellContent.dart';

InventoryInstance instance = InventoryInstance();

void initData(List<Map<String, dynamic>> data) {
  if (data.length == 0)
  {
    instance.slots = List.generate(START_INVENTORY_SIZE, (_) => CellContent());
    return;
  }
  instance.slots = data.map((s) => CellContent.fromJson(s)).toList();
  
}

class InventoryInstance extends ChangeNotifier{
  late List<CellContent> slots;

  void add(Item item, {int count = 1}){
    CellContent? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref != null) {
      ref.count += count;
      notifyListeners();
    }
    else {
      //slots.add(InventorySlot(count: count, value: item,));
      ref = slots.where((e) => e.item.value == null).firstOrNull;

      ref?.item.value = item;
    }
    save();
  }

  bool removeSeed(Species spec, int count){
      CellContent? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;

      if (ref == null || ref.count < count) return false;
      ref.count -= count;
      if (ref.count == 0) {
        ref.item.value = null;
        // HOT FIX TO PREVENT ADDING NEW ITEM BUG
        ref.count = 1;
      }
      notifyListeners();
      save();
      return true;
  }
  bool remove(Item item, int count){
    CellContent? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref == null || ref.count < count) return false;
    ref.count -= count;
    if (ref.count == 0) {
      ref.item.value = null;
      // HOT FIX TO PREVENT ADDING NEW ITEM BUG
      ref.count = 1;
    }
    notifyListeners();
    save();
    return true;
  }

  int getSeedCount(Species spec){
    CellContent? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;
    return ref?.count ?? 0;
  }

  void save() => JsonStorage.save('inventory', instance.slots.map((s) => s.toJson()).toList());
}

