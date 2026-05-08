
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/garden.dart';
import '../screens/garden.dart';
// ahh its for check
import '../data/species.dart';

Plant handlingPlant = Plant(species: verinika);

class MovingBlocksOverlay extends StatefulWidget {
  ValueNotifier <bool> isEnabled = ValueNotifier(false);
  final Plant plant;

  MovingBlocksOverlay({super.key, required this.plant}){
    handlingPlant = plant;
  }

  @override
  State<MovingBlocksOverlay> createState() => _MovingBlocksOverlayState();
}

class _MovingBlocksOverlayState extends State<MovingBlocksOverlay> {
  @override
  Widget build(BuildContext context) {
    var isEnabled = widget.isEnabled.value;
    return ListenableBuilder(
      listenable: widget.isEnabled,
      builder: (context,child) {
        print("moving plant ovelay : " + isEnabled.toString());
        return AnimatedOpacity(
          opacity: isEnabled == false ? 0 : 1,
          duration: Duration(milliseconds: 2000),
          curve: Curves.easeIn,
          child: IgnorePointer(
            ignoring: !isEnabled,
            child: dumbWidget(),
          ),
        );
      },
    );
  }

  Widget dumbWidget(){
    return SafeArea(
      child: DecoratedBox(
        // Black tint
        decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
        child: Stack(
          children: [
            // Arrows
            Icon(Icons.moving_rounded, size: 200,),
            // Phantom Plant
            PhantomPlant(),
            // GestureDetector
            SizedBox(
              width: 300,
              height: 300,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _x = details.globalPosition.dx;
                  _y = details.globalPosition.dy;
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

double _x = 100;
double _y = 100;

class PhantomPlant extends StatelessWidget {
  const PhantomPlant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 80),
      curve: Curves.easeOut,
      left: _x - 30,
      top:  _y - 30,
      child: handlingPlant.getImage(gridTransform.scale),   
    );
  }
}