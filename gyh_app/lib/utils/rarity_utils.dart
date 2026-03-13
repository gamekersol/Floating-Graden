import 'package:flutter/material.dart';
import '../models/item_rarity.dart';

Color rarityColor(ItemRarity rarity) => switch (rarity) {
      ItemRarity.common    => const Color(0xFF9E9E9E),
      ItemRarity.rare      => const Color(0xFF2196F3),
      ItemRarity.epic      => const Color(0xFF9C27B0),
      ItemRarity.legendary => const Color(0xFFFF9800),
    };

String rarityLabel(ItemRarity rarity) => switch (rarity) {
      ItemRarity.common    => 'Common',
      ItemRarity.rare      => 'Rare',
      ItemRarity.epic      => 'Epic',
      ItemRarity.legendary => 'Legendary',
    };