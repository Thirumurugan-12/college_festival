import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../constants/app_colors.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final double width;
  final double height;
  final Color? accentColor;
  final String? lottieUrl;
  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    this.width = 280,
    this.height = 320, // Rectangular for desktop, overridden for mobile
    this.accentColor,
    this.lottieUrl,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final hover = _hover;
    final cardColor = widget.accentColor ?? AppColors.accentCyan;
    final isMobile = MediaQuery.of(context).size.width < 800;

    // Square cards for both mobile and desktop
    final cardHeight = widget.width;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        transform: Matrix4.identity()
          ..scale(hover ? 1.05 : 1.0)
          ..rotateZ(hover ? 0.01 : 0.0),
        width: widget.width,
        height: cardHeight,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: cardColor.withValues(alpha: 0.1),
          border: Border.all(
            color: cardColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            if (hover) ...[
              BoxShadow(
                color: cardColor.withValues(alpha: 0.25),
                blurRadius: 40,
                spreadRadius: 0,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: -5,
                offset: const Offset(0, 10),
              ),
            ] else ...[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                spreadRadius: -3,
                offset: const Offset(0, 8),
              ),
            ],
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.1),
                Colors.white.withValues(alpha: 0.05),
                cardColor.withValues(alpha: 0.03),
              ],
            ),
          ),
          child: _buildSquareLayout(cardColor, isMobile),
        ),
      ),
    );
  }

  // Square Layout for both mobile and desktop
  Widget _buildSquareLayout(Color cardColor, bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Square animation area
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: cardColor.withValues(alpha: 0.08),
            ),
            child: widget.lottieUrl != null
                ? Lottie.network(
                    widget.lottieUrl!,
                    fit: BoxFit.contain,
                    repeat: true,
                    animate: true,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildFallbackIcon(cardColor);
                    },
                  )
                : _buildFallbackIcon(cardColor),
          ),
        ),

        SizedBox(height: isMobile ? 8 : 12),

        // Content area - responsive sizing
        SizedBox(
          height: isMobile ? 50 : 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: isMobile ? 11 : 13,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 6 : 8,
                      vertical: isMobile ? 2 : 3,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                    ),
                    child: Text(
                      'தமிழ்நாடு',
                      style: GoogleFonts.notoSansTamil(
                        color: cardColor,
                        fontSize: isMobile ? 8 : 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isMobile ? 3 : 4),
                    decoration: BoxDecoration(
                      color: _hover
                          ? cardColor.withValues(alpha: 0.2)
                          : cardColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(isMobile ? 6 : 8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: isMobile ? 10 : 12,
                      color: cardColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFallbackIcon(Color cardColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Icon(widget.icon, size: 36, color: cardColor),
    );
  }
}
