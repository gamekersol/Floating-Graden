import 'package:flutter/material.dart';
import 'models/item.dart';

const Size BLOCK_SIZE = Size(80, 50);
const Size BLOCK_COLLIDER_SIZE = Size(62, 30);
const double MIN_SCALE = 0.03, MAX_SCALE = 10;

const Map<Rarity, int> RARITY_CHANSE = {
  Rarity.theonlyone : 1,
  Rarity.forgoten : 3,
  Rarity.mythical : 10,
  Rarity.vanished : 30,
  Rarity.divided : 100,
  Rarity.veryrare : 300,
  Rarity.rare : 1000,
  Rarity.uncommon : 3000,
  Rarity.common : 10000
};