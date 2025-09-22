import 'dart:async';
import 'package:flutter/material.dart';
import 'section3_card.dart';

// Simple spec holder for category cards in mobile carousel
class CategoryCardSpec {
  final String asset;
  final double height;
  final VoidCallback onTap;
  const CategoryCardSpec(this.asset, this.height, this.onTap);
}

// Auto horizontal scroller for category cards on mobile
class AutoHorizontalCategoryCards extends StatefulWidget {
  final double height;
  final double itemWidth;
  // Back-compat: previously interpreted as pixels/frame for auto-scroll.
  // Now used to derive default auto-advance interval if autoAdvanceEvery is null.
  final double speed;
  final List<CategoryCardSpec> items;

  const AutoHorizontalCategoryCards({
    super.key,
    required this.height,
    required this.itemWidth,
    required this.speed,
    required this.items,
  });

  @override
  State<AutoHorizontalCategoryCards> createState() => _AutoHorizontalCategoryCardsState();
}

class _AutoHorizontalCategoryCardsState extends State<AutoHorizontalCategoryCards> {
  late PageController _pageController;
  Timer? _autoTimer;
  Timer? _resumeTimer;
  bool _userInteracting = false;
  static const int _kLoopBase = 10000; // large base for infinite like behavior
  double _viewportFraction = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _kLoopBase * (widget.items.length),
      viewportFraction: _viewportFraction,
    );
    _startAuto();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _resumeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAuto() {
    _autoTimer?.cancel();
    final interval = _deriveIntervalFromSpeed();
    if (interval <= Duration.zero) return;
    _autoTimer = Timer.periodic(interval, (_) {
      if (!mounted || _userInteracting) return;
      if (!_pageController.hasClients) return;
      final current = _pageController.page?.round() ?? _pageController.initialPage;
      final next = current + 1;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  Duration _deriveIntervalFromSpeed() {
    final pixelsPerSec = widget.speed * 60.0;
    if (pixelsPerSec <= 0) return const Duration(seconds: 4);
    final seconds = (widget.itemWidth / pixelsPerSec).clamp(1.5, 8.0);
    return Duration(milliseconds: (seconds * 1000).round());
  }

  void _pauseForInteraction() {
    _userInteracting = true;
    _autoTimer?.cancel();
    _resumeTimer?.cancel();
  }

  void _scheduleResume() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      _userInteracting = false;
      _startAuto();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final fraction = (widget.itemWidth / maxW).clamp(0.5, 1.0);
        if ((fraction - _viewportFraction).abs() > 0.001) {
          final currentPage = _pageController.hasClients
              ? _pageController.page?.round() ?? _pageController.initialPage
              : _pageController.initialPage;
          final old = _pageController;
          _viewportFraction = fraction;
          _pageController = PageController(
            initialPage: currentPage,
            viewportFraction: _viewportFraction,
          );
          if (!_userInteracting) {
            _startAuto();
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            old.dispose();
          });
        }
        return Listener(
          onPointerDown: (_) => _pauseForInteraction(),
          onPointerUp: (_) => _scheduleResume(),
          onPointerCancel: (_) => _scheduleResume(),
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (_, index) {
              final it = widget.items[index % widget.items.length];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: it.onTap,
                  child: Center(
                    child: SizedBox(
                      height: widget.height,
                      width: widget.itemWidth,
                      child: Section3Card(asset: it.asset, height: it.height),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
