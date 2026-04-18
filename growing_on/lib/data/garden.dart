import '../models/block.dart';
export '../models/block.dart';

List<Block> blocks = [
  // Вусики
  Block(pos: Vector2(-3, -4)), Block(pos: Vector2(3, -4)),
  // Голова верх
  Block(pos: Vector2(-2, -3)), Block(pos: Vector2(2, -3)),
  // Основна лінія голови
  Block(pos: Vector2(-3, -2)), Block(pos: Vector2(-2, -2)), Block(pos: Vector2(-1, -2)), 
  Block(pos: Vector2(0, -2)), Block(pos: Vector2(1, -2)), Block(pos: Vector2(2, -2)), Block(pos: Vector2(3, -2)),
  // Очі (пропуски на -1 та 1)
  Block(pos: Vector2(-4, -1)), Block(pos: Vector2(-3, -1)), Block(pos: Vector2(-1, -1)), 
  Block(pos: Vector2(0, -1)), Block(pos: Vector2(1, -1)), Block(pos: Vector2(3, -1)), Block(pos: Vector2(4, -1)),
  // Тулуб (найширша частина)
  Block(pos: Vector2(-5, 0)), Block(pos: Vector2(-4, 0)), Block(pos: Vector2(-3, 0)), 
  Block(pos: Vector2(-2, 0)), Block(pos: Vector2(-1, 0)), Block(pos: Vector2(0, 0)), 
  Block(pos: Vector2(1, 0)), Block(pos: Vector2(2, 0)), Block(pos: Vector2(3, 0)), 
  Block(pos: Vector2(4, 0)), Block(pos: Vector2(5, 0)),
  // Нижня частина тулуба
  Block(pos: Vector2(-5, 1)), Block(pos: Vector2(-3, 1)), Block(pos: Vector2(-2, 1)), 
  Block(pos: Vector2(-1, 1)), Block(pos: Vector2(0, 1)), Block(pos: Vector2(1, 1)), 
  Block(pos: Vector2(2, 1)), Block(pos: Vector2(3, 1)), Block(pos: Vector2(5, 1)),
  // "Руки"
  Block(pos: Vector2(-5, 2)), Block(pos: Vector2(-3, 2)), Block(pos: Vector2(3, 2)), Block(pos: Vector2(5, 2)),
  // Ніжки
  Block(pos: Vector2(-2, 3)), Block(pos: Vector2(-1, 3)), Block(pos: Vector2(1, 3)), Block(pos: Vector2(2, 3)),
];