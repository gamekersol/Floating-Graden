import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:gyh_app/models/block_definition.dart';
import 'package:gyh_app/models/plant_item.dart';
import '../data/mock_garden.dart';
import '../models/pos_hex.dart';

// ── Action definition ────────────────────────────────────────────────────────

class BuyBlockAction {
  const BuyBlockAction({required this.position});
  final PosHex position;
}

// ── Screen ───────────────────────────────────────────────────────────────────

class GardenScreen extends StatefulWidget {
  const GardenScreen({super.key});

  @override
  State<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  bool showBlockVariants = false;

  // ── Action handler ──────────────────────────────────────────────────────

  void _handleAction(Object action) {
    if (action is BuyBlockAction) {
      _executeBuyBlock(action.position);
    }
    // Add more action types here as needed:
    // else if (action is SomeOtherAction) { ... }
  }

  void _executeBuyBlock(PosHex pos) {
    setState(() {
      pos.variant = false;

      for (final neighbor in _neighborsOf(pos)) {
        final alreadyExists = mockGardenItems.any(
          (b) =>
              b.blockPosition.row == neighbor.row &&
              b.blockPosition.col == neighbor.col,
        );
        if (!alreadyExists) {
          neighbor.variant = true;
          mockGardenItems.add(BlockDef(blockPosition: neighbor));
        }
      }
      //sort blocks;
      mockGardenItems = List<BlockDef>.from(mockGardenItems)
        ..sort((a, b) => a.blockPosition.depth.compareTo(b.blockPosition.depth));

      showBlockVariants = true;
    });
  }

  // ── Hex helpers ─────────────────────────────────────────────────────────

  List<PosHex> _neighborsOf(PosHex pos) {
    final offsets = pos.col.isOdd
        ? [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, -1), (1, -1)]
        : [(-1, 0), (1, 0), (0, -1), (0, 1), (-1, 1), (1, 1)];

    return offsets
        .map((o) => PosHex(row: pos.row + o.$1, col: pos.col + o.$2))
        .toList();
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headerHeight = MediaQuery.of(context).padding.top + 56;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final block in mockGardenItems)
          if (!block.blockPosition.variant || showBlockVariants)
            Block(
              alignment: snapHexPosition(
                block.blockPosition,
                radius,
                size,
                headerHeight,
              ),
              def: block,
              // Block dispatches a typed action; screen owns all logic
              onAction: _handleAction,
            ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => setState(
              () => showBlockVariants = !showBlockVariants,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Constants & helpers ──────────────────────────────────────────────────────

const double radius = 86;

const _variantColorFilter = ColorFilter.matrix([
  0, 0, 0.5, 0, 0,
  0, 0, 0.5, 0, 0,
  0, 0, 1,   0, 0,
  0, 0, 0,   0.25, 0,
]);

// ── Block widget ─────────────────────────────────────────────────────────────

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.alignment,
    required this.def,
    required this.onAction,
  });

  final Alignment alignment;
  final BlockDef def;
  /// Dispatch any [BuyBlockAction] (or future action types) up to the screen.
  final void Function(Object action) onAction;

  @override
  Widget build(BuildContext context) {
    final pos = def.blockPosition;

    return Align(
      alignment: alignment,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              "assets/plants/block.svg",
              colorFilter: pos.variant
                  ? _variantColorFilter
                  : const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.saturation,
                    ),
            ),
          ),
          if (pos.variant)
            GestureDetector(
              // Create the action here; execute it in the screen
              onTap: () => onAction(BuyBlockAction(position: pos)),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(width: 150, height: 150),
            ),
          if (!pos.variant && def.plantExemplar != null)
            PlantWidget(exemplar: def.plantExemplar!),
        ],
      ),
    );
  }
}