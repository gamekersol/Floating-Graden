import 'package:flutter/material.dart';
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
    handlingPlant.stage = handlingPlant.species.stages.length-1;
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
                LayoutBuilder(
                  builder: (context, constraints) =>  GestureDetector(
                    onPanUpdate: (details) {
                      // Offset -> Alignment (нормалізація під розмір віджета)
                      final screenAlign = Alignment(
                        details.localPosition.dx / (constraints.maxWidth / 2) - 1,
                        details.localPosition.dy / (constraints.maxHeight / 2) - 1,
                      );
                    
                      // Alignment -> грідові координати -> снеп назад в Alignment
                      gridPos = GardenGrid.screenToGrid(screenAlign);
                      final snappedAlign = GardenGrid.getPosAlignment(gridPos);
                    
                      pos.value = snappedAlign;
                    },
                  ),
                ),
                UI(),
              ],
            ),
          ),
        ),]
      )
    );
  }
}

Point gridPos = Point(0, 0);
ValueNotifier <Alignment>  pos = new ValueNotifier(Alignment.center);

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
          builder: (context, child) =>  AnimatedAlign(
            duration: Duration(milliseconds: 120),
            curve: Curves.easeOut,
            alignment: pos.value,
            child: Stack(
              children: [
                // Arrows
                Transform.translate(
                  offset: Offset(0, 70),
                  child: Image.asset(
                    "assets/images/navigation/move.png",
                    width: 100 * gridTransform.scale,
                    height: 40 * gridTransform.scale,
                    color: Colors.white.withAlpha(100),
                    fit: .fill,
                  ),
                ),
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

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.6),
      child: Row(
        mainAxisAlignment: .center,
        spacing: 20,
        children: [
          // APROVE
          IconButton.filled(
            onPressed: () => PlantOnBlock(gridPos, handlingPlant.species),            
            icon: Icon(Icons.check,size: 70, color: Colors.lightGreen,)
          ),
          // DENY
          IconButton.filled(
            onPressed: () => isEnabled.value = false,            
            icon: Icon(Icons.close_rounded,size: 70, color: Colors.redAccent,)
          ),
        ],
      ),
    );
  }
}