import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'dart:math';

GridTransform gridTransform = GridTransform();
const Size BLOCK_SIZE = Size(175, 110);
Point<double> blockStartAlignSize = Point(0.2, 0.2);

class GridTransform extends ChangeNotifier{
  Alignment alignment = .center;
  double scale = 1;
  static const double MIN_SCALE = 0.05, MAX_SCALE = 4;

  GridTransform ();

  void Move(double x, double y){
    alignment = Alignment(alignment.x + x, alignment.y + y);
    notifyListeners();
  }
  void ScaleAdditive(double add){
    scale += add;

    scale = scale < MIN_SCALE ? MIN_SCALE : scale;
    scale = scale > MAX_SCALE ? MAX_SCALE : scale;
    notifyListeners();
  }

  static Alignment getPosAlignment(Point pos, [Point? offset]){
    double oddYoffset = pos.x % 2 == 0 ? -blockStartAlignSize.y / 2 : 0;
    var offset1 = offset ?? Point(0, 0);
    var align = Alignment(
        (pos.x + offset1.x) * blockStartAlignSize.x,
        (pos.y + offset1.y) * blockStartAlignSize.y + oddYoffset,
    );
    return align * gridTransform.scale + gridTransform.alignment;
  }
  
  static Point screenToGrid(Alignment screenAlign) {
    // Знімаємо трансформацію gridTransform
    Alignment align = (screenAlign - gridTransform.alignment) * (1 / gridTransform.scale);

    // Приблизний x (без урахування oddYoffset)
    double approxX = align.x / blockStartAlignSize.x;
    int gridX = approxX.round();

    // Визначаємо oddYoffset для знайденого x
    double oddYoffset = gridX % 2 == 0 ? -blockStartAlignSize.y / 2 : 0;

    // Точний y з урахуванням зміщення
    double gridY = (align.y - oddYoffset) / blockStartAlignSize.y;

    return Point(gridX, gridY.round());
  }
}

class GridPositioned extends StatelessWidget {
  final Point<int> point;
  final Widget child;
  const GridPositioned({super.key, required this.point, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      
    )
  }
}
