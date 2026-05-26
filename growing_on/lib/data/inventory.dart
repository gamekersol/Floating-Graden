import 'package:flutter/material.dart';
import 'package:growing_on/data/garden.dart';
import '../data/species.dart' as species;

import '../models/inventorySlot.dart';
export '../models/inventorySlot.dart';

Item seedOfUtrica = SeedItem(
  name: "Seed of something spiky", 
  imagePath: 'assets/images/trinckets/seed.svg',
  description: 'thouse are spiky and somethimes beneficial ,not only in ordinary way',
  species: species.utrica_dioica,
);
Item pickMeDiamond = Item(
  name: "Diamond", 
  imagePath: 'assets/images/trinckets/diamond.svg'
);

InventoryInstance instance = InventoryInstance(
  slots: 
    [
      InventorySlot(
        value: seedOfUtrica,
        count: 1,
      ),
      InventorySlot(
        value: seedOfUtrica,
        count: 2,
      ),
      InventorySlot(
        value: seedOfUtrica,
        count: 11,
      ),
      InventorySlot(
        value: seedOfUtrica,
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

  void add(Item item, {int count = 1}){
    InventorySlot? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref != null) {
      ref.count += count;
    }
    else {
      slots.add(InventorySlot(count: count, value: item,));
    }

    notifyListeners();
  }

  bool removeSeed(Species spec, int count){
      InventorySlot? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;

      if (ref == null || ref.count < count) return false;
      ref.count -= count;
      if (ref.count == 0) ref.item.value = null;
      notifyListeners();
      return true;
  }
  bool remove(Item item, int count){
    InventorySlot? ref = slots.where((e) => e.item.value?.name == item.name).firstOrNull;

    if (ref == null || ref.count < count) return false;
    ref.count -= count;
    if (ref.count == 0) ref.item.value = null;
    notifyListeners();
    return true;

    // TODO make if count ==0 remove;
  }

  int getSeedCount(Species spec){
    InventorySlot? ref = slots.where((e) => e.item.value is SeedItem && (e.item.value as SeedItem).species == spec).firstOrNull;
    return ref?.count ?? 0;
  }
}

