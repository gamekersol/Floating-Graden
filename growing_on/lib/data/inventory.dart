import '../models/inventorySlot.dart';
export '../models/inventorySlot.dart';

Item seedOfSunflowerItem = Item(
  name: "Sunflower seed", 
  imagePath: 'assets/images/trinckets/seed.svg'
);
List<InventorySlot> slots = [
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
];
