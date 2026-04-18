import 'dart:collection';
import 'package:growing_on/models/block.dart';

import '../data/garden.dart' as data;
import '../screens/garden.dart';
import 'package:flutter/material.dart';

HashMap <Point,int> buildPositions = HashMap();

void _updateBuildPositions(){
  buildPositions.clear();
  for (var block in data.blocks){
    var pos = block.pos;

    // FIX BAD NEIBORS
    List <Point> neibors = [
      Point(-1, 0),
      Point(1, 0),
      Point(0, -1),
      Point(0, 1),
    ];
    for (var neibor in neibors) {
      var key = pos + neibor;
      var count = buildPositions[key];
      if (count != null) buildPositions[key] = count + 1;
      else buildPositions[key] = 1;
    }
    buildPositions[pos] = -10;
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
            ...buildPositions.keys.map((pos) => _PhantomBlockWidget(blockPos: pos, neibors: buildPositions[pos]!,)),
          ],
        ),
      );
    },
  );  
}

class _PhantomBlockWidget extends StatelessWidget {
  final Point blockPos;
  // defines how many nearby blocks
  final int neibors;
  late Alignment _align;
  _PhantomBlockWidget({required this.blockPos, required this.neibors}){
    double oddYoffset = blockPos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;

    // HOT FIX
    _align = Alignment(blockPos.x * blockAlignSize.x * 0.95,
    (blockPos.y * blockAlignSize.y + oddYoffset) * 0.9 - blockAlignSize.y * 0.3);
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _align,
      child: neibors > 0 ? const Icon(Icons.add, size: 60, color: Colors.white,) : const Icon(Icons.block_sharp, size: 60, color: Colors.redAccent,),
    );
  }
}