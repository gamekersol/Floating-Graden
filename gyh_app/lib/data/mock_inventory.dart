import 'package:flutter/foundation.dart';

import '../models/inventory_item.dart';
//import '../models/item_definition.dart';
import 'item_definitions.dart';

/// Mock player inventory — only specifies *how many* the player has
/// and what happens on use. All other data comes from [ItemDefs].
final List<InventoryItem> mockInventoryItems = [
  InventoryItem(
    definition: ItemDefs.magicSeed,
    quantity: 12,
    onUse: (item) => debugPrint('Used ${item.name}'),
  ),
  InventoryItem(
    definition: ItemDefs.goldCoin,
    quantity: 340,
    onUse: (item) => debugPrint('Used ${item.name}'),
  ),
  InventoryItem(
    definition: ItemDefs.diamond,
    quantity: 3,
    onUse: (item) => debugPrint('Used ${item.name}'),
  ),
];