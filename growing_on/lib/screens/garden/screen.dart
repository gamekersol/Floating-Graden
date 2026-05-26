import 'dart:math';
import 'package:flutter/material.dart';

import '../../models/grid.dart';
import '../../panels/blockEditOverlay.dart' as overlays;
import '../../panels/plantsPlacingOverlay.dart';
import '../../data/garden.dart' as data;
import '../../data/species.dart' as species;
import '../../constraints.dart';

import 'widgets/bgDetector.dart';
import 'widgets/block.dart';
import 'widgets/plant.dart';

ValueNotifier<GardenState> state = ValueNotifier(GardenState.watch);

enum GardenState{
  watch,
  buying,
  moving,
}
class GardenScreen extends StatelessWidget {
  GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    blockStartAlignSize = Point(BLOCK_SIZE.width / x, BLOCK_SIZE.height / y);
    gridTransform.alignment = Alignment(x, y) / 2 / 1000;

    return ListenableBuilder(
      listenable: state,
      builder: (context, child) => Stack(
        children: [
        GridView(),
        bgDetector(x,y, state.value),
        MovingBlocksOverlay(plant: data.Plant(species: species.utrica_dioica)),
        _UI(),
        //if (state == .buying) 
        ]
      ),
    );
  }
}

class GridView extends StatelessWidget {

  void _sortBlocksForStack() {
    data.blocks.sort((a, b) {
      // sort by Y
      if (a.pos.y != b.pos.y) {
        return a.pos.y.compareTo(b.pos.y);
      }

      // for same X make even comparsion
      int aIsEven = a.pos.x.toInt().abs() % 2;
      int bIsEven = b.pos.x.toInt().abs() % 2;

      if (aIsEven != bIsEven) {
        // isnt even prioritize
        return aIsEven.compareTo(bIsEven); 
      }

      // if evennes is equal sort simply
      return a.pos.x.compareTo(b.pos.x);
    });
  }

  const GridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: data.blockNotifier,
      builder: (context, child) {
        return ListenableBuilder(
          listenable: gridTransform,
          builder: (context, child) {
            _sortBlocksForStack();
            return Stack(
              children: [
                ...List.generate(data.blocks.length, (i) => BlockWidget(block: data.blocks[i],)),
                ...List.generate(data.blocks.length, (i) => PlantWidget(block: data.blocks[i])),
              ]
            );
          }
        );
      }
    );
  }
}

class _UI extends StatefulWidget {
  const _UI();

  @override
  State<_UI> createState() => _UIState();
}

class _UIState extends State<_UI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 10, vertical: 100),
      child: Container(
        alignment: .centerRight,
        padding: .symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: .end,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () { state.value = .buying; overlays.addBlock(context); },
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(88, 88), // default is Size(64, 36) — doubled
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.brown[300]
              ),
              child: const Icon(Icons.add, size: 50, color: Colors.white,),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                state.value = state.value != .moving ? .moving : .watch;
              }),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(88, 88),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.brown[300]
              ),
              child: Icon(
                Icons.mode_of_travel_outlined,
                color: state.value == .moving ? Colors.amber : Colors.white,
                size: 50,
              ),
            ),
          ]
        ),
      )
    );
  }
}
