

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import '../../widgets/main_header.dart';
import '../../models/currency_item.dart';
import 'dart:math';

class PosHex {
  final int row, col;
  bool variant;
  PosHex({required this.row, required this.col, this.variant = false});

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



class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});
  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  bool showBlockVariants = false;

  final List<PosHex> _blocksPositions = [
    PosHex(row: 0, col: 0),
    PosHex(row: -1, col: 0, variant: true),
    PosHex(row: 1, col: 0),
    PosHex(row: 0, col: -1),
    PosHex(row: 0, col: 1, variant: true),
    PosHex(row: -1, col: -1),
    PosHex(row: 1, col: -1),
    PosHex(row: -2, col: 0),
    PosHex(row: 2, col: 0),
    PosHex(row: 0, col: -2),
    PosHex(row: 0, col: 2, variant: true),
    PosHex(row: -1, col: 1),
    PosHex(row: 1, col: 1),
    PosHex(row: -2, col: -1, variant: true),
    PosHex(row: 2, col: -1),
  ];
// Get header height (AppBar standard is 56, or measure yours)
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sorted = List<PosHex>.from(_blocksPositions)
      ..sort((a, b) => a.depth.compareTo(b.depth));
      
    final headerHeight = MediaQuery.of(context).padding.top + 56;
    return Stack(
      children: [
        // Blocks fill the entire screen, ignoring header position
        for (final pos in sorted)
          if (!pos.variant || showBlockVariants)
            Block(
              alignment: snapHexPosition(pos, radius, size, headerHeight),
              isVariant: pos.variant,
              onBuy: () => buyBlock(pos),
            ),
        Positioned(
          top: 0, left: 0, right: 0,
          child: MainHeader(
            onMenuTap: () => Scaffold.of(context).openDrawer(),
            currency: _currencies
                .map((c) => c.buildWidget(textColor: Colors.white))
                .toList(),
          ),
        ),

        // FAB floats on top
        Positioned(
          bottom: 16, right: 16,
          child: FloatingActionButton(onPressed: addBlock),
        ),
      ],
    );
  }

  // Returns the 6 hex neighbors of a given position
  List<PosHex> _neighborsOf(PosHex pos) {
    final offsets = pos.col.isOdd
        ? [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (1, -1)]
        : [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, 1), (1, 1)];

    return offsets.map((o) => PosHex(row: pos.row + o.$1, col: pos.col + o.$2)).toList();
  }


  void buyBlock(PosHex pos) {
    print("buy");
    setState(() {
      // Remove variant flag from purchased block
      pos.variant = false;

      // Add neighbors as new variant (purchasable) blocks if not already present
      for (final neighbor in _neighborsOf(pos)) {
        final alreadyExists = _blocksPositions.any((b) => b.row == neighbor.row && b.col == neighbor.col);
        if (!alreadyExists) {
          print("aded new variant");
          neighbor.variant = true;
          _blocksPositions.add(neighbor);
        }
      }

      showBlockVariants = true; // keep variants visible after purchase
    });
  }

  void addBlock() {
    print("Trying add block");
    setState(() {
      showBlockVariants = !showBlockVariants;
    });
  }
}

const double radius = 86;
const _variantColorFilter = ColorFilter.matrix([
    0,    0, 0.5, 0,   0,
    0,    0, 0.5, 0,   0,
    0,    0, 1,   0,   0,
    0,    0, 0,   0.25, 0,
  ]);
class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.alignment,
    required this.isVariant,
    required this.onBuy,
  });

  final Alignment alignment;
  final bool isVariant; // ✅ Fix 2: explicit bool type
  final VoidCallback onBuy;

  

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Stack(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              "lib/assets/plants/block.svg",
              colorFilter: isVariant? _variantColorFilter : ColorFilter.saturation(1)
            ),
          ),
          // ✅ Fix 3: onTap correctly calls onBuy callback
          if (isVariant)
            GestureDetector(
              onTap: onBuy,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(width: 150, height: 150),
            ),
        ],
      ),
    );
  }
}

Alignment snapHexPosition(PosHex pos, double radius, Size screenSize, double headerHeight) {
  double hexWidth = radius * 2;
  double hexHeight = radius * sqrt(3) * 0.67;
  double px = pos.col * hexWidth * 0.75;
  double py = pos.row * hexHeight + (pos.col.isOdd ? hexHeight / 2 : 0);
  double ax = px / (screenSize.width / 2);
  // Shift center down by half header height, in alignment units
  double ay = py / (screenSize.height / 2) + (headerHeight / screenSize.height);
  return Alignment(ax, ay);
}
