import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:async';
import '../constants/app_colors.dart';
import '../widgets/animated_gradient_background.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for the logo
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for decorative elements
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Start animations
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();

    // Navigate to home screen after 3 seconds
    Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Positioned.fill(
            child: AnimatedGradientBackground(
              currentIndex: 0,
              palettes: const [
                [AppColors.white, AppColors.white],
                [AppColors.white, AppColors.white],
              ],
              cycleDuration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
            ),
          ),

          // Floating particles/decorative elements
          ...List.generate(6, (index) {
            return AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                final angle =
                    (_rotationAnimation.value * 2 * 3.14159) +
                    (index * 3.14159 / 3);
                final radius = isMobile ? 120.0 : 180.0;
                final x =
                    screenWidth / 2 +
                    radius *
                        (0.5 + 0.3 * index / 6) *
                        (index.isEven ? 1 : -1) *
                        (0.6 + 0.4 * (index / 6));
                final y =
                    screenHeight / 2 +
                    radius *
                        (0.3 + 0.4 * index / 6) *
                        (index % 3 == 0 ? 1 : -1) *
                        (0.7 + 0.3 * (index / 6));

                return Positioned(
                  left:
                      x +
                      radius *
                          0.3 *
                          (index.isEven ? 1 : -1) *
                          (0.5 + 0.5 * (index / 6)),
                  top:
                      y +
                      radius *
                          0.3 *
                          (index % 2 == 0 ? 1 : -1) *
                          (0.4 + 0.6 * (index / 6)),
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: isMobile ? 8 : 12,
                      height: isMobile ? 8 : 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: [
                          AppColors.accentCyan,
                          AppColors.accentPink,
                          AppColors.accentGold,
                          AppColors.accentPurple,
                          AppColors.accentOrange,
                          AppColors.accentYellow,
                        ][index].withValues(alpha: 0.6),
                        boxShadow: [
                          BoxShadow(
                            color: [
                              AppColors.accentCyan,
                              AppColors.accentPink,
                              AppColors.accentGold,
                              AppColors.accentPurple,
                              AppColors.accentOrange,
                              AppColors.accentYellow,
                            ][index].withValues(alpha: 0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo/brand
                FadeInDown(
                  duration: const Duration(milliseconds: 1000),
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: isMobile ? 120 : 160,
                          height: isMobile ? 120 : 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.accentCyan.withValues(alpha: 0.3),
                                AppColors.accentPink.withValues(alpha: 0.1),
                                Colors.transparent,
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.accentCyan.withValues(
                                alpha: 0.4,
                              ),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.music_note_rounded,
                              size: isMobile ? 60 : 80,
                              color: AppColors.accentCyan,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: isMobile ? 32 : 48),

                // App title with animation
                FadeInUp(
                  duration: const Duration(milliseconds: 1200),
                  delay: const Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      Text(
                        'Rhythm & Waves',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.orbitron(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: AppColors.accentGold.withValues(
                                alpha: 0.5,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        'FEST 2025',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 16 : 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 40 : 60),

                // Loading indicator
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600),
                  child: Column(
                    children: [
                      SizedBox(
                        width: isMobile ? 40 : 50,
                        height: isMobile ? 40 : 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.accentCyan,
                          ),
                          backgroundColor: AppColors.accentCyan.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 16 : 24),
                      Text(
                        'Loading the stage...',
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom brand/credit
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 1000),
              child: Text(
                'Tamil Nadu College Music Festival',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 12 : 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
