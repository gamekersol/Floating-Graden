import 'dart:math';
import 'package:flutter/material.dart';

class PosHex {
  final int row, col;
  bool variant;
  PosHex({required this.row, required this.col, this.variant = false});

  (int q, int r) toCube() {
    final q = col;
    final r = row - (col - (col & 1)) ~/ 2;
    return (q, r);
  }

  double get depth {
    final (q, r) = toCube();
    return r * 2 + q.toDouble();
  }
}

Alignment snapHexPosition(PosHex pos, double radius, Size screenSize, double headerHeight) {
  double hexWidth = radius * 2;
  double hexHeight = radius * sqrt(3) * 0.67;
  double px = pos.col * hexWidth * 0.75;
  double py = pos.row * hexHeight + (pos.col.isOdd ? hexHeight / 2 : 0);
  double ax = px / (screenSize.width / 2);
  // Shift center down by half header height, in alignment units
  double ay = py / (screenSize.height / 2) + (headerHeight / screenSize.height);
  return Alignment(ax, ay);
}