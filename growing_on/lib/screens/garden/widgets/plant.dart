import 'package:flutter/material.dart';
import 'package:growing_on/models/block.dart';
import 'package:growing_on/models/grid.dart';
import '../../../constraints.dart';

class PlantWidget extends StatefulWidget {
  final Block block;
  const PlantWidget({super.key ,required this.block});

  @override
  State<PlantWidget> createState() => _PlantWidgetState();
}

class _PlantWidgetState extends State<PlantWidget> {
  @override
  Widget build(BuildContext context) {
    // BLOCK PICTURE
    return GridPositioned(
      point: widget.block.pos,
      offset: Point(0, 0.4),
      child: 
        SizedBox(
          width: BLOCK_SIZE.width * gridTransform.scale,
          height: BLOCK_SIZE.height * gridTransform.scale,
          child: widget.block.plant != null
            ? widget.block.plant!.getImage(gridTransform.scale)
            : SizedBox.shrink(),
        ),
    );
  }
}