import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../data/garden.dart';
import '../models/grid.dart';
import '../data/inventory.dart';
// ahh its for check
import '../data/species.dart';

Plant handlingPlant = Plant(species: utrica_dioica);
ValueNotifier <int> remainCount = ValueNotifier(0);
ValueNotifier <bool> isEnabled = ValueNotifier(false);

class MovingBlocksOverlay extends StatefulWidget {
  final Plant plant;

  MovingBlocksOverlay({super.key, required this.plant}){
    handlingPlant = plant;
    handlingPlant.stage = handlingPlant.species.stages.length-1;
    print('seed count'+ instance.getSeedCount(plant.species).toString());
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
        remainCount.value = instance.getSeedCount(handlingPlant.species);
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

  static const ColorFilter validPlaceColorFilter = ColorFilter.matrix([
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0,      0,      0,      0.5, 0,
  ]);
  static const ColorFilter invalidPlaceColorFilter = ColorFilter.matrix([
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0,      0,      0,      0.2, 0,
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
            blockOffset: Point(0.1, 0.2),
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
            blockOffset: Point(-0.1, -2.2),
            child: ListenableBuilder(
              listenable: isValidPlace,
              builder: (context, child) =>  ColorFiltered(
                colorFilter: isValidPlace.value && remainCount.value > 0 ? 
                  validPlaceColorFilter // no effect
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
                if (remainCount.value < 1) return;
                PlantOnBlock(gridPos + Point(0, 0), handlingPlant.species);
                //isValidPlace.value = blocks.any((block) => block.pos == gridPos + Point(0, -1) && block.plant == null);
                isValidPlace.value = false;
                remainCount.value--;
                instance.removeSeed(handlingPlant.species , 1);
              } ,           
              icon: Icon(Icons.check,size: 70, color: isValidPlace.value && remainCount.value > 0 ? Colors.lightGreen : Colors.grey)
            ),
          ),
          // DENY
          IconButton.filled(
            onPressed: () => isEnabled.value = false,            
            icon: Icon(Icons.close_rounded,size: 70, color: Colors.redAccent,)
          ),
          ListenableBuilder(
            listenable: remainCount,
            builder:(context, child) =>  SizedBox.square(
              dimension: 70,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/images/trinckets/seed.svg', 
                    fit: .contain,
                    colorFilter: ColorFilter.saturation(remainCount.value > 0 ? 1 : 0.4),
                  ),
                  Text(remainCount.value.toString()),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }
}