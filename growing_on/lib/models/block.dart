//import 'plants';
import 'dart:math';
export 'dart:math';
class Plant{}

class Vector2 {
  late int x, y;
  Vector2(int x, int y)
  {
    this.x = x;
    this.y = y;
  }

  Vector2 operator + (Vector2 other) => Vector2(x + other.x, y + other.y);
}
class Vector2Double {
  late double x, y;
  Vector2Double(double x, double y)
  {
    this.x = x;
    this.y = y;
  }
}

class Block {
  final Vector2 pos;
  Plant? plant;

  Block({required this.pos, this.plant});
}