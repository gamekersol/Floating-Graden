import '../models/plant_item.dart';

class PlantDefs {
  PlantDefs._();

  static const sunFlower = PlantDefinition(
    name: "Sunflower",
    basicPath: 'assets/plants/sunflower',
    basicSize: 100.0,
    stages: [
      GrowStage(duration: Duration(seconds: 3)),
      GrowStage(duration: Duration(seconds: 3)),
      GrowStage(duration: Duration(seconds: -1)),
      //zamini on sthort path;
    ],
  );
}