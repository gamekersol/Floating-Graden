import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growing_on/models/block.dart';
import '../panels/gardenOverlays.dart' as overlays;
import '../data/garden.dart' as data;

enum GardenState{
  watch,
  buying,
}
GardenState state = .watch;

//ValueNotifier <Alignment> gridTransform = ValueNotifier(Alignment.center);

class GridTransform extends ChangeNotifier{
  Alignment alignment = .center;
  double _scale = 1;
  static const double MIN_SCALE = 0.1, MAX_SCALE = 10;

  GridTransform ();

  void Move(double x, double y){
    alignment = Alignment(alignment.x + x, alignment.y + y);
    notifyListeners();
  }
  void ScaleAdditive(double add){
    _scale += add;

    _scale = _scale < MIN_SCALE ? MIN_SCALE : _scale;
    _scale = _scale > MAX_SCALE ? MAX_SCALE : _scale;
    notifyListeners();
  }
}
GridTransform gridTransform = GridTransform();


class GardenScreen extends StatelessWidget {
  GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var x = MediaQuery.of(context).size.width;
    var y = MediaQuery.of(context).size.height;
    blockAlignSize = Vector2Double(BLOCK_SIZE / x * 1.75, BLOCK_SIZE / y * 1.1);

    return Stack(
      children: [
      _GardenGrid(),
      _gardenPullArea(x,y),
      _UI(),
      //if (state == .buying) 
      ]
    );
  }
}

// TODO scaling, selection garden to separate actions, borders?

const double _PULL_SENSIVITY = 3;

Widget _gardenPullArea(double x, double y) {
  return Positioned.fill(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanUpdate: (details) {
        gridTransform.Move(details.delta.dx / x * _PULL_SENSIVITY,
        details.delta.dy / y * _PULL_SENSIVITY);
      },
      onScaleUpdate: (details) {
        if (details.pointerCount < 2) return;
        gridTransform.ScaleAdditive(details.scale / x * 0.016);
      },
    ),
  );
}

class _GardenGrid extends StatelessWidget {

  void sortBlocksForStack() {
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

  const _GardenGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: data.blockNotifier,
      builder: (context, child) {
        sortBlocksForStack();
        return ListenableBuilder(
          listenable: gridTransform,
          builder: (context, child) => 
            Stack(
              children: List.generate(data.blocks.length, (index) => _BlockWidget(block: data.blocks[index]),),
            ),
        );
      }
    );
  }
}

class _UI extends StatelessWidget {
  const _UI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.8, 0.6),
      child: ElevatedButton(onPressed: (){state = .buying; overlays.addBlock(context);}, child: Icon(Icons.add),));
  }
}



// ---- BLOCK THINGS ----

const double BLOCK_SIZE = 120;
Vector2Double blockAlignSize = Vector2Double(0.2, 0.2);

class _BlockWidget extends StatefulWidget {
  final data.Block block;
  late Alignment _align;
  _BlockWidget({required this.block}){
    double oddYoffset = block.pos.x % 2 == 0 ? - blockAlignSize.y / 2 : 0;
    _align = Alignment(block.pos.x * blockAlignSize.x, block.pos.y * blockAlignSize.y + oddYoffset);
  }

  @override
  State<_BlockWidget> createState() => __BlockWidgetState();
}

class __BlockWidgetState extends State<_BlockWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(widget._align.x + gridTransform.alignment.x, widget._align.y + gridTransform.alignment.y),
      child: SizedBox(
        width: BLOCK_SIZE,
        height: BLOCK_SIZE,
        child: SvgPicture.asset("assets/images/plants/block.svg", fit: .contain,),
      ),
    );
  }
}
