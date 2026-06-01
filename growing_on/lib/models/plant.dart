import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/data/species.dart';
import 'species.dart';
import '../constraints.dart';

export 'species.dart';

const String _ASSEST_PATH = "assets/images/plants/";

class Plant{
  int stage;
  final Species species;

  Plant({required this.species, this.stage = 0});

  Widget getImage(double globalScale){
    var path = _ASSEST_PATH + species.name + stage.toString() + '.svg';
    return SizedBox(
      width: PLANT_SIZE_BASIC * globalScale,
      height: PLANT_SIZE_BASIC * globalScale,
      child: SvgPicture.asset(path, fit: .contain,),
    );
  }
  bool isRedyForCollect () => stage == species.collectStage;
  int getPrice () => species.price;

  Map<String, dynamic> toJson() =>
  {
    'stage' : stage,
    'species' : species.name,
  };

  factory Plant.fromJson(Map<String, dynamic> json) => 
  Plant(
    species: dict[json['species']]!, 
    stage: json['stage']
  );
}