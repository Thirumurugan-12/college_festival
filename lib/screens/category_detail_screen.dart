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

                // Entry Format Section (IFP Style Timeline)
                SliverToBoxAdapter(
                  child: _IFPStyleTimeline(format: widget.data.entryFormat),
                ),

                // Category Information Cards
                SliverToBoxAdapter(
                  child: _CategoryInfoSection(data: widget.data),
                ),

                // Rules Section
                SliverToBoxAdapter(child: _RulesSection(data: widget.data)),

                // Judging Criteria Section
                SliverToBoxAdapter(
                  child: _JudgingCriteriaSection(data: widget.data),
                ),

                // Awards Section
                SliverToBoxAdapter(child: _AwardsSection(data: widget.data)),

                // Spotify Section (only for singing category)
                if (widget.data.categoryName.toLowerCase().contains('singing'))
                  SliverToBoxAdapter(child: _SpotifySection()),

                // Registration Section
                SliverToBoxAdapter(
                  child: _RegistrationSection(data: widget.data),
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
        ],
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
      height: MediaQuery.of(context).size.height * (isMobile ? 0.7 : 0.6),
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
                  SizedBox(
                    height: isMobile ? 170 : 260,
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(height: isMobile ? 20 : 30),
                  // Comic speech bubble
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
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
                      'Competition Challenge!',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 16 : 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
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
                      _bannerItem('REGISTER NOW', 10),
                      const SizedBox(width: 15),
                      _bannerItem('✦', 10),
                      const SizedBox(width: 15),
                      _bannerItem('LIMITED SEATS', 9),
                      const SizedBox(width: 15),
                      _bannerItem('✦', 10),
                      const SizedBox(width: 15),
                      _bannerItem('EXCITING PRIZES', 9),
                      const SizedBox(width: 15),
                      _bannerItem('✦', 10),
                      const SizedBox(width: 15),
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

// Comic Style Timeline for Entry Format
class _IFPStyleTimeline extends StatelessWidget {
  final EntryFormat format;

  const _IFPStyleTimeline({required this.format});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink.withOpacity(0.3),
            Colors.purple.withOpacity(0.4),
            Colors.blue.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        children: [
          // Comic Header
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
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
                      Text('⚡', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text(
                        'ENTRY FORMAT',
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text('⚡', style: TextStyle(fontSize: isMobile ? 24 : 30)),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 6 : 8),
                Text(
                  'Choose the format that suits your vision',
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white60,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 30 : 60),

          // Timeline Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: isMobile ? double.infinity : 1200,
                ),
                child: isMobile
                    ? Column(
                        children: [
                          _buildTimelineCard(
                            icon: Icons.category,
                            title: 'TYPE',
                            value: format.type,
                            color: Colors.cyan,
                            delay: 300,
                            isMobile: true,
                          ),
                          const SizedBox(height: 20),
                          _buildTimelineCard(
                            icon: Icons.schedule,
                            title: 'DURATION',
                            value: format.duration,
                            color: Colors.orange,
                            delay: 500,
                            isMobile: true,
                          ),
                          const SizedBox(height: 20),
                          _buildTimelineCard(
                            icon: Icons.language,
                            title: 'LANGUAGE',
                            value: format.language,
                            color: Colors.purple,
                            delay: 700,
                            isMobile: true,
                          ),
                          const SizedBox(height: 20),
                          _buildTimelineCard(
                            icon: Icons.palette,
                            title: 'STYLE',
                            value: format.style,
                            color: Colors.green,
                            delay: 900,
                            isMobile: true,
                          ),
                          const SizedBox(height: 20),
                          _buildTimelineCard(
                            icon: Icons.upload,
                            title: 'SUBMISSION',
                            value: format.submissionFormat,
                            color: Colors.red,
                            delay: 1100,
                            isMobile: true,
                          ),
                        ],
                      )
                    : constraints.maxWidth > 800
                    ? Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _buildTimelineCard(
                            icon: Icons.category,
                            title: 'TYPE',
                            value: format.type,
                            color: Colors.cyan,
                            delay: 300,
                            isMobile: false,
                          ),
                          _buildTimelineCard(
                            icon: Icons.schedule,
                            title: 'DURATION',
                            value: format.duration,
                            color: Colors.orange,
                            delay: 500,
                            isMobile: false,
                          ),
                          _buildTimelineCard(
                            icon: Icons.language,
                            title: 'LANGUAGE',
                            value: format.language,
                            color: Colors.purple,
                            delay: 700,
                            isMobile: false,
                          ),
                          _buildTimelineCard(
                            icon: Icons.palette,
                            title: 'STYLE',
                            value: format.style,
                            color: Colors.green,
                            delay: 900,
                            isMobile: false,
                          ),
                          _buildTimelineCard(
                            icon: Icons.upload,
                            title: 'SUBMISSION',
                            value: format.submissionFormat,
                            color: Colors.red,
                            delay: 1100,
                            isMobile: false,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTimelineCard(
                                  icon: Icons.category,
                                  title: 'TYPE',
                                  value: format.type,
                                  color: Colors.cyan,
                                  delay: 300,
                                  isMobile: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: _buildTimelineCard(
                                  icon: Icons.schedule,
                                  title: 'DURATION',
                                  value: format.duration,
                                  color: Colors.orange,
                                  delay: 500,
                                  isMobile: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTimelineCard(
                                  icon: Icons.language,
                                  title: 'LANGUAGE',
                                  value: format.language,
                                  color: Colors.purple,
                                  delay: 700,
                                  isMobile: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: _buildTimelineCard(
                                  icon: Icons.palette,
                                  title: 'STYLE',
                                  value: format.style,
                                  color: Colors.green,
                                  delay: 900,
                                  isMobile: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: constraints.maxWidth * 0.6,
                            child: _buildTimelineCard(
                              icon: Icons.upload,
                              title: 'SUBMISSION',
                              value: format.submissionFormat,
                              color: Colors.red,
                              delay: 1100,
                              isMobile: true,
                            ),
                          ),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required int delay,
    required bool isMobile,
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
      child: Container(
        width: isMobile ? null : 280, // Allow flexible width for mobile
        height: isMobile ? null : 180, // Allow flexible height for mobile
        constraints: isMobile
            ? const BoxConstraints(minHeight: 120, maxHeight: 160)
            : BoxConstraints(minHeight: 120, maxHeight: 280),
        padding: EdgeInsets.all(isMobile ? 16 : 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
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
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.orbitron(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: color,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          value,
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: GoogleFonts.orbitron(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: color,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
                  Text('🏆', style: TextStyle(fontSize: isMobile ? 24 : 30)),
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

// Registration Section
class _RegistrationSection extends StatelessWidget {
  final CategoryDetailData data;

  const _RegistrationSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 20 : 40),
      child: FadeInUp(
        duration: const Duration(milliseconds: 800),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PhoneScreen()),
              );
            },
            style:
                ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 40 : 60,
                    vertical: isMobile ? 16 : 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.black, width: 4),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ).copyWith(
                  overlayColor: MaterialStateProperty.all(Colors.red.shade700),
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
              child: Text(
                'REGISTER NOW! 💥',
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Rules Section
class _RulesSection extends StatelessWidget {
  final CategoryDetailData data;

  const _RulesSection({required this.data});

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
            Colors.orange.withOpacity(0.3),
            Colors.red.withOpacity(0.2),
            Colors.purple.withOpacity(0.3),
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
              child: Text(
                '📜 RULES & REGULATIONS 📜',
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 20 : 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),

          ...data.rules.asMap().entries.map((entry) {
            final index = entry.key;
            final rule = entry.value;

            return FadeInUp(
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: index * 200),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(isMobile ? 16 : 20),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: isMobile ? 40 : 50,
                      height: isMobile ? 40 : 50,
                      decoration: BoxDecoration(
                        color: Colors.red,
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
                          '${index + 1}',
                          style: GoogleFonts.fredoka(
                            fontSize: isMobile ? 16 : 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 16 : 20),
                    Expanded(
                      child: Text(
                        rule,
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 14 : 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Judging Criteria Section
class _JudgingCriteriaSection extends StatelessWidget {
  final CategoryDetailData data;

  const _JudgingCriteriaSection({required this.data});

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
            Colors.blue.withOpacity(0.3),
            Colors.purple.withOpacity(0.4),
            Colors.pink.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
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
                      Text(
                        '⚖️',
                        style: TextStyle(fontSize: isMobile ? 24 : 30),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text(
                        'JUDGING CRITERIA',
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text(
                        '⚖️',
                        style: TextStyle(fontSize: isMobile ? 24 : 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                    'How your performance will be evaluated! 🎯',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),

          isMobile
              ? Column(
                  children: data.judgingCriteria.asMap().entries.map((entry) {
                    final index = entry.key;
                    final criterion = entry.value;
                    final colors = [
                      Colors.purple,
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.red,
                    ];
                    final color = colors[index % colors.length];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: Duration(milliseconds: index * 200),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
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
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
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
                                    '${criterion.weightage}%',
                                    style: GoogleFonts.fredoka(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  criterion.parameter,
                                  style: GoogleFonts.fredoka(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: data.judgingCriteria.asMap().entries.map((entry) {
                    final index = entry.key;
                    final criterion = entry.value;
                    final colors = [
                      Colors.purple,
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.red,
                    ];
                    final color = colors[index % colors.length];

                    return FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: Duration(milliseconds: index * 200),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.all(24),
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
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: const Offset(4, 4),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '${criterion.weightage}%',
                                  style: GoogleFonts.fredoka(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
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
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: const Offset(2, 2),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              child: Text(
                                criterion.parameter,
                                style: GoogleFonts.fredoka(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

// Awards Section
class _AwardsSection extends StatelessWidget {
  final CategoryDetailData data;

  const _AwardsSection({required this.data});

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
            Colors.yellow.withOpacity(0.3),
            Colors.orange.withOpacity(0.4),
            Colors.red.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
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
                      Text(
                        '🏆',
                        style: TextStyle(fontSize: isMobile ? 24 : 30),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text(
                        'PRIZES & AWARDS',
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 12),
                      Text(
                        '🏆',
                        style: TextStyle(fontSize: isMobile ? 24 : 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 12 : 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                    'Exciting rewards for outstanding performances! 🎉',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 30 : 40),

          isMobile
              ? Column(
                  children: [
                    _buildAwardCard(
                      '1ST PLACE',
                      data.awards.winner,
                      Colors.amber,
                      Icons.military_tech,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildAwardCard(
                      'RUNNER UP',
                      data.awards.runnerUp,
                      Colors.grey,
                      Icons.workspace_premium,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildAwardCard(
                      'AUDIENCE CHOICE',
                      data.awards.audienceChoice,
                      Colors.purple,
                      Icons.favorite,
                      isMobile,
                    ),
                    const SizedBox(height: 20),
                    _buildAwardCard(
                      'TOP COLLEGE',
                      data.awards.topCollege,
                      Colors.green,
                      Icons.school,
                      isMobile,
                    ),
                  ],
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildAwardCard(
                      '1ST PLACE',
                      data.awards.winner,
                      Colors.amber,
                      Icons.military_tech,
                      isMobile,
                    ),
                    _buildAwardCard(
                      'RUNNER UP',
                      data.awards.runnerUp,
                      Colors.grey,
                      Icons.workspace_premium,
                      isMobile,
                    ),
                    _buildAwardCard(
                      'AUDIENCE CHOICE',
                      data.awards.audienceChoice,
                      Colors.purple,
                      Icons.favorite,
                      isMobile,
                    ),
                    _buildAwardCard(
                      'TOP COLLEGE',
                      data.awards.topCollege,
                      Colors.green,
                      Icons.school,
                      isMobile,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildAwardCard(
    String title,
    String description,
    Color color,
    IconData icon,
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
                    width: 60,
                    height: 60,
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
                    child: Icon(icon, color: Colors.white, size: 30),
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
                          description,
                          style: GoogleFonts.fredoka(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
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
                    child: Icon(icon, color: Colors.white, size: 40),
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
                    description,
                    style: GoogleFonts.fredoka(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
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
