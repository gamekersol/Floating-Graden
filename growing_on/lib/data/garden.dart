import '../models/block.dart';
export '../models/block.dart';

List<Block> blocks = [
  // Вусики
  Block(pos: Point(-3, -4)), Block(pos: Point(3, -4)),
  // Голова верх
  Block(pos: Point(-2, -3)), Block(pos: Point(2, -3)),
  // Основна лінія голови
  Block(pos: Point(-3, -2)), Block(pos: Point(-2, -2)), Block(pos: Point(-1, -2)), 
  Block(pos: Point(0, -2)), Block(pos: Point(1, -2)), Block(pos: Point(2, -2)), Block(pos: Point(3, -2)),
  // Очі (пропуски на -1 та 1)
  Block(pos: Point(-4, -1)), Block(pos: Point(-3, -1)), Block(pos: Point(-1, -1)), 
  Block(pos: Point(0, -1)), Block(pos: Point(1, -1)), Block(pos: Point(3, -1)), Block(pos: Point(4, -1)),
  // Тулуб (найширша частина)
  Block(pos: Point(-5, 0)), Block(pos: Point(-4, 0)), Block(pos: Point(-3, 0)), 
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