import 'plant.dart';
import 'dart:math';
import '../data/growService.dart';
export 'dart:math';
export 'plant.dart';

class Vector2Double {
  late double x, y;
  Vector2Double(this.x, this.y);
}

class Block {
  final Point<int> pos;
  Plant? plant;

  Block({required this.pos, this.plant}){
    if (plant!=null) startGrowth(this);
  }

  SetPlant(Plant plant){
    this.plant = plant;
    startGrowth(this);
  }
}