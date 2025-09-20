import 'package:flutter/material.dart';

class RevealOnScroll extends StatelessWidget {
  final ScrollController controller;
  final Widget child;
  final double startOffset;
  final Duration duration;

  const RevealOnScroll({
    super.key,
    required this.controller,
    required this.child,
    this.startOffset = 50,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final viewport = controller.position.viewportDimension;
        final offset = controller.offset;
        // We can’t easily get widget position here; approximate based on offset.
        // For now, base on scroll amount to trigger progressive reveal.
        final t = (offset / (viewport * 0.6)).clamp(0.0, 1.0);
        final dy = (1 - t) * startOffset;
        final opacity = t;
        return AnimatedOpacity(
          opacity: opacity,
          duration: duration,
          child: Transform.translate(offset: Offset(0, dy), child: child),
        );
      },
    );
  }
}
