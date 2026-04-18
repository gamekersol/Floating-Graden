import 'dart:collection';
import 'package:growing_on/models/block.dart';

import '../data/garden.dart' as data;
import '../screens/garden.dart';
import 'package:flutter/material.dart';

HashSet <Vector2> buildPositions = HashSet();

void _updateBuildPositions(){
  for (var block in data.blocks){
    var pos = block.pos;

    // FIX BAD NEIBORS
    List <Vector2> neibors = [
      Vector2(-1, 0),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(0, 1),
    ];
    for (var neibor in neibors) buildPositions.add(pos + neibor);
  }
}

void addBlock(BuildContext context){
  showDialog(
    context: context, 
    builder: (context) {
      _updateBuildPositions();
      return Align(
        alignment: .center,
        child: Stack(
          children: [
            GestureDetector(onTap: () => Navigator.pop(context),),
            ...buildPositions.map((pos) => _PhantomBlockWidget(blockPos: pos)),
          ],
        ),
      );
    },
  );  
}

class _PhantomBlockWidget extends StatelessWidget {
  final Vector2 blockPos;
  late Alignment _align;
  _PhantomBlockWidget({required this.blockPos}){
    double oddYoffset = blockPos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;

    // HOT FIX
    _align = Alignment(blockPos.x * blockAlignSize.x * 0.95,
    (blockPos.y * blockAlignSize.y + oddYoffset) * 0.9 - blockAlignSize.y * 0.3);
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      child: const Icon(Icons.add, size: 60,),
      alignment: _align,
    );
  }
}