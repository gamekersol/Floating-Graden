import '../models/plant_item.dart';
import '../models/pos_hex.dart';

class BlockDef {
  PlantExemplar? plantExemplar;
  final PosHex blockPosition;

  BlockDef ({required this.blockPosition, this.plantExemplar});
}

