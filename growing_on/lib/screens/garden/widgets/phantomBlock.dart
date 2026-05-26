import 'package:flutter/material.dart';
import 'package:growing_on/models/block.dart';
import 'package:growing_on/models/grid.dart';

const Size _SIZE = Size.square(25);

class PhantomBlockWidget extends StatelessWidget {
  final Point<int> pos;
  final int neibors;
  final Function(Point<int>) onBuy;

   const PhantomBlockWidget({
    super.key,
    required this.pos,
    required this.neibors,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
      return GridPositioned(
      point: pos,
      blockOffset: Point(0.45, 0.1),
      child: GestureDetector(
        onTap: () => onBuy(pos),
        child: neibors > 0
            ? Icon(Icons.add, size: _SIZE.height * gridTransform.scale, color: Colors.white)
            : Icon(Icons.block_sharp, size: _SIZE.height * gridTransform.scale, color: Colors.redAccent),
      ),
    );
  }
}