import 'item_rarity.dart';

/// Static blueprint that describes what an item *is*.
/// One definition exists per item type — shared across all instances.
class ItemDefinition {
  const ItemDefinition({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.maxQuantity,
    required this.rarity,
    required this.tags,
    this.description = '',
  });

  final String id;
  final String name;
  final String iconPath;
  final int maxQuantity;
  final ItemRarity rarity;
  final List<String> tags;
  final String description;
}
