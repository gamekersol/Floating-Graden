//import 'plants';
import 'dart:math';
export 'dart:math';
class Plant{}

class Vector2Double {
  late double x, y;
  Vector2Double(double x, double y)
  {
    this.x = x;
    this.y = y;
  }
}

class Block {
  final Point pos;
  Plant? plant;

  Block({required this.pos, this.plant});
}