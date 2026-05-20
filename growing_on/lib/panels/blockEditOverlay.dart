import 'dart:collection';
import 'package:growing_on/models/block.dart';

import '../data/garden.dart' as data;
import '../screens/garden/screen.dart';
import 'package:flutter/material.dart';

HashMap <Point,int> buildPositions = HashMap();

void _updateBuildPositions(){
  for (var block in data.blocks){
    _buildBlockSet(block);
  }
}
void _buildBlockSet(Block block){
  var pos = block.pos;

  var oddFactor = pos.x % 2 == 0 ? -1 : 1;
  List <Point> neibors = [
    Point(-1, 0),
    Point(1, 0),
    // par that depends on evennes
    Point(-1, 1 * oddFactor),
    Point(1, 1 * oddFactor),
    Point(0, -1),
    Point(0, 1),
  ];
  for (var neibor in neibors) {
    var key = pos + neibor;
    if (buildPositions[key] == -10) continue; // ← не чіпаємо зайняті клітинки
    var count = buildPositions[key];
    if (count != null) buildPositions[key] = count + 1;
    else buildPositions[key] = 1;
  }
  buildPositions[pos] = -10;
}

void addBlock(BuildContext context){
  showDialog(
    context: context, 
    builder: (context) {
      _updateBuildPositions();
      return AddBlockPanel();
    },
  );  
}

class AddBlockPanel extends StatefulWidget {
  const AddBlockPanel({super.key});

  @override
  State<AddBlockPanel> createState() => _AddBlockPanelState();
}

class _AddBlockPanelState extends State<AddBlockPanel> {
  void buyBlock(Point blockPos){
    setState(() {
      data.blocks.add(Block(pos: blockPos));
      _buildBlockSet(Block(pos: blockPos));
      data.blockNotifier.value++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      //alignment: .center,
      children: [
        GestureDetector(onTap: () => Navigator.pop(context),),
        ...buildPositions.keys.map((pos) => _PhantomBlockWidget(blockPos: pos, neibors: buildPositions[pos]!, onBuy: buyBlock)),
      ],
    );
  }
}

class _PhantomBlockWidget extends StatelessWidget {
  final Point blockPos;
  final int neibors;
  final Function(Point) onBuy;

   const _PhantomBlockWidget({
    required this.blockPos,
    required this.neibors,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    Alignment align = GridView.getPosAlignment(blockPos, Point(0, -0.3));
    var s = gridTransform.scale;
    double size = 55 * s;
    return Align(
      alignment: align,
      child: GestureDetector(
        onTap: () => onBuy(blockPos),
        child: neibors > 0
            ? Icon(Icons.add, size: size, color: Colors.white)
            : Icon(Icons.block_sharp, size: size, color: Colors.redAccent),
      ),
    );
  }
}