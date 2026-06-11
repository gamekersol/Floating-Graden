import 'package:flutter/material.dart';
import 'package:growing_on/screens.dart';
import '../../../constraints.dart';
import '../../../models/grid.dart';

Offset? firstTouchDelta;
double _previousScale = 1.0;

Widget bgDetector(double x, double y, GardenState state) {
  if (state != GardenState.moving) return SizedBox.shrink();
  return Positioned.fill(
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleUpdate: (details) {
        if (details.pointerCount < 2) {
          gridTransform.Move(
            details.focalPointDelta.dx / x * PULL_SENSIVITY,
            details.focalPointDelta.dy / y * PULL_SENSIVITY,
          );
        } else {
          gridTransform.ScaleAdditive((details.scale - _previousScale) * SCALE_SENSIVITY);
          _previousScale = details.scale;
        }
      },
      onScaleEnd: (_) {
        firstTouchDelta = null;
        _previousScale = 1.0;
      },
      onScaleStart: (_) => _previousScale = 1.0,
    ),
  );
}