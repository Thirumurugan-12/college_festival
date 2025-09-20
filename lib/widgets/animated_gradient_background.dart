import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final List<List<Color>> palettes;
  final Duration cycleDuration;
  final Curve curve;
  final int? currentIndex;

  const AnimatedGradientBackground({
    super.key,
    this.palettes = const [
      [AppColors.white, AppColors.white],
      [AppColors.white, AppColors.white],
      [AppColors.white, AppColors.white],
    ],
    this.cycleDuration = const Duration(seconds: 12),
    this.curve = Curves.easeInOut,
    this.currentIndex,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState
    extends State<AnimatedGradientBackground> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.currentIndex == null) {
      _timer = Timer.periodic(widget.cycleDuration, (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.palettes.length);
      });
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedGradientBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Start/stop timer depending on whether external control is provided
    if (oldWidget.currentIndex == null && widget.currentIndex != null) {
      _timer?.cancel();
      _timer = null;
    } else if (oldWidget.currentIndex != null && widget.currentIndex == null) {
      _timer?.cancel();
      _timer = Timer.periodic(widget.cycleDuration, (_) {
        if (!mounted) return;
        setState(() => _index = (_index + 1) % widget.palettes.length);
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idx = widget.currentIndex ?? _index;
    final colors = widget.palettes[idx % widget.palettes.length];
    return AnimatedContainer(
      duration: widget.cycleDuration,
      curve: widget.curve,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
    );
  }
}
