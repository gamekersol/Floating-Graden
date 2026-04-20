import 'dart:collection';
import 'package:growing_on/models/block.dart';

import '../data/garden.dart' as data;
import '../screens/garden.dart';
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
    return Align(
      alignment: .center,
      child: Stack(
        children: [
          GestureDetector(onTap: () => Navigator.pop(context),),
          ...buildPositions.keys.map((pos) => _PhantomBlockWidget(blockPos: pos, neibors: buildPositions[pos]!, onBuy: buyBlock)),
        ],
      ),
    );
  }
}

class _PhantomBlockWidget extends StatelessWidget {
  final Point blockPos;
  // defines how many nearby blocks
  final int neibors;
  final Function(Point) onBuy;
  late Alignment _align;
  _PhantomBlockWidget({required this.blockPos, required this.neibors, required this.onBuy}){
    double oddYoffset = blockPos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;

    // HOT FIX
    _align = Alignment(blockPos.x * blockAlignSize.x * 0.965,
    (blockPos.y * blockAlignSize.y + oddYoffset) * 1 + blockAlignSize.y * 0.2);
    _align *= gridTransform.scale;
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _align,
      child: Padding(
        padding: .fromLTRB(10, 0, 10, 60),
        child: GestureDetector(
          onTap: () => onBuy(blockPos),
          child: neibors > 0 ? const Icon(Icons.add, size: 60, color: Colors.white,) : 
            const Icon(Icons.block_sharp, size: 60, color: Colors.redAccent,)
          ),
      ),
    );
  }
}