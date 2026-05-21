import 'dart:collection';
import 'package:growing_on/models/block.dart';
import '../data/garden.dart' as data;
import '../screens/garden/widgets/phantomBlock.dart';
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
  List <Point<int>> neibors = [
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
  void buyBlock(Point<int> blockPos){
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
        ...buildPositions.keys.map((pos) => PhantomBlockWidget(pos: pos as Point<int>, neibors: buildPositions[pos]!, onBuy: buyBlock)),
      ],
    );
  }
}