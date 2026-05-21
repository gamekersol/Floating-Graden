import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:growing_on/models/block.dart';
import 'package:growing_on/models/grid.dart';

class BlockWidget extends StatefulWidget {
  final Block block;
  const BlockWidget({super.key ,required this.block});

  @override
  State<BlockWidget> createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  @override
  Widget build(BuildContext context) {
    return GridPositioned(
      point: widget.block.pos,
      child: 
        SizedBox(
          width: BLOCK_SIZE.width * gridTransform.scale,
          height: BLOCK_SIZE.height * gridTransform.scale,
          child: SvgPicture.asset("assets/images/plants/block.svg", fit: .fill,),
        ),
    );
  }
}