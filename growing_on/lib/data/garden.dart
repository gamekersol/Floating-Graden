import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../models/block.dart';
import 'species.dart' as species;
export '../models/block.dart';

ValueNotifier <int> blockNotifier = ValueNotifier(0);

List<Block> blocks = [
  // Вусики
  Block(pos: Point(-3, -4), plant: Plant(species: species.cogongrass)), Block(pos: Point(3, -4)),
  // Голова верх
  Block(pos: Point(-2, -3)), Block(pos: Point(2, -3)),
  // Основна лінія голови
  Block(pos: Point(-3, -2)), Block(pos: Point(-2, -2)), Block(pos: Point(-1, -2)), 
  Block(pos: Point(0, -2)), Block(pos: Point(1, -2)), Block(pos: Point(2, -2)), Block(pos: Point(3, -2)),
  // Очі (пропуски на -1 та 1)
  Block(pos: Point(-4, -1)), Block(pos: Point(-3, -1)), Block(pos: Point(-1, -1)), 
  Block(pos: Point(0, -1)), Block(pos: Point(1, -1)), Block(pos: Point(3, -1)), Block(pos: Point(4, -1)),
  // Тулуб (найширша частина)
  Block(pos: Point(-5, 0), plant: Plant(species: species.utrica_dioica)), Block(pos: Point(-4, 0)), Block(pos: Point(-3, 0)), 
  Block(pos: Point(-2, 0)), Block(pos: Point(-1, 0)), Block(pos: Point(0, 0)), 
  Block(pos: Point(1, 0)), Block(pos: Point(2, 0)), Block(pos: Point(3, 0)), 
  Block(pos: Point(4, 0)), Block(pos: Point(5, 0)),
  // Нижня частина тулуба
  Block(pos: Point(-5, 1)), Block(pos: Point(-3, 1)), Block(pos: Point(-2, 1)), 
  Block(pos: Point(-1, 1)), Block(pos: Point(0, 1)), Block(pos: Point(1, 1)), 
  Block(pos: Point(2, 1)), Block(pos: Point(3, 1)), Block(pos: Point(5, 1)),
  // "Руки"
  Block(pos: Point(-5, 2)), Block(pos: Point(-3, 2)), Block(pos: Point(3, 2)), Block(pos: Point(5, 2)),
  // Ніжки
  Block(pos: Point(-2, 3)), Block(pos: Point(-1, 3)), Block(pos: Point(1, 3)), Block(pos: Point(2, 3)),
];

PlantOnBlock(Point pos, Species spec){
  print("Trying to plant on $pos");

  var block = GetBlockByPos(pos);
  if (block == null || block.plant != null) return null;

  block.SetPlant(Plant(species: spec));
  print("Planted ${spec.name}");
  blockNotifier.value++;
}

Block? GetBlockByPos(Point pos) => 
blocks.firstWhereOrNull((block) => block.pos == pos);