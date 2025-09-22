import 'dart:async';
import 'package:flutter/material.dart';

// A lightweight, reusable horizontally auto-scrolling text strip.
class AutoScrollTextStrip extends StatefulWidget {
  final double height;
  final Color background;
  final TextStyle textStyle;
  final String text;
  final String separator;
  final bool reverse;
  final double speed; // logical pixels per frame (~16ms)
  final EdgeInsetsGeometry padding;

  const AutoScrollTextStrip({
    super.key,
    required this.height,
    required this.background,
    required this.textStyle,
    required this.text,
    required this.separator,
    required this.reverse,
    required this.speed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  State<AutoScrollTextStrip> createState() => _AutoScrollTextStripState();
}

class _AutoScrollTextStripState extends State<AutoScrollTextStrip> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_controller.hasClients) return;
      final max = _controller.position.maxScrollExtent;
      final next = _controller.offset + widget.speed;
      if (next >= max) {
        _controller.jumpTo(0);
      } else {
        _controller.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repeat the pattern many times to ensure continuous scrolling.
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Container(
        color: widget.background,
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          reverse: widget.reverse,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 500,
          itemBuilder: (_, i) {
            final isSep = i.isOdd;
            final s = isSep ? widget.separator : widget.text;
            return Padding(
              padding: widget.padding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(s, style: widget.textStyle),
              ),
            );
          },
        ),
      ),
    );
  }
}
