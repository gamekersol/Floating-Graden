import 'package:flutter/material.dart';
import '../data/garden.dart';
import '../models/grid.dart';
// ahh its for check
import '../data/species.dart';

Plant handlingPlant = Plant(species: utrica_dioica);
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
          duration: Duration(milliseconds: 300),
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
    return Stack(
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
                  
                    // Alignment -> грідові координати -> снеп назад в Alignment
                    topLeftPos.value = (details.localPosition.dx, details.localPosition.dy);

                    gridPos = GridTransform.screenToGrid(details.localPosition);
                  
                    isValidPlace.value = blocks.any((block) => block.pos == gridPos && block.plant == null);
                  },
                ),
              ),
              UI(),
            ],
          ),
        ),
      ),]
    );
  }
}

Point<int> gridPos = Point(0, 0);
ValueNotifier <(double, double)> topLeftPos = ValueNotifier((500,500));
ValueNotifier <bool> isValidPlace = new ValueNotifier(false);

class PhantomPlant extends StatefulWidget {
  const PhantomPlant({
    super.key,
  });

  @override
  State<PhantomPlant> createState() => _PhantomPlantState();
}

class _PhantomPlantState extends State<PhantomPlant> {

  static const ColorFilter invalidPlaceColorFilter = ColorFilter.matrix([
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    // Animated Alighment?
    return ListenableBuilder(
      listenable: topLeftPos,
      builder: (context, child) =>
      Stack(
        children: [
          // Arrows
          GridPositioned(
            point: gridPos,
            offset: Point(0.1, 0.2),
            child: Image.asset(
              "assets/images/navigation/move.png",
              width: 70 * gridTransform.scale,
              height: 20 * gridTransform.scale,
              color: Colors.white.withAlpha(100),
              fit: .fill,
            ),
          ),
          // Plant
          GridPositioned(
            point: gridPos,
            offset: Point(-0.1, -2.2),
            child: ListenableBuilder(
              listenable: isValidPlace,
              builder: (context, child) =>  ColorFiltered(
                colorFilter: isValidPlace.value ? 
                  ColorFilter.mode(Colors.transparent, BlendMode.dst) // no effect
                 : invalidPlaceColorFilter,
                child: handlingPlant.getImage(gridTransform.scale)
                ),
            ),
          ), 
        ]  
      )
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
          ListenableBuilder(
            listenable: isValidPlace,
            builder: (context, child) => IconButton.filled(
              // HOTFIX
              onPressed: () {
                PlantOnBlock(gridPos + Point(0, -1), handlingPlant.species);
                isValidPlace.value = blocks.any((block) => block.pos == gridPos + Point(0, -1) && block.plant == null);
              } ,           
              icon: Icon(Icons.check,size: 70, color: isValidPlace.value ? Colors.lightGreen : Colors.grey)
            ),
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