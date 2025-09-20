import 'package:flutter/material.dart';

class HoverableScale extends StatefulWidget {
  final Widget child;
  final double scale;
  final Duration duration;

  const HoverableScale({
    super.key,
    required this.child,
    this.scale = 1.04,
    this.duration = const Duration(milliseconds: 160),
  });

  @override
  State<HoverableScale> createState() => _HoverableScaleState();
}

class _HoverableScaleState extends State<HoverableScale> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? widget.scale : 1.0,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
