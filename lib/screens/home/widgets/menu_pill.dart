import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPill extends StatelessWidget {
  final String label;
  final bool active;
  const MenuPill(this.label, {super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final bg = active ? Colors.yellow : Colors.transparent;
    final fg = Colors.black;
    final border = active ? Colors.black : Colors.black26;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border, width: 1),
      ),
      child: Text(
        label,
        style: GoogleFonts.montserrat(
          color: fg,
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
