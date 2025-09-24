import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'registration/phone_screen.dart';
import '../widgets/spotify_iframe_card.dart';

class CategoryDetailData {
  final String categoryName;
  final String mode;
  final String participants;
  final String timeline;
  final EntryFormat entryFormat;
  final List<String> rules;
  final List<JudgingCriterion> judgingCriteria;
  final Awards awards;
  final Voting voting;
  final List<String> juryPanel;
  final List<String> importantNotes;

  const CategoryDetailData({
    required this.categoryName,
    required this.mode,
    required this.participants,
    required this.timeline,
    required this.entryFormat,
    required this.rules,
    required this.judgingCriteria,
    required this.awards,
    required this.voting,
    required this.juryPanel,
    required this.importantNotes,
  });
}

class EntryFormat {
  final String type;
  final String duration;
  final String language;
  final String style;
  final String submissionFormat;
  final List<String> songSelection;

  const EntryFormat({
    required this.type,
    required this.duration,
    required this.language,
    required this.style,
    required this.submissionFormat,
    this.songSelection = const [],
  });
}

class JudgingCriterion {
  final String parameter;
  final int weightage;
  const JudgingCriterion(this.parameter, this.weightage);
}

class Awards {
  final String winner;
  final String runnerUp;
  final String audienceChoice;
  final String topCollege;
  const Awards({
    required this.winner,
    required this.runnerUp,
    required this.audienceChoice,
    required this.topCollege,
  });
}

class Voting {
  final DateTime deadline;
  final String platform;
  final String notes;
  const Voting({
    required this.deadline,
    required this.platform,
    required this.notes,
  });
}

class CategoryDetailScreen extends StatefulWidget {
  final CategoryDetailData data;
  final String imageAsset;

  const CategoryDetailScreen({
    super.key,
    required this.data,
    required this.imageAsset,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _scrollController;
  late AnimationController _confettiController;
  late AnimationController _comicElementsController;
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _comicElementsController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Start the entrance animations
    _startEntranceAnimations();
  }

  void _startEntranceAnimations() {
    // Start confetti animation and stop after completion
    _confettiController.forward().then((_) {
      // Confetti animation is done, it will naturally disappear
    });

    // Start comic elements animation and fade out after 3 seconds
    _comicElementsController.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          _comicElementsController.reverse();
        }
      });
    });

    // Bounce animation only for the first 4 seconds
    _bounceController.repeat(reverse: true);
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _bounceController.stop();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _confettiController.dispose();
    _comicElementsController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  Widget _buildComicElements(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Stack(
      children: [
        // POW! bubble in top-left
        Positioned(
          top: 120 + (_bounceController.value * 10),
          left: 20 + (_comicElementsController.value * 50),
          child: Opacity(
            opacity: _comicElementsController.status == AnimationStatus.reverse
                ? (1 - _comicElementsController.value)
                : _comicElementsController.value,
            child: Transform.rotate(
              angle: -0.2 + (_bounceController.value * 0.1),
              child: _buildComicBubble('POW!', Colors.yellow, isMobile),
            ),
          ),
        ),

        // BOOM! bubble in top-right
        Positioned(
          top: 150 + (_bounceController.value * 15),
          right: 30 + (_comicElementsController.value * 60),
          child: Opacity(
            opacity: _comicElementsController.status == AnimationStatus.reverse
                ? (1 - _comicElementsController.value)
                : _comicElementsController.value,
            child: Transform.rotate(
              angle: 0.3 - (_bounceController.value * 0.15),
              child: _buildComicBubble('BOOM!', Colors.red, isMobile),
            ),
          ),
        ),

        // ZAP! bubble in middle-left
        Positioned(
          top:
              MediaQuery.of(context).size.height * 0.4 +
              (_bounceController.value * 20),
          left: 15 + (_comicElementsController.value * 40),
          child: Opacity(
            opacity: _comicElementsController.status == AnimationStatus.reverse
                ? (1 - _comicElementsController.value) * 0.8
                : _comicElementsController.value * 0.8,
            child: Transform.rotate(
              angle: 0.1 + (_bounceController.value * 0.2),
              child: _buildComicBubble('ZAP!', Colors.cyan, isMobile),
            ),
          ),
        ),

        // WOW! bubble in middle-right
        Positioned(
          top:
              MediaQuery.of(context).size.height * 0.5 +
              (_bounceController.value * 12),
          right: 25 + (_comicElementsController.value * 45),
          child: Opacity(
            opacity: _comicElementsController.status == AnimationStatus.reverse
                ? (1 - _comicElementsController.value)
                : _comicElementsController.value,
            child: Transform.rotate(
              angle: -0.15 - (_bounceController.value * 0.1),
              child: _buildComicBubble('WOW!', Colors.green, isMobile),
            ),
          ),
        ),

        // BAM! bubble in bottom area
        Positioned(
          bottom: 200 + (_bounceController.value * 25),
          left:
              MediaQuery.of(context).size.width * 0.3 +
              (_comicElementsController.value * 30),
          child: Opacity(
            opacity: _comicElementsController.status == AnimationStatus.reverse
                ? (1 - _comicElementsController.value) * 0.9
                : _comicElementsController.value * 0.9,
            child: Transform.rotate(
              angle: 0.25 + (_bounceController.value * 0.12),
              child: _buildComicBubble('BAM!', Colors.purple, isMobile),
            ),
          ),
        ),

        // Floating stars
        ...List.generate(8, (index) {
          final double randomX =
              (index * 100.0) % MediaQuery.of(context).size.width;
          final double randomY =
              (index * 80.0) % (MediaQuery.of(context).size.height * 0.8);

          return Positioned(
            left:
                randomX +
                (_comicElementsController.value *
                    30 *
                    (index % 2 == 0 ? 1 : -1)),
            top: randomY + (_bounceController.value * 15 * (index % 3)),
            child: Opacity(
              opacity:
                  _comicElementsController.status == AnimationStatus.reverse
                  ? (1 - _comicElementsController.value) * 0.7
                  : _comicElementsController.value * 0.7,
              child: Transform.rotate(
                angle: _bounceController.value * math.pi * 2,
                child: Text(
                  ['⭐', '✨', '💫', '🌟'][index % 4],
                  style: TextStyle(fontSize: isMobile ? 20 : 25),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildComicBubble(String text, Color color, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.fredoka(
          fontSize: isMobile ? 14 : 18,
          fontWeight: FontWeight.w900,
          color: text == 'ZAP!' || text == 'WOW!' ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF2A0845),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Text(
            widget.data.categoryName.toUpperCase(),
            style: GoogleFonts.fredoka(
              fontSize: isMobile ? 14 : 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              letterSpacing: isMobile ? 1 : 1.5,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A0845), // Deep purple
                  Color(0xFF7209B7), // Bright purple
                  Color(0xFF560BAD), // Medium purple
                  Color(0xFF480CA8), // Dark purple
                ],
              ),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Hero Section
                SliverToBoxAdapter(
                  child: _HeroSection(
                    data: widget.data,
                    imageAsset: widget.imageAsset,
                  ),
                ),

                // Animated Text Banner
                SliverToBoxAdapter(child: _AnimatedTextBanner()),

                // Prizes Section - Now FIRST and GRAND!
                SliverToBoxAdapter(
                  child: _GrandPrizesSection(data: widget.data),
                ),

                // Action Buttons Section (Entry Format, Rules, Judging Criteria)
                SliverToBoxAdapter(
                  child: _ActionButtonsSection(data: widget.data),
                ),

                // Category Information Cards
                SliverToBoxAdapter(
                  child: _CategoryInfoSection(data: widget.data),
                ),

                // Spotify Section (only for singing category)
                if (widget.data.categoryName.toLowerCase().contains('singing'))
                  SliverToBoxAdapter(child: _SpotifySection()),

                // Participant Benefits Section - WIN OR LOSE style
                SliverToBoxAdapter(child: _ParticipantBenefitsSection()),

                // Testimonials Section
                SliverToBoxAdapter(child: _TestimonialsSection()),

                // Footer Section with policies
                SliverToBoxAdapter(child: _FooterSection()),

                // Extra spacing for bottom fixed button
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ), // Space for fixed register button
                ),
              ],
            ),
          ),

          // Confetti overlay
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _confettiController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: ConfettiPainter(_confettiController.value),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),

          // Comic elements overlay
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _comicElementsController,
                builder: (context, child) {
                  return _buildComicElements(context);
                },
              ),
            ),
          ),

          // Fixed Register Now Button - Always Visible at Bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              child: SafeArea(child: _buildFixedRegisterButton(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedRegisterButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: AnimatedBuilder(
        animation: _bounceController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_bounceController.value * 0.05),
            child: Center(
              child: Container(
                width: isMobile ? double.infinity : 390,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhoneScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 24,
                      vertical: isMobile ? 20 : 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.black, width: 4),
                    ),
                    elevation: 12,
                    shadowColor: Colors.black.withOpacity(0.8),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          offset: const Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated flash icon
                        AnimatedBuilder(
                          animation: _bounceController,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle:
                                  math.sin(
                                    _bounceController.value * 2 * math.pi,
                                  ) *
                                  0.1,
                              child: Icon(
                                Icons.flash_on,
                                color: Colors.yellow,
                                size: isMobile ? 28 : 32,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'REGISTER NOW!',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 22 : 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Animated explosion emoji
                        AnimatedBuilder(
                          animation: _bounceController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_bounceController.value * 0.3),
                              child: Text(
                                '💥',
                                style: TextStyle(fontSize: isMobile ? 24 : 28),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Hero Section - Comic Book Style!
class _HeroSection extends StatelessWidget {
  final CategoryDetailData data;
  final String imageAsset;

  const _HeroSection({required this.data, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      height: MediaQuery.of(context).size.height * (isMobile ? 0.5 : 0.6),
      width: double.infinity,
      child: Stack(
        children: [
          // Comic-style background with halftone pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [
                    Colors.yellow.withOpacity(0.8),
                    Colors.orange.withOpacity(0.6),
                    Colors.red.withOpacity(0.4),
                    Colors.purple.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Comic dots pattern overlay
          Positioned.fill(child: CustomPaint(painter: HalftonePainter())),

          // Comic burst rays
          Positioned.fill(child: CustomPaint(painter: ComicBurstPainter())),

          // Comic-style POW! effect in corners
          Positioned(
            top: 40,
            left: 20,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  'POW!',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: 80,
            right: 30,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  'WOW!',
                  style: GoogleFonts.fredoka(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Content with comic speech bubble
          Positioned(
            bottom: isMobile ? 40 : 80,
            left: isMobile ? 20 : 0,
            right: isMobile ? 20 : 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Column(
                children: [
                  // Display image directly without container
                  // Remove the Positioned widget and just use the SizedBox for the logo above the main image.
                  // Place the logo as a child in the Column, before the main image.
                  SizedBox(
                    height: isMobile ? 170 : 0,
                    child: Image.asset(
                      'lib/assets/logo.png',
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(
                    height: isMobile ? 170 : 260,
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  // SizedBox(height: isMobile ? 20 : 30),
                  // Comic speech bubble
                  //   Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 20,
                  //       vertical: 12,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(25),
                  //       border: Border.all(color: Colors.black, width: 3),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black,
                  //           offset: const Offset(4, 4),
                  //           blurRadius: 0,
                  //         ),
                  //       ],
                  //     ),
                  //     child: Text(
                  //       'Competition Challenge!',
                  //       style: GoogleFonts.fredoka(
                  //         fontSize: isMobile ? 16 : 20,
                  //         fontWeight: FontWeight.w700,
                  //         color: Colors.black,
                  //         letterSpacing: 1,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Animated Text Banner like IFP's moving text
class _AnimatedTextBanner extends StatefulWidget {
  @override
  State<_AnimatedTextBanner> createState() => _AnimatedTextBannerState();
}

class _AnimatedTextBannerState extends State<_AnimatedTextBanner>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
            Colors.blue,
            Colors.purple,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: isMobile
          ? _buildMobileBanner(context)
          : _buildDesktopBanner(context),
    );
  }

  Widget _buildMobileBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: double.infinity,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -_controller.value * 400, // Slower animation for mobile
                  0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 8; i++) ...[
                      _bannerItem('SUBMIT FROM 1 OCT TO 30 OCT 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                      _bannerItem('VOTING ENDS ON NOV 5 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                      _bannerItem('RESULTS ON DEC 5 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: double.infinity,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  -_controller.value * 800, // Fixed movement distance
                  0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < 10; i++) ...[
                      _bannerItem('SUBMIT FROM 1 OCT TO 30 OCT 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                      _bannerItem('VOTING ENDS ON NOV 5 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                      _bannerItem('RESULTS ON DEC 5 2025', 16),
                      const SizedBox(width: 30),
                      _bannerItem('✦', 16),
                      const SizedBox(width: 30),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _bannerItem(String text, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.fredoka(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

// Category Info Section with cards like IFP's category selection
class _CategoryInfoSection extends StatelessWidget {
  final CategoryDetailData data;

  const _CategoryInfoSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withOpacity(0.3),
            Colors.blue.withOpacity(0.4),
            Colors.cyan.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🏆', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text(
                    'WHEN WHO WHERE',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text('🏆', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                ],
              ),
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),

          isMobile
              ? Column(
                  children: [
                    _buildInfoCard(
                      'MODE',
                      data.mode,
                      Icons.public,
                      Colors.blue,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoCard(
                      'PARTICIPANTS',
                      data.participants,
                      Icons.people,
                      Colors.green,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildInfoCard(
                      'TIMELINE',
                      data.timeline,
                      Icons.schedule,
                      Colors.orange,
                      isMobile,
                    ),
                  ],
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildInfoCard(
                      'MODE',
                      data.mode,
                      Icons.public,
                      Colors.blue,
                      isMobile,
                    ),
                    _buildInfoCard(
                      'PARTICIPANTS',
                      data.participants,
                      Icons.people,
                      Colors.green,
                      isMobile,
                    ),
                    _buildInfoCard(
                      'TIMELINE',
                      data.timeline,
                      Icons.schedule,
                      Colors.orange,
                      isMobile,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isMobile,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: isMobile ? double.infinity : 300,
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: isMobile
            ? Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(3, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Text(
                            title,
                            style: GoogleFonts.fredoka(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          value,
                          style: GoogleFonts.fredoka(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 35),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(2, 2),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Text(
                      title,
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    value,
                    style: GoogleFonts.fredoka(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}

// Spotify Section - Comic Book Style!
class _SpotifySection extends StatelessWidget {
  const _SpotifySection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    // Sample Spotify URLs - you can make this dynamic later
    final spotifyUrls = [
      'https://open.spotify.com/track/6ePfmi0YETmZ8VRKFtumJF?si=5fbdc44fcf764624', // Never Gonna Give You Up - Rick Astley
      'https://open.spotify.com/track/1hLIKcQCD7i1AwLfnGrwWX?si=8df69a273bf94680', // Hotel California - Eagles
      'https://open.spotify.com/track/0MTdYgTZ25sLCO6kVnDoje?si=d4f212fa43814be8', // Shape of You - Ed Sheeran
      'https://open.spotify.com/track/6uHuw5ynf6PFpJ2adWprxu?si=594654ac8ad14af8', // Levitating - Dua Lipa
      'https://open.spotify.com/track/0aMi5DHyTwYrlOcxp1AM3v?si=1229318b1ae64f57', // Rather Be - Clean Bandit
      'https://open.spotify.com/track/2WfaOiMkCvy7F5fcp2zZ8L', // Blinding Lights - The Weeknd
    ];

    return Container(
      margin: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comic-style section header
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: isMobile ? 24 : 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'CHOOSE A SONG',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 18 : 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: isMobile ? 24 : 28,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Comic-style description
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: const Offset(4, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Text(
              '🎵 Choose a song! Perfect for your singing performance! 🎵',
              textAlign: TextAlign.center,
              style: GoogleFonts.fredoka(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Auto-scrolling infinite carousel of Spotify cards
          _AutoScrollCarousel(songs: spotifyUrls, isMobile: isMobile),

          const SizedBox(height: 16),

          // Comic-style "More Songs" button
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.library_music,
                    color: Colors.black,
                    size: isMobile ? 20 : 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Explore More on Spotify',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Auto-scrolling carousel widget
class _AutoScrollCarousel extends StatefulWidget {
  final List<String> songs;
  final bool isMobile;

  const _AutoScrollCarousel({required this.songs, required this.isMobile});

  @override
  State<_AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends State<_AutoScrollCarousel>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.isMobile ? 0.9 : 0.5,
      initialPage: 0,
    );

    // Start auto-scroll with a delay
    Future.delayed(const Duration(seconds: 2), () {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && !_isHovering && mounted) {
        _currentPage =
            (_currentPage + 1) %
            (widget.songs.length * 100); // Make it infinite
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _pauseAutoScroll() {
    setState(() {
      _isHovering = true;
    });
  }

  void _resumeAutoScroll() {
    setState(() {
      _isHovering = false;
    });
  }

  void _goToPrevious() {
    if (_pageController.hasClients) {
      // Pause auto-scroll temporarily when user manually navigates
      _timer?.cancel();
      _currentPage =
          (_currentPage - 1 + (widget.songs.length * 100)) %
          (widget.songs.length * 100);
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Restart auto-scroll after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && !_isHovering) {
          _startAutoScroll();
        }
      });
    }
  }

  void _goToNext() {
    if (_pageController.hasClients) {
      // Pause auto-scroll temporarily when user manually navigates
      _timer?.cancel();
      _currentPage = (_currentPage + 1) % (widget.songs.length * 100);
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Restart auto-scroll after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && !_isHovering) {
          _startAutoScroll();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create an infinite list by repeating the songs
    final infiniteSongs = List.generate(
      widget.songs.length * 100,
      (index) => widget.songs[index % widget.songs.length],
    );

    return MouseRegion(
      onEnter: (_) => _pauseAutoScroll(),
      onExit: (_) => _resumeAutoScroll(),
      child: Column(
        children: [
          // Main PageView
          SizedBox(
            height: widget.isMobile ? 320 : 380,
            child: PageView.builder(
              controller: _pageController,
              itemCount: infiniteSongs.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SpotifyIframeCard(spotifyUrl: infiniteSongs[index]),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Bottom navigation buttons and indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous button
              Container(
                width: widget.isMobile ? 50 : 60,
                height: widget.isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.yellow, Colors.orange],
                  ),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: _goToPrevious,
                  icon: Text(
                    '❮',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(width: 20),

              // Carousel indicators
              ...List.generate(
                widget.songs.length,
                (index) => Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_currentPage % widget.songs.length) == index
                        ? Colors.yellow
                        : Colors.white.withOpacity(0.7),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 20),

              // Next button
              Container(
                width: widget.isMobile ? 50 : 60,
                height: widget.isMobile ? 50 : 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.cyan, Colors.blue],
                  ),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: const Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: _goToNext,
                  icon: Text(
                    '❯',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Grand Prizes Section - First and Most Attractive!
class _GrandPrizesSection extends StatefulWidget {
  final CategoryDetailData data;

  const _GrandPrizesSection({required this.data});

  @override
  State<_GrandPrizesSection> createState() => _GrandPrizesSectionState();
}

class _GrandPrizesSectionState extends State<_GrandPrizesSection>
    with TickerProviderStateMixin {
  late AnimationController _cashAnimationController;
  late AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    _cashAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _cashAnimationController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber.withOpacity(0.3),
            Colors.yellow.withOpacity(0.5),
            Colors.orange.withOpacity(0.4),
          ],
        ),
        border: Border.all(color: Colors.black, width: 6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Grand Header with Animation
          FadeInDown(
            child: AnimatedBuilder(
              animation: _sparkleController,
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 30,
                    vertical: isMobile ? 20 : 25,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.yellow, Colors.orange],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black, width: 5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(8, 8),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle:
                                math.sin(
                                  _sparkleController.value * 2 * math.pi,
                                ) *
                                0.1,
                            child: Text(
                              '💰',
                              style: TextStyle(fontSize: isMobile ? 32 : 40),
                            ),
                          ),
                          SizedBox(width: isMobile ? 12 : 16),
                          Text(
                            'CASH PRIZES',
                            style: GoogleFonts.fredoka(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(width: isMobile ? 12 : 16),
                          Transform.rotate(
                            angle:
                                -math.sin(
                                  _sparkleController.value * 2 * math.pi,
                                ) *
                                0.1,
                            child: Text(
                              '💰',
                              style: TextStyle(fontSize: isMobile ? 32 : 40),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: const Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          'WIN BIG & GET FAMOUS! 🎉',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Cash Prize Cards with Animation
          _buildGrandPrizeCards(isMobile),
        ],
      ),
    );
  }

  Widget _buildGrandPrizeCards(bool isMobile) {
    return Column(
      children: [
        // Winner - Biggest and Most Prominent
        FadeInUp(
          child: AnimatedBuilder(
            animation: _cashAnimationController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_cashAnimationController.value * 0.05),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isMobile ? 24 : 32),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.yellow],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black, width: 5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(8, 8),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: isMobile ? 35 : 50,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '1ST PLACE WINNER',
                            style: GoogleFonts.fredoka(
                              fontSize: isMobile ? 24 : 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Extract cash amount from winner description
                      Text(
                        _extractCashAmount(widget.data.awards.winner),
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 36 : 48,
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.yellow, width: 2),
                        ),
                        child: Text(
                          'Plus Trophy + Certificate + Digital Badge + Fame!',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 12 : 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.yellow,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Other prizes in a row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Runner Up
            Expanded(
              child: _buildSmallPrizeCard(
                'RUNNER UP',
                widget.data.awards.runnerUp,
                Colors.grey.shade300,
                Icons.workspace_premium,
                isMobile,
              ),
            ),
            const SizedBox(width: 16),
            // Audience Choice
            Expanded(
              child: _buildSmallPrizeCard(
                'AUDIENCE CHOICE',
                widget.data.awards.audienceChoice,
                Colors.blue.shade300,
                Icons.favorite,
                isMobile,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Top College (full width)
        _buildSmallPrizeCard(
          'TOP COLLEGE AWARD',
          widget.data.awards.topCollege,
          Colors.green.shade300,
          Icons.school,
          isMobile,
          fullWidth: true,
        ),
      ],
    );
  }

  String _extractCashAmount(String description) {
    // Extract cash amount from description
    final regex = RegExp(r'(\d{1,3}(?:,\d{3})*)\s*INR');
    final match = regex.firstMatch(description);
    if (match != null) {
      return '₹${match.group(1)} CASH!';
    }
    return '₹20,000 CASH!'; // fallback
  }

  Widget _buildSmallPrizeCard(
    String title,
    String description,
    Color color,
    IconData icon,
    bool isMobile, {
    bool fullWidth = false,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.black, size: isMobile ? 32 : 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _extractCashAmount(description),
              style: GoogleFonts.fredoka(
                fontSize: isMobile ? 16 : 20,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Action Buttons Section - For Entry Format, Rules, and Judging Criteria
class _ActionButtonsSection extends StatelessWidget {
  final CategoryDetailData data;

  const _ActionButtonsSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: Column(
        children: [
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🏆', style: TextStyle(fontSize: isMobile ? 20 : 30)),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text(
                    'COMPETITION DETAILS',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text('🏆', style: TextStyle(fontSize: isMobile ? 20 : 30)),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildActionButton(
                context,
                'ENTRY FORMAT',
                Icons.format_list_bulleted,
                Colors.cyan,
                () => _showEntryFormatDialog(context),
                isMobile,
              ),
              _buildActionButton(
                context,
                'RULES & REGULATIONS',
                Icons.rule,
                Colors.orange,
                () => _showRulesDialog(context),
                isMobile,
              ),
              _buildActionButton(
                context,
                'JUDGING CRITERIA',
                Icons.gavel,
                Colors.purple,
                () => _showJudgingDialog(context),
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
    bool isMobile,
  ) {
    return FadeInUp(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: isMobile ? double.infinity : 200,
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(6, 6),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: isMobile ? 32 : 40, color: Colors.black),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'TAP TO VIEW',
                  style: GoogleFonts.fredoka(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEntryFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _EntryFormatDialog(format: data.entryFormat),
    );
  }

  void _showRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _RulesDialog(rules: data.rules),
    );
  }

  void _showJudgingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _JudgingDialog(criteria: data.judgingCriteria),
    );
  }
}

// Dialog widgets
class _EntryFormatDialog extends StatelessWidget {
  final EntryFormat format;
  const _EntryFormatDialog({required this.format});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade100, Colors.blue.shade100],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Text(
                'ENTRY FORMAT',
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Content
            _buildFormatItem('Type', format.type),
            _buildFormatItem('Duration', format.duration),
            _buildFormatItem('Language', format.language),
            _buildFormatItem('Style', format.style),
            _buildFormatItem('Submission', format.submissionFormat),

            const SizedBox(height: 20),

            // Close button
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Text(
                'CLOSE',
                style: GoogleFonts.fredoka(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: GoogleFonts.fredoka(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RulesDialog extends StatelessWidget {
  final List<String> rules;
  const _RulesDialog({required this.rules});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.red.shade100],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Text(
                'RULES & REGULATIONS',
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Content
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: rules.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: GoogleFonts.fredoka(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            rules[index],
                            style: GoogleFonts.fredoka(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Close button
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Text(
                'CLOSE',
                style: GoogleFonts.fredoka(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JudgingDialog extends StatelessWidget {
  final List<JudgingCriterion> criteria;
  const _JudgingDialog({required this.criteria});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade100],
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Text(
                'JUDGING CRITERIA',
                style: GoogleFonts.fredoka(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Content
            ...criteria
                .map(
                  (criterion) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${criterion.weightage}%',
                            style: GoogleFonts.fredoka(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            criterion.parameter,
                            style: GoogleFonts.fredoka(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),

            const SizedBox(height: 20),

            // Close button
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Text(
                'CLOSE',
                style: GoogleFonts.fredoka(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Participant Benefits Section - IFP Style
class _ParticipantBenefitsSection extends StatelessWidget {
  const _ParticipantBenefitsSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFFF00), // Bright yellow like IFP
            const Color(0xFFFF69B4), // Hot pink
          ],
        ),
        border: Border.all(color: Colors.black, width: 6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(8, 8),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Header - IFP Style
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Text(
                  'WIN OR LOSE,',
                  style: GoogleFonts.fredoka(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFFF1493), // Deep pink
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        offset: const Offset(4, 4),
                        color: Colors.black,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "DOESN'T MATTER!",
                  style: GoogleFonts.fredoka(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFFF1493), // Deep pink
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        offset: const Offset(4, 4),
                        color: Colors.black,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'PARTICIPANT WILL',
                  style: GoogleFonts.fredoka(
                    fontSize: isMobile ? 40 : 64,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFFFF1493), // Deep pink
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        offset: const Offset(6, 6),
                        color: Colors.black,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ALSO GET',
                  style: GoogleFonts.fredoka(
                    fontSize: isMobile ? 40 : 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.yellow.shade300,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        offset: const Offset(6, 6),
                        color: Colors.black,
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // Benefits Cards
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildBenefitCard(
                '📜',
                'CERTIFICATE',
                'Digital certificate of participation',
                Colors.blue,
                isMobile,
              ),
              _buildBenefitCard(
                '🎯',
                'FEEDBACK',
                'Detailed performance feedback from judges',
                Colors.green,
                isMobile,
              ),
              _buildBenefitCard(
                '🌟',
                'PORTFOLIO',
                'Add to your creative portfolio',
                Colors.purple,
                isMobile,
              ),
              // _buildBenefitCard(
              //   '🎪',
              //   'EXPERIENCE',
              //   'Professional competition experience',
              //   Colors.orange,
              //   isMobile,
              // ),
              _buildBenefitCard(
                '🤝',
                'NETWORK',
                'Connect with fellow creators',
                Colors.cyan,
                isMobile,
              ),
              _buildBenefitCard(
                '📱',
                'SHOWCASE',
                'Feature on our social media',
                Colors.red,
                isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard(
    String emoji,
    String title,
    String description,
    Color color,
    bool isMobile,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: isMobile ? double.infinity : 300,
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: TextStyle(fontSize: isMobile ? 40 : 50)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Text(
                title,
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: GoogleFonts.fredoka(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Testimonials Section
class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final testimonials = [
      {
        'name': 'Priya Sharma',
        'college': 'Anna University',
        'text':
            'This competition gave me the confidence to pursue my dreams! The judges feedback was incredibly valuable.',
        'emoji': '🎤',
        'color': Colors.pink,
      },
      {
        'name': 'Arjun Kumar',
        'college': 'VIT Chennai',
        'text':
            'Amazing platform for young talents! Even though I didn\'t win, the experience was worth it.',
        'emoji': '🎭',
        'color': Colors.blue,
      },
      {
        'name': 'Kavya Menon',
        'college': 'SRM University',
        'text':
            'The networking opportunities were fantastic! I connected with so many creative minds.',
        'emoji': '💃',
        'color': Colors.green,
      },
      {
        'name': 'Rajesh Patel',
        'college': 'Loyola College',
        'text':
            'Professional setup and great organization. This is exactly what Tamil Nadu needed!',
        'emoji': '🎬',
        'color': Colors.orange,
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.withOpacity(0.3),
            Colors.blue.withOpacity(0.4),
            Colors.cyan.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        children: [
          // Header
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('💬', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text(
                    'WHAT PARTICIPANTS SAY',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 20 : 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: isMobile ? 8 : 12),
                  Text('💬', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                ],
              ),
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Testimonials Grid
          isMobile
              ? Column(
                  children: testimonials.asMap().entries.map((entry) {
                    final index = entry.key;
                    final testimonial = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _buildTestimonialCard(
                        testimonial,
                        index,
                        isMobile,
                      ),
                    );
                  }).toList(),
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: testimonials.asMap().entries.map((entry) {
                    final index = entry.key;
                    final testimonial = entry.value;
                    return _buildTestimonialCard(testimonial, index, isMobile);
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(
    Map<String, dynamic> testimonial,
    int index,
    bool isMobile,
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: index * 200),
      child: Container(
        width: isMobile ? double.infinity : 300,
        padding: EdgeInsets.all(isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // Avatar and emoji
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: testimonial['color'],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  testimonial['emoji'],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quote
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                '"${testimonial['text']}"',
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // Name and college
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: testimonial['color'],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    testimonial['name'],
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    testimonial['college'],
                    style: GoogleFonts.fredoka(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Footer Section with Policies - Comic Style
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.deepPurple.shade900,
            Colors.black,
            Colors.indigo.shade900,
          ],
        ),
        border: Border.all(color: Colors.yellow, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.3),
            offset: const Offset(0, -4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Comic-style header with speech bubble
          FadeInUp(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Main title container
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 30,
                    vertical: isMobile ? 16 : 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.orange],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.black, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(6, 6),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🎪',
                            style: TextStyle(fontSize: isMobile ? 24 : 32),
                          ),
                          SizedBox(width: isMobile ? 8 : 12),
                          Text(
                            'COLLEGE THIRUVIZHA',
                            style: GoogleFonts.fredoka(
                              fontSize: isMobile ? 20 : 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  offset: const Offset(2, 2),
                                  color: Colors.white,
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: isMobile ? 8 : 12),
                          Text(
                            '🎪',
                            style: TextStyle(fontSize: isMobile ? 24 : 32),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: const Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          'Tamil Nadu\'s Premier College Talent Festival',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 12 : 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                // Comic burst effect in corners
                Positioned(
                  top: -10,
                  left: -10,
                  child: Text(
                    '💥',
                    style: TextStyle(fontSize: isMobile ? 20 : 24),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: Text(
                    '⚡',
                    style: TextStyle(fontSize: isMobile ? 20 : 24),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Comic-style divider
          Container(
            height: 6,
            width: isMobile ? 250 : 400,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow, Colors.cyan, Colors.pink, Colors.green],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: const Offset(3, 3),
                  blurRadius: 0,
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Policy Links - Comic Style
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: const Offset(4, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    'IMPORTANT STUFF 📋',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: isMobile ? 12 : 20,
                  runSpacing: 16,
                  children: [
                    _buildComicPolicyLink(
                      context,
                      'Terms & Conditions',
                      Icons.description,
                      Colors.blue,
                    ),
                    _buildComicPolicyLink(
                      context,
                      'Privacy Policy',
                      Icons.privacy_tip,
                      Colors.green,
                    ),
                    _buildComicPolicyLink(
                      context,
                      'Refund Policy',
                      Icons.payment,
                      Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Contact info - Comic Style
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 20 : 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade800, Colors.purple.shade800],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.yellow, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(6, 6),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(3, 3),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '📞',
                          style: TextStyle(fontSize: isMobile ? 20 : 24),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'GET IN TOUCH',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '📞',
                          style: TextStyle(fontSize: isMobile ? 20 : 24),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Contact items
                  isMobile
                      ? Column(
                          children: [
                            _buildComicContactItem(
                              Icons.email,
                              'info@collegethiruvizha.com',
                              Colors.cyan,
                            ),
                            const SizedBox(height: 12),
                            _buildComicContactItem(
                              Icons.phone,
                              '+91 12345 67890',
                              Colors.green,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildComicContactItem(
                              Icons.email,
                              'info@collegethiruvizha.com',
                              Colors.cyan,
                            ),
                            const SizedBox(width: 40),
                            _buildComicContactItem(
                              Icons.phone,
                              '+91 12345 67890',
                              Colors.green,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Comic-style social media section
          FadeInUp(
            delay: const Duration(milliseconds: 750),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'FOLLOW US! 🚀',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 16 : 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton('📘', 'Facebook', Colors.blue),
                      const SizedBox(width: 12),
                      _buildSocialButton('📸', 'Instagram', Colors.pink),
                      const SizedBox(width: 12),
                      _buildSocialButton('🐦', 'Twitter', Colors.cyan),
                      const SizedBox(width: 12),
                      _buildSocialButton('📺', 'YouTube', Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Copyright - Comic Style
          FadeInUp(
            delay: const Duration(milliseconds: 900),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('©️', style: TextStyle(fontSize: isMobile ? 16 : 20)),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      '${DateTime.now().year} College Thiruvizha. All rights reserved.',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('⚖️', style: TextStyle(fontSize: isMobile ? 16 : 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComicPolicyLink(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        _showPolicyDialog(context, title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.fredoka(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPolicyDialog(BuildContext context, String title) {
    String content = _getPolicyContent(title);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _getPolicyColor(title),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(17),
                        topRight: Radius.circular(17),
                      ),
                      border: const Border(
                        bottom: BorderSide(color: Colors.black, width: 3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getPolicyIcon(title),
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.fredoka(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Content
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        content,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getPolicyColor(String title) {
    switch (title) {
      case 'Terms & Conditions':
        return Colors.blue;
      case 'Privacy Policy':
        return Colors.green;
      case 'Refund Policy':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getPolicyIcon(String title) {
    switch (title) {
      case 'Terms & Conditions':
        return Icons.description;
      case 'Privacy Policy':
        return Icons.privacy_tip;
      case 'Refund Policy':
        return Icons.payment;
      default:
        return Icons.description;
    }
  }

  String _getPolicyContent(String title) {
    switch (title) {
      case 'Terms & Conditions':
        return '''
🎭 WELCOME TO COLLEGE THIRUVIZHA! 🎭

By participating in our festival, you agree to these terms:

📋 GENERAL CONDITIONS:
• Registration is mandatory for all participants
• Valid student ID required at all times
• Follow all safety guidelines and instructions
• Respect fellow participants and organizers
• No outside food or beverages allowed
• Photography/videography may occur for promotional use

🏆 COMPETITION RULES:
• Arrive 30 minutes before your event
• Late arrivals may be disqualified
• Decisions of judges are final
• No electronic devices during competitions
• Props and costumes are participant's responsibility
• Time limits strictly enforced

⚖️ CONDUCT:
• Maintain decorum throughout the event
• No harassment, discrimination, or inappropriate behavior
• Dress code must be appropriate for the event
• No alcohol, smoking, or prohibited substances
• Violation may result in immediate disqualification

📱 DIGITAL CONTENT:
• Photos/videos may be used for marketing
• Social media posts encouraged with official hashtags
• Respect others' privacy when sharing content

🎪 LIABILITY:
• Participate at your own risk
• Organizers not liable for personal injuries or loss
• Insurance coverage recommended
• Emergency contact information required

💫 Have an amazing time at College Thiruvizha! 💫
        ''';

      case 'Privacy Policy':
        return '''
🔐 YOUR PRIVACY MATTERS! 🔐

College Thiruvizha respects your privacy and protects your data:

📊 INFORMATION WE COLLECT:
• Name, email, phone number for registration
• College/university details
• Emergency contact information
• Event preferences and participation history
• Photos/videos during the event
• Feedback and survey responses

🎯 HOW WE USE YOUR DATA:
• Event registration and management
• Communication about festival updates
• Certificate generation and distribution
• Safety and emergency purposes
• Marketing and promotional activities
• Improving future events

🔒 DATA PROTECTION:
• Secure servers with encryption
• Limited access to authorized personnel only
• No sharing with third parties without consent
• Regular security audits and updates
• Data retention for 2 years maximum

📧 COMMUNICATIONS:
• Event-related notifications and updates
• Certificate and results announcements
• Feedback requests and surveys
• Future event invitations (opt-out available)
• Emergency communications if necessary

📸 MEDIA CONSENT:
• Photos/videos may be taken during events
• Used for promotional and marketing purposes
• Posted on social media and official websites
• Contact us to request removal if needed

🎪 YOUR RIGHTS:
• Access your personal data anytime
• Request corrections or updates
• Delete your account and data
• Opt-out of marketing communications
• File complaints about data handling

📞 CONTACT US:
For privacy concerns, email: privacy@collegethiruvizha.com

🌟 Your trust is our priority! 🌟
        ''';

      case 'Refund Policy':
        return '''
💰 REFUND POLICY 💰

Understanding our refund terms for College Thiruvizha:

🎫 REGISTRATION FEES:
• Non-refundable processing fee: ₹50
• Refundable amount varies by cancellation timing
• Multiple event registrations handled separately
• Group registrations follow same individual terms

⏰ REFUND TIMELINE:
• 7+ days before event: 80% refund
• 3-6 days before event: 50% refund
• 1-2 days before event: 25% refund
• Day of event: No refund available
• After event commencement: No refund

🌧️ EVENT CANCELLATION:
• Weather-related cancellations: Full refund
• Technical issues by organizers: Full refund
• Venue unavailability: Full refund or rescheduling
• Force majeure events: Partial refund (50%)

💳 REFUND PROCESS:
• Submit refund request via official channels
• Processing time: 7-14 business days
• Refunds processed to original payment method
• Bank charges may be deducted
• Email confirmation sent upon processing

🏥 MEDICAL EMERGENCIES:
• Medical certificate required
• Full refund minus processing fee
• Request within 48 hours of event
• Doctor's note must be recent
• Emergency contact verification needed

🎭 PARTICIPANT WITHDRAWAL:
• Personal reasons: Standard timeline applies
• Academic conflicts: 50% refund with proof
• Family emergencies: Case-by-case basis
• Travel restrictions: Partial consideration

❌ NON-REFUNDABLE ITEMS:
• Merchandise and souvenirs
• Food and beverage purchases
• Accommodation bookings
• Third-party service fees
• Special workshop materials

📞 REFUND REQUESTS:
Email: refunds@collegethiruvizha.com
Include: Registration ID, reason, supporting documents

💫 Questions? We're here to help! 💫
        ''';

      default:
        return 'Policy content not available.';
    }
  }

  Widget _buildComicContactItem(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(icon, color: Colors.black, size: 16),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.fredoka(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String emoji, String platform, Color color) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement social media links
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(child: Text(emoji, style: TextStyle(fontSize: 18))),
      ),
    );
  }
}

// Custom Painters for Comic Effects
class HalftonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Create halftone dots pattern
    for (double x = 0; x < size.width; x += 20) {
      for (double y = 0; y < size.height; y += 20) {
        canvas.drawCircle(Offset(x, y), 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ComicBurstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw comic burst rays
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * (3.14159 / 180);
      final endPoint = Offset(
        center.dx + 100 * math.cos(angle),
        center.dy + 100 * math.sin(angle),
      );
      canvas.drawLine(center, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ConfettiPainter extends CustomPainter {
  final double animation;

  ConfettiPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    // Only draw confetti during the animation period (first 3 seconds)
    if (animation >= 1.0) return;

    final random = math.Random(42); // Fixed seed for consistent animation

    // Draw confetti pieces
    for (int i = 0; i < 50; i++) {
      final progress = animation + (i * 0.02); // Stagger the confetti timing

      // Starting positions (top of screen)
      final startX = random.nextDouble() * size.width;
      final startY = -50.0;

      // Calculate current position
      final currentX = startX + (random.nextDouble() - 0.5) * 100 * progress;
      final currentY = startY + (size.height + 100) * progress;

      // Skip if confetti has fallen off screen or animation is complete
      if (currentY > size.height + 50 || progress > 1.0) continue;

      // Choose confetti type and color
      final colors = [
        Colors.yellow,
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.purple,
        Colors.pink,
        Colors.cyan,
      ];

      final color = colors[(i + (animation * 10).floor()) % colors.length];
      final paint = Paint()
        ..color = color.withOpacity(0.8)
        ..style = PaintingStyle.fill;

      // Rotation
      final rotation = progress * math.pi * 4 + i;

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(rotation);

      // Draw different confetti shapes
      switch (i % 4) {
        case 0:
          // Rectangle confetti
          canvas.drawRect(const Rect.fromLTWH(-6, -2, 12, 4), paint);
          break;
        case 1:
          // Circle confetti
          canvas.drawCircle(Offset.zero, 4, paint);
          break;
        case 2:
          // Triangle confetti
          final path = Path();
          path.moveTo(0, -6);
          path.lineTo(-4, 4);
          path.lineTo(4, 4);
          path.close();
          canvas.drawPath(path, paint);
          break;
        case 3:
          // Star confetti
          final path = Path();
          for (int j = 0; j < 5; j++) {
            final angle = (j * 72) * (math.pi / 180);
            final x = math.cos(angle) * 6;
            final y = math.sin(angle) * 6;
            if (j == 0) {
              path.moveTo(x, y);
            } else {
              path.lineTo(x, y);
            }
          }
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }

    // Draw comic explosion effects
    if (animation < 0.3) {
      final explosionPaint = Paint()
        ..color = Colors.yellow.withOpacity((0.3 - animation) * 3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      // Draw explosion bursts
      final centerPoints = [
        Offset(size.width * 0.2, size.height * 0.3),
        Offset(size.width * 0.8, size.height * 0.2),
        Offset(size.width * 0.6, size.height * 0.7),
      ];

      for (final center in centerPoints) {
        for (int i = 0; i < 8; i++) {
          final angle = (i * 45) * (math.pi / 180);
          final length = 30 * animation * 10;
          final endPoint = Offset(
            center.dx + length * math.cos(angle),
            center.dy + length * math.sin(angle),
          );
          canvas.drawLine(center, endPoint, explosionPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is! ConfettiPainter ||
        oldDelegate.animation != animation;
  }
}
