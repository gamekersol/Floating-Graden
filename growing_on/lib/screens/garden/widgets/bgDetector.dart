import 'package:flutter/material.dart';
import 'package:growing_on/screens.dart';
import '../../../models/grid.dart';

const double _PULL_SENSIVITY = 3, _SCALE_SENSIVITY = 3;
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
            details.focalPointDelta.dx / x * _PULL_SENSIVITY,
            details.focalPointDelta.dy / y * _PULL_SENSIVITY,
          );
        } else {
          gridTransform.ScaleAdditive((details.scale - _previousScale) * _SCALE_SENSIVITY);
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