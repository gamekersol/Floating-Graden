import 'package:flutter/material.dart';
import 'models/item.dart';

const Size BLOCK_SIZE = Size(80, 50);
const double PLANT_SIZE_BASIC = 150;
const Size BLOCK_COLLIDER_SIZE = Size(62, 30);
const double MIN_SCALE = 0.03, MAX_SCALE = 10;

const Map<Rarity, int> RARITY_CHANSE = {
  Rarity.theonlyone : 1,
  Rarity.forgoten : 2,
  Rarity.mythical : 4,
  Rarity.vanished : 8,
  Rarity.divided : 16,
  Rarity.veryrare : 32,
  Rarity.rare : 64,
  Rarity.uncommon : 128,
  Rarity.common : 256
};