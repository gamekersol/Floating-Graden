import 'package:flutter/material.dart';
import 'package:growing_on/models/block.dart';
import 'package:growing_on/models/grid.dart';
import '../../../constraints.dart';

import '../../../data/currency.dart';
import '../../../data/garden.dart' as garden;

class PlantWidget extends StatefulWidget {
  final Block block;
  const PlantWidget({super.key ,required this.block});

  @override
  State<PlantWidget> createState() => _PlantWidgetState();

  void onCollect(){
    currencys.change(.coins, block.plant!.getPrice());
    garden.digOutPlant(block);
  }
}

const int _COLLECT_MARK_SIZE = 30;
const int _COLLECT_MARK_PADDING = 15;

class _PlantWidgetState extends State<PlantWidget> {
  @override
  Widget build(BuildContext context) {
    // BLOCK PICTURE
    return GridPositioned(
      point: widget.block.pos,
      blockOffset: Point(0, -1.3),
      offset: Offset(-PLANT_SIZE_BASIC/2, -PLANT_SIZE_BASIC/2),
      child: widget.block.plant != null ? Stack(
        children:
        [
          //plant image
          widget.block.plant!.getImage(gridTransform.scale),

          //collect mark
          if (widget.block.plant!.isRedyForCollect()) Transform.translate(
            offset: Offset((PLANT_SIZE_BASIC/2 - _COLLECT_MARK_SIZE/2 - _COLLECT_MARK_PADDING), -25) * gridTransform.scale,
            child: GestureDetector(
              onTap: widget.onCollect,
              child: Padding(
                padding: .all(_COLLECT_MARK_PADDING * gridTransform.scale),
                child: Icon(
                  Icons.control_point_duplicate_outlined, 
                  size: _COLLECT_MARK_SIZE* gridTransform.scale,
                  color: Colors.orange.withAlpha(120),),
              ),
            ),
          )
        ]
      ) : SizedBox.shrink(),
    );
  }
}