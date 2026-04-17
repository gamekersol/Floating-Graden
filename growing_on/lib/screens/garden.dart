import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/models/block.dart';
import '../data/garden.dart' as data;

enum GardenState{
  watch,
  buying,
}
GardenState state = .watch;

class GardenScreen extends StatelessWidget {
  GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    blockAlignSize = Vector2Double(BLOCK_SIZE / x * 1.75, BLOCK_SIZE / y * 1.1);

    return Stack(
      children: [
      _garden(),
      _ui(),
      //if (state == .buying) 
      ]
    );
  }

  Widget _ui (){
    return Align(
      alignment: Alignment(0.8, 0.6),
      child: ElevatedButton(onPressed: ()=>state = .buying, child: Icon(Icons.add),));
  }

  Alignment gardenAlignment = .center;

  Widget _garden (){
    return 
    Align(
      alignment: .center,
      child: Stack(
        children: List.generate(data.blocks.length, (index) => _BlockWidget(block: data.blocks[index]),),
      ),
    );
  }
}

const double BLOCK_SIZE = 120;
Vector2Double blockAlignSize = Vector2Double(0.2, 0.2);

class _BlockWidget extends StatefulWidget {
  final data.Block block;
  late Alignment _align;
  _BlockWidget({required this.block}){
    double oddYoffset = block.pos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;
    _align = Alignment(block.pos.x * blockAlignSize.x, block.pos.y * blockAlignSize.y + oddYoffset);
  }

  @override
  State<_BlockWidget> createState() => __BlockWidgetState();
}

class __BlockWidgetState extends State<_BlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget._align,
      child: SizedBox(
        width: BLOCK_SIZE,
        height: BLOCK_SIZE,
        child: SvgPicture.asset("assets/images/plants/block.svg", fit: .contain,),
      ),
    );
  }
}
