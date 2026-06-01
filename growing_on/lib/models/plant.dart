import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constraints.dart';

class Plant{
  int stage = 0;
  final Species species;

  Plant({required this.species});

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
}

const String _ASSEST_PATH = "assets/images/plants/";

class Species{
  final String name;
  final List<Duration> stages;
  final int collectStage;
  final int price;

  const Species({
    required this.name,
    required this.stages,
    required this.price,
    int? collectStage,
    }) : collectStage = stages.length;

  String getGrowTime(){
    Duration dur = Duration.zero;
    for(var stage in stages) dur += stage;
    return '${dur.inMinutes}m ${dur.inSeconds % 60}s';
  }
}