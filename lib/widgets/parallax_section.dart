import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class ParallaxSection extends StatelessWidget {
  final ScrollController scrollController;
  final double height;
  final Widget foreground;
  final List<Color> bgGradient;
  final double parallaxFactor;

  const ParallaxSection({
    super.key,
    required this.scrollController,
    required this.height,
    required this.foreground,
    this.bgGradient = const [AppColors.primaryBg, AppColors.secondaryBg],
    this.parallaxFactor = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: scrollController,
        builder: (context, _) {
          // Approximate offset; safe if controller attached to parent scroll view
          final offset = (scrollController.hasClients
              ? scrollController.offset
              : 0.0);
          final translate = -offset * parallaxFactor;
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background gradient subtly translating for parallax feel
              Transform.translate(
                offset: Offset(0, translate),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: bgGradient,
                    ),
                  ),
                ),
              ),
              // Foreground content centered
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: foreground,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: GoogleFonts.orbitron(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
      ),
    );
  }
}

class SectionText extends StatelessWidget {
  final String text;
  const SectionText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        color: Colors.white,
        fontSize: 16,
        height: 1.6,
      ),
    );
  }
}
