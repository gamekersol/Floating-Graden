import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Plant{
  int stage = 0;
  final Species species;

  Plant({required this.species});

  Widget getImage(double globalScale){
    var path = _ASSEST_PATH + species.name + stage.toString() + '.svg';
    return Padding(
      padding: .directional(bottom: 120 * globalScale),
      child: SizedBox(
        width: 100 * globalScale,
        height: 100 * globalScale,
        child: SvgPicture.asset(path, fit: .contain,),
      ),
    );
  }
}

const String _ASSEST_PATH = "assets/images/plants/";

class Species{
  final String name;
  final List<Duration> stages;

  const Species({required this.name, required this.stages});
}