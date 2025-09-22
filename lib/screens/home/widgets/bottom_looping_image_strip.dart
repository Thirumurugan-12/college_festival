import 'dart:async';
import 'package:flutter/material.dart';

// A bottom-fixed strip that auto-scrolls a long rectangular image in a loop.
class BottomLoopingImageStrip extends StatefulWidget {
  final ScrollController controller;
  final void Function(Timer timer) onTickAttach;
  final double height;
  final String imageAssetPath;
  final LinearGradient? overlayGradient;

  const BottomLoopingImageStrip({
    super.key,
    required this.controller,
    required this.onTickAttach,
    required this.height,
    required this.imageAssetPath,
    this.overlayGradient,
  });

  @override
  State<BottomLoopingImageStrip> createState() => _BottomLoopingImageStripState();
}

class _BottomLoopingImageStripState extends State<BottomLoopingImageStrip> {
  late final ImageProvider _imageProvider;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _imageProvider = AssetImage(widget.imageAssetPath);
    // Precache the image to get its dimensions for tiling
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await precacheImage(_imageProvider, context);
      } catch (_) {}
      if (!mounted) return;
      setState(() => _ready = true);
      // Start gentle auto-scroll
      final t = Timer.periodic(const Duration(milliseconds: 16), (_) {
        if (!widget.controller.hasClients) return;
        final max = widget.controller.position.maxScrollExtent;
        final next = widget.controller.offset + 0.6; // slow pan
        if (next >= max) {
          widget.controller.jumpTo(0);
        } else {
          widget.controller.jumpTo(next);
        }
      });
      widget.onTickAttach(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return SizedBox(height: widget.height);
    }
    return SizedBox(
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            controller: widget.controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) => Image(image: _imageProvider, fit: BoxFit.cover),
            itemCount: 1000, // plenty to allow continuous scroll
          ),
          if (widget.overlayGradient != null)
            Container(
              decoration: BoxDecoration(gradient: widget.overlayGradient),
            ),
        ],
      ),
    );
  }
}
