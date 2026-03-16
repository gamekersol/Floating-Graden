//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
//import 'package:gyh_app/app/theme.dart';

class PlantDefinition{
  final String name;
  final String basicPath;
  final double basicSize;
  final List<GrowStage> stages;
  

  const PlantDefinition({
  required this.name,
  required this.basicPath,
  required this.basicSize, 
  required this.stages
  });
}
class PlantExemplar{
  final PlantDefinition definition;
  final double currentScale = 1.0;
  int currentStage = 0;

  PlantExemplar({required this.definition});

  GrowStage getGrowStage(){
    return definition.stages[currentStage];
  }

  double getSize(){
    return definition.basicSize * currentScale;
  }

  String getImagePath(){
    return definition.basicPath + currentStage.toString() + ".svg";
  }
}
class GrowStage{
  final Duration duration;

  const GrowStage({required this.duration});
}
class PlantWidget extends StatefulWidget{
  final PlantExemplar exemplar;

  const PlantWidget({super.key,required this.exemplar});

  @override
  State<StatefulWidget> createState() => _PlantWidgetState();

}
class _PlantWidgetState extends State<PlantWidget> {
  @override
  void initState() {
    super.initState();  // ← required
    Timer(widget.exemplar.getGrowStage().duration, growOn);
  }

  Timer? _timer;

  void growOn() {
    if (widget.exemplar.currentStage >= widget.exemplar.definition.stages.length - 1) {
      return;
    }
    widget.exemplar.currentStage++;
    setState(() {
      
    });

    _timer = Timer(widget.exemplar.getGrowStage().duration, growOn);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    //var stage = widget.exemplar.getGrowStage();
    String imagePath = widget.exemplar.getImagePath();
    //var size = widget.exemplar.getSize();
    return  Positioned(
      left: 25,
      bottom: 80,
      child: SizedBox(
        width: 100, height: 100,
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.fill, // Спробуйте contain для перевірки
          alignment: Alignment.center,
        ),
      )
    );
  }
}