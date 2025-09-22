import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/app_colors.dart';

class CountdownBand extends StatefulWidget {
  final DateTime target;
  final bool darkOnLight;
  const CountdownBand({super.key, required this.target, this.darkOnLight = false});

  @override
  State<CountdownBand> createState() => _CountdownBandState();
}

class _CountdownBandState extends State<CountdownBand> {
  late Duration remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.target.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final diff = widget.target.difference(DateTime.now());
      setState(() => remaining = diff.isNegative ? Duration.zero : diff);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String two(int n) => n.toString().padLeft(2, '0');
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    final bool darkOnLight = widget.darkOnLight;
    Widget box(String label, String value) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: darkOnLight
              ? Colors.black.withValues(alpha: 0.08)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: darkOnLight ? Colors.black26 : Colors.white24,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.orbitron(
                color: darkOnLight ? Colors.black : AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: darkOnLight ? Colors.black54 : Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        box('DAYS', two(days)),
        box('HRS', two(hours)),
        box('MIN', two(minutes)),
        box('SEC', two(seconds)),
      ],
    );
  }
}
