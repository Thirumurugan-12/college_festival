import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_colors.dart';

class BrandItem {
  final String label;
  final IconData icon;
  const BrandItem(this.label, this.icon);
}

class SponsorsStrip extends StatefulWidget {
  final List<BrandItem> items;
  final double height;
  final Color background;
  final Color borderColor;
  const SponsorsStrip({
    super.key,
    required this.items,
    required this.height,
    required this.background,
    required this.borderColor,
  });

  @override
  State<SponsorsStrip> createState() => _SponsorsStripState();
}

class _SponsorsStripState extends State<SponsorsStrip> {
  final ScrollController _ctrl = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (_) {
      if (!_ctrl.hasClients) return;
      final max = _ctrl.position.maxScrollExtent;
      final next = _ctrl.offset + 1.2;
      if (next >= max) {
        _ctrl.jumpTo(0);
      } else {
        _ctrl.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repeated = List<BrandItem>.generate(
      10 * widget.items.length,
      (i) => widget.items[i % widget.items.length],
    );

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        controller: _ctrl,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final it = repeated[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(it.icon, color: AppColors.accentCyan),
                const SizedBox(width: 8),
                Text(
                  it.label,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: repeated.length,
      ),
    );
  }
}
