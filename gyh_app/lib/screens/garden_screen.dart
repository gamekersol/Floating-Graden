import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../widgets/main_header.dart';
import '../../models/currency_item.dart';
import 'dart:math';

class PosHex {
  final int row, col;
  const PosHex({required this.row, required this.col});

  // Offset → cube coordinates
  (int q, int r) toCube() {
    final q = col;
    final r = row - (col - (col & 1)) ~/ 2;
    return (q, r);
  }

  double get depth {
    final (q, r) = toCube();
    return r * 2 + q.toDouble();
  }
}
const List<CurrencyItem> _currencies = [
  CurrencyItem(iconPath: 'lib/assets/trinckets/coin.svg', value: 10),
  CurrencyItem(iconPath: 'lib/assets/trinckets/seed.svg', value: 5),
  CurrencyItem(iconPath: 'lib/assets/trinckets/diamond.svg', value: 2),
];

const List<PosHex> _blocksPositions = [
  PosHex(row: 0, col: 0),
  PosHex(row: -1, col: 0),
  PosHex(row: 1, col: 0),
  PosHex(row: 0, col: -1),
  PosHex(row: 0, col: 1),
  PosHex(row: -1, col: -1),
  PosHex(row: 1, col: -1),
  PosHex(row: -2, col: 0),
  PosHex(row: 2, col: 0),
  PosHex(row: 0, col: -2),
  PosHex(row: 0, col: 2),
  PosHex(row: -1, col: 1),
  PosHex(row: 1, col: 1),
  PosHex(row: -2, col: -1),
  PosHex(row: 2, col: -1),
];

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sorted = List<PosHex>.from(_blocksPositions)
      ..sort((a, b) => a.depth.compareTo(b.depth));


    return Column(
      children: [
              MainHeader(
          onMenuTap: () => Scaffold.of(context).openDrawer(),
          currency: _currencies
              .map((c) => c.buildWidget(textColor: Colors.white))
              .toList(),
        ),
        Expanded(child: Stack(
        children: [
          for (final pos in sorted)
            Block(alignment: SnapHexPosition(pos, radius, size)),
          ],
        ),
        ),
      ],
    ); 
  }
}

const double radius = 86;

class Block extends StatelessWidget {
  const Block({super.key, required this.alignment});
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 150,
        height: 150,
        child: SvgPicture.asset(
          "lib/assets/plants/block.svg"
          //color: Color(),
          ),
      ),
    );
  }
}

Alignment SnapHexPosition(PosHex pos, double radius, Size screenSize) {
  double hexWidth = radius * 2;
  double hexHeight = radius * sqrt(3);
  double px = pos.col * hexWidth * 0.75;
  double py = pos.row * hexHeight + (pos.col.isOdd ? hexHeight / 2 : 0);
  double ax = px / (screenSize.width / 2);
  double ay = py / (screenSize.height / 2);
  return Alignment(ax, ay);
}