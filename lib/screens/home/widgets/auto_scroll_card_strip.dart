import 'dart:async';
import 'package:flutter/material.dart';

// Hoverable image with gentle scale and bottom gradient overlay
class HoverableImageCard extends StatefulWidget {
  final String asset;
  final double hoverScale;
  final Duration duration;
  const HoverableImageCard({
    super.key,
    required this.asset,
    required this.hoverScale,
    required this.duration,
  });

  @override
  State<HoverableImageCard> createState() => _HoverableImageCardState();
}

class _HoverableImageCardState extends State<HoverableImageCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? widget.hoverScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.asset,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable continuous auto-scrolling card strip for carousels.
class AutoScrollCardStrip extends StatefulWidget {
  final double height;
  final double itemWidth;
  final int itemCount;
  final List<String>? assets;
  final double radius;
  final EdgeInsetsGeometry itemMargin;
  final double speed; // pixels per frame
  final bool reverse; // scroll in opposite direction
  final bool enableHover; // enable hover scale effect (web/desktop)
  final double hoverScale;
  final Duration hoverDuration;

  const AutoScrollCardStrip({
    super.key,
    required this.height,
    required this.itemWidth,
    required this.itemCount,
    this.assets,
    required this.radius,
    required this.itemMargin,
    required this.speed,
    this.reverse = false,
    this.enableHover = false,
    this.hoverScale = 1.04,
    this.hoverDuration = const Duration(milliseconds: 180),
  });

  @override
  State<AutoScrollCardStrip> createState() => _AutoScrollCardStripState();
}

class _AutoScrollCardStripState extends State<AutoScrollCardStrip> {
  final ScrollController _ctrl = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_ctrl.hasClients) return;
      final max = _ctrl.position.maxScrollExtent;
      final delta = widget.reverse ? -widget.speed : widget.speed;
      final next = _ctrl.offset + delta;
      if (next >= max) {
        _ctrl.jumpTo(0);
      } else if (next <= 0) {
        _ctrl.jumpTo(max);
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
    final baseCount = (widget.assets != null && widget.assets!.isNotEmpty)
        ? widget.assets!.length
        : widget.itemCount;
    final totalItems = baseCount * 50; // long loop
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        controller: _ctrl,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: totalItems,
        itemBuilder: (_, i) {
          return Container(
            width: widget.itemWidth,
            margin: widget.itemMargin,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: widget.enableHover
                ? HoverableImageCard(
                    asset: widget.assets![i % widget.assets!.length],
                    hoverScale: widget.hoverScale,
                    duration: widget.hoverDuration,
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.assets![i % widget.assets!.length],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
