import '../models/item_definition.dart';
import '../models/item_rarity.dart';

/// Master catalogue — one entry per item type.
/// Add new item types here; never duplicate fields in mock data.
class ItemDefs {
  ItemDefs._();

  static const magicSeed = ItemDefinition(
    id: 'magic_seed',
    name: 'Magic Seed',
    iconPath: 'assets/trinckets/seed.svg',
    maxQuantity: 99,
    rarity: ItemRarity.common,
    tags: ['consumable', 'garden', 'growth'],
    description: 'A glowing seed full of potential.',
  );

  static const goldCoin = ItemDefinition(
    id: 'gold_coin',
    name: 'Gold Coin',
    iconPath: 'assets/trinckets/coin.svg',
    maxQuantity: 9999,
    rarity: ItemRarity.common,
    tags: ['currency', 'trade'],
    description: 'Currency of the realm.',
  );

  static const diamond = ItemDefinition(
    id: 'diamond',
    name: 'Diamond',
    iconPath: 'assets/trinckets/diamond.svg',
    maxQuantity: 10,
    rarity: ItemRarity.epic,
    tags: ['currency', 'rare', 'trade'],
    description: 'Extremely rare and valuable.',
  );

  // Add more definitions here as the game grows ↓
}
