import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/models/block.dart';
import '../panels/blockEditOverlay.dart' as overlays;
import '../panels/plantsPlacingOverlay.dart';
import '../data/garden.dart' as data;
import '../data/species.dart' as species;
enum GardenState{
  watch,
  buying,
  moving,
}
ValueNotifier<GardenState> state = ValueNotifier(GardenState.watch);

class GridTransform extends ChangeNotifier{
  Alignment alignment = .center;
  double scale = 1;
  static const double MIN_SCALE = 0.2, MAX_SCALE = 1.7;

  GridTransform ();

  void Move(double x, double y){
    alignment = Alignment(alignment.x + x, alignment.y + y);
    notifyListeners();
  }
  void ScaleAdditive(double add){
    scale += add;

    scale = scale < MIN_SCALE ? MIN_SCALE : scale;
    scale = scale > MAX_SCALE ? MAX_SCALE : scale;
    notifyListeners();
  }
}
GridTransform gridTransform = GridTransform();

MovingBlocksOverlay overlayInstance = MovingBlocksOverlay(plant: Plant(species: species.verinika));
class GardenScreen extends StatelessWidget {
  GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    blockAlignSize = Vector2Double(BLOCK_SIZE / x * 1.75, BLOCK_SIZE / y * 1.1);

    return ListenableBuilder(
      listenable: state,
      builder: (context, child) => Stack(
        children: [
        GardenGrid(),
        _BGinteractions(x,y),
        overlayInstance,
        _UI(),
        //if (state == .buying) 
        ]
      ),
    );
  }
}

// TODO borders?

const double _PULL_SENSIVITY = 3, _SCALE_SENSIVITY = 3;
Offset? firstTouchDelta;
double _previousScale = 1.0;

Widget _BGinteractions(double x, double y) {
  if (state.value != GardenState.moving) return SizedBox.shrink();
  return Positioned.fill(
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleUpdate: (details) {
        if (details.pointerCount < 2) {
          gridTransform.Move(
            details.focalPointDelta.dx / x * _PULL_SENSIVITY,
            details.focalPointDelta.dy / y * _PULL_SENSIVITY,
          );
        } else {
          gridTransform.ScaleAdditive((details.scale - _previousScale) * _SCALE_SENSIVITY);
          _previousScale = details.scale;
        }
      },
      onScaleEnd: (_) {
        firstTouchDelta = null;
        _previousScale = 1.0;
      },
      onScaleStart: (_) => _previousScale = 1.0,
    ),
  );
}
class GardenGrid extends StatelessWidget {

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

  static Alignment getPosAlignment(Point pos, [Point? offset]){
    double oddYoffset = pos.x % 2 == 0 ? -blockAlignSize.y / 2 : 0;
    var offset1 = offset ?? Point(0, 0);
    var align = Alignment(
        (pos.x + offset1.x) * blockAlignSize.x,
        (pos.y + offset1.y) * blockAlignSize.y + oddYoffset,
    );
    return align * gridTransform.scale + gridTransform.alignment;
  }

  const GardenGrid({
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
              alignment: .center,
              children: [
                ...List.generate(data.blocks.length, (i) => _BlockWidget(block: data.blocks[i])),
                ...List.generate(data.blocks.length, (i) => _PlantWidget(block: data.blocks[i])),
              ]
            );
          }
        );
      }
    );
  }
}

class _UI extends StatefulWidget {
  const _UI({
    super.key,
  });

  @override
  State<_UI> createState() => _UIState();
}

class _UIState extends State<_UI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 10, vertical: 100),
      child: Align(
        alignment: .bottomEnd,
        child: Column(
          mainAxisAlignment: .end,
          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () { state.value = .buying; overlays.addBlock(context); },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(88, 88), // default is Size(64, 36) — doubled
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
            // ENABLE PLANT SETTING BUTTON
            ElevatedButton(
              onPressed: () => overlayInstance.isEnabled.value = !overlayInstance.isEnabled.value,
              child: Icon(
                Icons.abc,
                color: state.value == .moving ? Colors.amber : Colors.white,
                size: 50,
              ),
            )
          ]
        ),
      )
    );
  }
}



// ---- BLOCK THINGS ----

const double BLOCK_SIZE = 120;
Vector2Double blockAlignSize = Vector2Double(0.2, 0.2);

class _BlockWidget extends StatefulWidget {
  final data.Block block;
  late Alignment _align;
  _BlockWidget({required this.block});

  @override
  State<_BlockWidget> createState() => __BlockWidgetState();
}

class __BlockWidgetState extends State<_BlockWidget> {
  @override
  Widget build(BuildContext context) {
    widget._align = GardenGrid.getPosAlignment(widget.block.pos);
    var s = gridTransform.scale;
    // BLOCK PICTURE
    return Align(
      alignment: widget._align ,
      child: 
        SizedBox(
          width: BLOCK_SIZE * s,
          height: BLOCK_SIZE * s,
          child: SvgPicture.asset("assets/images/plants/block.svg", fit: .contain,),
        ),
    );
  }
}

// FIXME REWRITE ALL THE FUCKING THING

class _PlantWidget extends StatefulWidget {
  final data.Block block;
  late Alignment _align;

  _PlantWidget({required this.block});

  @override
  State<_PlantWidget> createState() => _PlantWidgetState();
}

class _PlantWidgetState extends State<_PlantWidget> {
  @override
  Widget build(BuildContext context) {
    widget._align = GardenGrid.getPosAlignment(widget.block.pos, Point(0.05, -0.7));
    var s = gridTransform.scale;
    // PLANT ITSELF
    return Align(
      alignment: widget._align,
      child: widget.block.plant != null
      ? widget.block.plant!.getImage(s)
      : SizedBox.shrink(),
    );
  }
}
