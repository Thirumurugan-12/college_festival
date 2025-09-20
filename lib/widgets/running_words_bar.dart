import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RunningWordsBar extends StatefulWidget {
  final List<String> phrases;
  final double height;
  final Color background;
  final Color borderColor;
  final TextStyle? textStyle;

  const RunningWordsBar({
    super.key,
    required this.phrases,
    required this.height,
    required this.background,
    required this.borderColor,
    this.textStyle,
  });

  @override
  State<RunningWordsBar> createState() => _RunningWordsBarState();
}

class _RunningWordsBarState extends State<RunningWordsBar> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    const step = 1.0; // pixels per tick
    const interval = Duration(milliseconds: 16); // ~60fps
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      if (!_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      final next = _scrollController.offset + step;
      if (next >= max) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style =
        widget.textStyle ??
        GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        );

    // Repeat phrases to ensure a long scrolling surface
    final repeated = List<String>.generate(
      20,
      (i) => widget.phrases[i % widget.phrases.length],
    );

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: widget.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: repeated.length,
        itemBuilder: (_, index) {
          final item = repeated[index];
          return Row(
            children: [
              const SizedBox(width: 16),
              Icon(Icons.circle, size: 6, color: Colors.white.withOpacity(0.7)),
              const SizedBox(width: 16),
              Text(item.toUpperCase(), style: style),
              const SizedBox(width: 32),
            ],
          );
        },
      ),
    );
  }
}
