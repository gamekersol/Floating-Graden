import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Plant{
  int stage = 0;
  final Species species;

  Plant({required this.species});

  Widget getImage(){
    var path = _ASSEST_PATH + species.name + stage.toString() + '.svg';
    return SizedBox(
      width: 300,
      height: 300,
      child: SvgPicture.asset(path),
    );
  }
}

const String _ASSEST_PATH = "assets/images/plants/";

class Species{
  final String name;
  final List<Duration> stages;

  const Species({required this.name, required this.stages});
}