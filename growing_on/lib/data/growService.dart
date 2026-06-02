import 'dart:async';
import 'package:growing_on/models/block.dart';

import 'garden.dart' as data;

Future<void> startGrowth(Block instance) async {
  final plant = instance.plant!;
  
  while (plant.stage < plant.species.stages.length) {
    await Future.delayed(plant.species.stages[plant.stage]);
    plant.stage++;
    data.blockNotifier.value++;
  }
}