import 'item_definition.dart';

typedef UseCallback = void Function(InventoryItem item);

/// A player's instance of an item — holds current quantity and use logic.
/// The static data lives in [definition].
class InventoryItem {
  const InventoryItem({
    required this.definition,
    required this.quantity,
    required this.onUse,
  });

  final ItemDefinition definition;
  final int quantity;
  final UseCallback onUse;

  // Convenience getters so widgets don't have to drill into .definition
  String get id          => definition.id;
  String get name        => definition.name;
  String get iconPath    => definition.iconPath;
  int    get maxQuantity => definition.maxQuantity;
  String get description => definition.description;
  List<String> get tags  => definition.tags;

  // ignore: avoid_dynamic_calls
  get rarity             => definition.rarity;
}