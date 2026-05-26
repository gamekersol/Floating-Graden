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
      blockOffset: Point(0, -1.3),
      offset: Offset(-PLANT_SIZE_BASIC/2, -PLANT_SIZE_BASIC/2),
      child: widget.block.plant != null
          ? widget.block.plant!.getImage(gridTransform.scale)
          : SizedBox.shrink(),
    );
  }
}