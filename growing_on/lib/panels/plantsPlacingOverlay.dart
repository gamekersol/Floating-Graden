
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../data/garden.dart';
import '../screens/garden.dart';
// ahh its for check
import '../data/species.dart';

Plant handlingPlant = Plant(species: verinika);
ValueNotifier <bool> isEnabled = ValueNotifier(false);

class MovingBlocksOverlay extends StatefulWidget {
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
    return ListenableBuilder(
      listenable: isEnabled,
      builder: (context,child) {
        var enabled = isEnabled.value;
        return AnimatedOpacity(
          opacity: enabled == false ? 0 : 1,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          child: IgnorePointer(
            ignoring: !enabled,
            child: dumbWidget(),
          ),
        );
      },
    );
  }

  Widget dumbWidget(){
    return SafeArea(
      child: Stack(
        children: [Positioned.fill(
          child: DecoratedBox(
            // Black tint
            decoration: BoxDecoration(color: Colors.black.withAlpha(100)),
            child: Stack(
              children: [
                // Phantom 
                PhantomPlant(),
                // GestureDetector
                GestureDetector(
                  onPanUpdate: (details) {
                    pos.value = Offset(details.globalPosition.dx, details.globalPosition.dy);
                  },
                ),
              ],
            ),
          ),
        ),]
      )
    );
  }
}

// double _x = 100;
// double _y = 100;
ValueNotifier <Offset>  pos = new ValueNotifier(Offset(300, 300));

class PhantomPlant extends StatefulWidget {
  const PhantomPlant({
    super.key,
  });

  @override
  State<PhantomPlant> createState() => _PhantomPlantState();
}

class _PhantomPlantState extends State<PhantomPlant> {
  @override
  Widget build(BuildContext context) {
    // Animated Alighment?
    return Stack(
      children: [
        ListenableBuilder(
          listenable: pos,
          builder: (context, child) =>  AnimatedPositioned(
            duration: Duration(milliseconds: 80),
            curve: Curves.easeOut,
            left: pos.value.dx - 30,
            top:  pos.value.dy - 30,
            child: Stack(
              children: [
                // Arrows
                Icon(Icons.moving_rounded, size: 100,),
                // Plant
                handlingPlant.getImage(gridTransform.scale), 
              ]  
            )
          ),
        ),
      ],
    );
  }
}