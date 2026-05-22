import 'package:flutter/material.dart';
import 'dart:math';
import '../constraints.dart';

GridTransform gridTransform = GridTransform();
Point<double> blockStartAlignSize = Point(0.2, 0.2);

class GridTransform extends ChangeNotifier{
  Alignment alignment = .center;
  double scale = 1;

  void Move(double x, double y){
    alignment = Alignment(alignment.x + x, alignment.y + y);
    notifyListeners();
  }
  void ScaleAdditive(double add){
    scale += add * scale;

    scale = scale < MIN_SCALE ? MIN_SCALE : scale;
    scale = scale > MAX_SCALE ? MAX_SCALE : scale;
    notifyListeners();
  }

  static Alignment getPosAlignment(Point<int> pos, [Point? offset]){
    double oddYoffset = pos.x % 2 == 0 ? -blockStartAlignSize.y / 2 : 0;
    var offset1 = offset ?? Point(0, 0);
    var align = Alignment(
        (pos.x + offset1.x) * blockStartAlignSize.x,
        (pos.y + offset1.y) * blockStartAlignSize.y + oddYoffset,
    );
    return align * gridTransform.scale + gridTransform.alignment;
  }

  static (double top, double left) getPositionedTopLeft(Point<int> pos, [Point? offset]){
    double oddYoffset = pos.x % 2 == 0 ? -1 / 2 : 0;

    var globalCenter = gridTransform.alignment * 1000;
    var localPos = (Point<num>(pos.x , pos.y) + (offset??Point(0, 0)));

    double left = globalCenter.x + localPos.x * BLOCK_COLLIDER_SIZE.width * gridTransform.scale;
    double top = globalCenter.y + (localPos.y + oddYoffset) * BLOCK_COLLIDER_SIZE.height * gridTransform.scale;
    // double left = globalCenter.x + localPos.x * BLOCK_SIZE.width;
    // double top = globalCenter.y + (localPos.y + oddYoffset) * BLOCK_SIZE.height;
    
    return (left,top);
  }
  
  static Point<int> screenToGrid(Offset screenPos) {
    var globalCenter = gridTransform.alignment * 1000;
    double scaleW = BLOCK_COLLIDER_SIZE.width * gridTransform.scale;
    double scaleH = BLOCK_COLLIDER_SIZE.height * gridTransform.scale;

    // Спочатку знаходимо x — він не залежить від oddYoffset
    int gridX = ((screenPos.dx - globalCenter.x) / scaleW).round();

    // Тепер знаємо парність x → можемо обчислити oddYoffset
    double oddYoffset = gridX % 2 == 0 ? -1 / 2 : 0;

    // Знаходимо y з урахуванням зміщення
    int gridY = ((screenPos.dy - globalCenter.y) / scaleH - oddYoffset).round();

    return Point<int>(gridX, gridY);
  }
}

class GridPositioned extends StatelessWidget {
  final Point<int> point;
  final Point offset;
  final Widget child;
  const GridPositioned({super.key, required this.point, required this.child, this.offset = const Point(0, 0)});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: GridTransform.getPositionedTopLeft(point, offset).$1,
      top: GridTransform.getPositionedTopLeft(point, offset).$2,
      child: child,
    );
  }
}
