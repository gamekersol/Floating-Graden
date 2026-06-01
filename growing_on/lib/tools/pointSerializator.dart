import 'dart:math';

Map<String, dynamic> pointToJson(Point<int> p) => {'x': p.x, 'y': p.y};
Point<int> pointFromJson(Map<String, dynamic> json) => Point<int>(json['x'], json['y']);