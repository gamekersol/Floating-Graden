import '../data/garden.dart' as data;
import '../screens/garden.dart';
import 'package:flutter/material.dart';

void addBlock(BuildContext context){
  showDialog(
    context: context, 
    builder: (context) {
      return Align(
        alignment: .center,
        child: Stack(
          children: [
            GestureDetector(onTap: () => Navigator.pop(context),),
            ...List.generate(data.blocks.length, (index) => _PhantomBlockWidget(block: data.blocks[index]),)
          ],
        ),
      );
    },
  );  
}

class _PhantomBlockWidget extends StatelessWidget {
  final data.Block block;
  late Alignment _align;
  _PhantomBlockWidget({required this.block}){
    double oddYoffset = block.pos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;

    // FIX THIS
    _align = Alignment(block.pos.x * blockAlignSize.x * 0.95,
    (block.pos.y * blockAlignSize.y + oddYoffset) * 0.9 - blockAlignSize.y * 0.3);
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      child: const Icon(Icons.add, size: 60,),
      alignment: _align,
    );
  }
}