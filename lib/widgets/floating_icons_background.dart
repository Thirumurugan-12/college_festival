import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class FloatingIconsBackground extends StatefulWidget {
  final int density; // approximate number of icons
  final Duration tick;
  final double minSize;
  final double maxSize;
  final List<IconData>? icons;
  final double speed; // base speed in px/sec
  final double opacity; // overall opacity multiplier

  const FloatingIconsBackground({
    super.key,
    this.density = 18,
    this.tick = const Duration(milliseconds: 16),
    this.minSize = 14,
    this.maxSize = 28,
    this.icons,
    this.speed = 12,
    this.opacity = 0.08,
  });

  @override
  State<FloatingIconsBackground> createState() =>
      _FloatingIconsBackgroundState();
}

class _FloatingIconsBackgroundState extends State<FloatingIconsBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _t = 0; // seconds

  Size? _lastSize;

  final math.Random _rng = math.Random();

  late List<_Particle> _parts;

  @override
  void initState() {
    super.initState();
    _parts = [];
    _ticker = createTicker((elapsed) {
      setState(() => _t = elapsed.inMilliseconds / 1000.0);
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _ensureInit(Size size) {
    if (_lastSize == size && _parts.isNotEmpty) return;
    _lastSize = size;
    _parts = List.generate(widget.density, (i) {
      final iconSet = widget.icons ?? _defaultIcons;
      return _Particle(
        icon: iconSet[i % iconSet.length],
        x: _rng.nextDouble(),
        y: _rng.nextDouble(),
        vx:
            (_rng.nextBool() ? 1 : -1) *
            (0.6 + _rng.nextDouble()) *
            widget.speed,
        vy:
            (_rng.nextBool() ? 1 : -1) *
            (0.2 + _rng.nextDouble()) *
            widget.speed *
            0.6,
        size:
            widget.minSize +
            _rng.nextDouble() * (widget.maxSize - widget.minSize),
        rot: _rng.nextDouble() * math.pi,
        rotSpeed:
            (_rng.nextBool() ? 1 : -1) * (0.05 + _rng.nextDouble() * 0.15),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: LayoutBuilder(
        builder: (context, c) {
          final size = Size(c.maxWidth, c.maxHeight);
          _ensureInit(size);

          // Choose icon color based on background luminance
          final bg = Theme.of(context).scaffoldBackgroundColor;
          final isDark = bg.computeLuminance() < 0.5;
          final Color iconColor = (isDark ? Colors.white : Colors.black)
              .withOpacity(widget.opacity);

          return Stack(
            fit: StackFit.expand,
            children: _parts.map((p) {
              final pos = p.positionAt(_t, size);
              return Positioned(
                left: pos.dx,
                top: pos.dy,
                child: Transform.rotate(
                  angle: p.rotationAt(_t),
                  child: Icon(p.icon, size: p.size, color: iconColor),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class _Particle {
  final IconData icon;
  final double x; // 0..1
  final double y; // 0..1
  final double vx; // px/sec
  final double vy; // px/sec
  final double size;
  final double rot; // radians initial
  final double rotSpeed; // rad/sec

  const _Particle({
    required this.icon,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.rot,
    required this.rotSpeed,
  });

  Offset positionAt(double t, Size size) {
    final px = (x * size.width + vx * t) % (size.width + size.width * 0.2);
    final py = (y * size.height + vy * t) % (size.height + size.height * 0.2);
    // Wrap around with slight padding to avoid instant pop-in
    final dx = (px < 0) ? px + size.width : px;
    final dy = (py < 0) ? py + size.height : py;
    return Offset(dx - size.width * 0.1, dy - size.height * 0.1);
  }

  double rotationAt(double t) => rot + rotSpeed * t;
}

const List<IconData> _defaultIcons = [
  Icons.music_note_rounded,
  Icons.mic_rounded,
  Icons.graphic_eq_rounded,
  Icons.library_music_rounded,
  Icons.headphones_rounded,
  Icons.palette_rounded,
  Icons.brush_rounded,
  Icons.camera_alt_rounded,
  Icons.theaters_rounded,
  Icons.star_rounded,
  Icons.audiotrack_rounded,
  Icons.movie_filter_rounded,
];
