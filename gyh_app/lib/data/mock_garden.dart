import 'package:gyh_app/data/plant_definitions.dart';
import 'package:gyh_app/models/plant_item.dart';
import 'package:gyh_app/models/pos_hex.dart';

import '../models/block_definition.dart';
//import '../data/plant_definitions.dart';

List<BlockDef> mockGardenItems = [
  BlockDef(
    blockPosition:  PosHex(row: 0, col: 0)
  ),
  BlockDef(
    blockPosition:  PosHex(row: 0, col: -1, variant: true),
  ),
  BlockDef(
    blockPosition:  PosHex(row: 0, col: 1),
    plantExemplar: PlantExemplar(
      definition: PlantDefs.sunFlower,
      )
  ),
];