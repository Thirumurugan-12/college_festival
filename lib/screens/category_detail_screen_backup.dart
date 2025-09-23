import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import '../constants/app_colors.dart';
import '../widgets/glass_header.dart';
import 'registration/phone_screen.dart';

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

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late final ConfettiController _leftConfetti;
  late final ConfettiController _rightConfetti;

  @override
  void initState() {
    super.initState();
    _leftConfetti = ConfettiController(duration: const Duration(seconds: 2));
    _rightConfetti = ConfettiController(duration: const Duration(seconds: 2));
    // Fire after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _leftConfetti.play();
      _rightConfetti.play();
    });
  }

  @override
  void dispose() {
    _leftConfetti.dispose();
    _rightConfetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0A0A0A), // Deep black like IFP
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.data.categoryName.toUpperCase(),
          style: GoogleFonts.orbitron(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 2.0,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Hero Section
            SliverToBoxAdapter(
              child: _HeroSection(data: widget.data, imageAsset: widget.imageAsset),
            ),
            
            // Animated Text Banner
            SliverToBoxAdapter(
              child: _AnimatedTextBanner(),
            ),
            
            // Timeline Section
            SliverToBoxAdapter(
              child: _TimelineSection(),
            ),
            
            // Entry Format Section
            SliverToBoxAdapter(
              child: _FullPageTimeline(format: widget.data.entryFormat),
            ),
            
            // Categories Section (like IFP's category cards)
            SliverToBoxAdapter(
              child: _CategoryInfoCards(data: widget.data),
            ),
            
            // Registration Button
            SliverToBoxAdapter(
              child: _RegistrationSection(),
            ),
          ],
        ),
      ),
    );
  }
}
                kToolbarHeight + 24,
                16,
                120,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 700),
                        child: Text(
                          widget.data.categoryName.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Centered hero card with responsive size and subtle overlay
                      LayoutBuilder(
                        builder: (context, c) {
                          final isWide = c.maxWidth >= 900;
                          final double cardW = isWide ? 560 : 340;
                          final double cardH = isWide ? 320 : 220;
                          return Align(
                            alignment: Alignment.center,
                            child: ZoomIn(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 100),
                              child: _HeroImageCard(
                                imageAsset: widget.imageAsset,
                                mode: widget.data.mode,
                                width: cardW + 40,
                                height: cardH,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      FadeInUp(
                        duration: const Duration(milliseconds: 700),
                        delay: const Duration(milliseconds: 150),
                        child: _InfoRow(data: widget.data),
                      ),
                      const SizedBox(height: 16),

                      // Full-page Timeline Animation
                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _FullPageTimeline(format: widget.data.entryFormat),
                      ),
                      if (widget.data.entryFormat.songSelection.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        SlideInLeft(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 300),
                          child: _CardBlock(
                            title: 'Suggested Songs',
                            icon: Icons.queue_music,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.data.entryFormat.songSelection
                                  .asMap()
                                  .entries
                                  .map(
                                    (entry) => FadeInRight(
                                      duration: const Duration(
                                        milliseconds: 400,
                                      ),
                                      delay: Duration(
                                        milliseconds: 400 + (entry.key * 50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.music_note,
                                              size: 16,
                                              color: AppColors.accentPink,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                entry.value,
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      SlideInRight(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 350),
                        child: _CardBlock(
                          title: 'Rules',
                          icon: Icons.rule,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.rules
                                .asMap()
                                .entries
                                .map(
                                  (entry) => FadeInLeft(
                                    duration: const Duration(milliseconds: 400),
                                    delay: Duration(
                                      milliseconds: 450 + (entry.key * 80),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 3,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 6,
                                            ),
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: AppColors.accentCyan,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 400),
                        child: _CardBlock(
                          title: 'Judging Criteria',
                          icon: Icons.assessment,
                          child: Column(
                            children: widget.data.judgingCriteria
                                .asMap()
                                .entries
                                .map(
                                  (entry) => FadeInUp(
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(
                                      milliseconds: 500 + (entry.key * 100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 6,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: AppColors.accentCyan
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                entry.value.parameter,
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: AppColors.accentPink,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                '${entry.value.weightage}%',
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideInLeft(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 450),
                        child: _CardBlock(
                          title: 'Awards',
                          icon: Icons.emoji_events,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInRight(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 550),
                                child: _AwardItem(
                                  icon: Icons.emoji_events,
                                  color: Colors.amber,
                                  title: 'Winner',
                                  description: widget.data.awards.winner,
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInRight(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 600),
                                child: _AwardItem(
                                  icon: Icons.military_tech,
                                  color: Colors.grey[400]!,
                                  title: 'Runner Up',
                                  description: widget.data.awards.runnerUp,
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInRight(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 650),
                                child: _AwardItem(
                                  icon: Icons.favorite,
                                  color: Colors.red,
                                  title: 'Audience Choice',
                                  description:
                                      widget.data.awards.audienceChoice,
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInRight(
                                duration: const Duration(milliseconds: 500),
                                delay: const Duration(milliseconds: 700),
                                child: _AwardItem(
                                  icon: Icons.school,
                                  color: AppColors.accentCyan,
                                  title: 'Top College',
                                  description: widget.data.awards.topCollege,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideInRight(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 500),
                        child: _CardBlock(
                          title: 'Voting',
                          icon: Icons.how_to_vote,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInLeft(
                                duration: const Duration(milliseconds: 400),
                                delay: const Duration(milliseconds: 600),
                                child: _InfoItem(
                                  icon: Icons.schedule,
                                  title: 'Deadline',
                                  value:
                                      '${widget.data.voting.deadline.day}/${widget.data.voting.deadline.month}/${widget.data.voting.deadline.year}',
                                ),
                              ),
                              const SizedBox(height: 6),
                              FadeInLeft(
                                duration: const Duration(milliseconds: 400),
                                delay: const Duration(milliseconds: 650),
                                child: _InfoItem(
                                  icon: Icons.computer,
                                  title: 'Platform',
                                  value: widget.data.voting.platform,
                                ),
                              ),
                              const SizedBox(height: 6),
                              FadeInLeft(
                                duration: const Duration(milliseconds: 400),
                                delay: const Duration(milliseconds: 700),
                                child: _InfoItem(
                                  icon: Icons.info,
                                  title: 'Notes',
                                  value: widget.data.voting.notes,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 550),
                        child: _CardBlock(
                          title: 'Jury Panel',
                          icon: Icons.gavel,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.data.juryPanel
                                .asMap()
                                .entries
                                .map(
                                  (entry) => FadeInUp(
                                    duration: const Duration(milliseconds: 400),
                                    delay: Duration(
                                      milliseconds: 650 + (entry.key * 100),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.accentCyan.withOpacity(
                                              0.8,
                                            ),
                                            AppColors.accentPink.withOpacity(
                                              0.8,
                                            ),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        entry.value,
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideInDown(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                        child: _CardBlock(
                          title: 'Important Notes',
                          icon: Icons.info_outline,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.importantNotes
                                .asMap()
                                .entries
                                .map(
                                  (entry) => FadeInUp(
                                    duration: const Duration(milliseconds: 400),
                                    delay: Duration(
                                      milliseconds: 700 + (entry.key * 100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 6,
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Icon(
                                              Icons.lightbulb,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              entry.value,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Confetti poppers from top corners
          Positioned(
            top: kToolbarHeight + 8,
            left: 8,
            child: ConfettiWidget(
              confettiController: _leftConfetti,
              blastDirection: 0.8, // down-right
              emissionFrequency: 0.07,
              numberOfParticles: 12,
              gravity: 0.5,
              shouldLoop: false,
            ),
          ),
          Positioned(
            top: kToolbarHeight + 8,
            right: 8,
            child: ConfettiWidget(
              confettiController: _rightConfetti,
              blastDirection: 2.35, // down-left
              emissionFrequency: 0.07,
              numberOfParticles: 12,
              gravity: 0.5,
              shouldLoop: false,
            ),
          ),

          // Bottom sticky Register button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Center(
                child: SlideInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: Pulse(
                    duration: const Duration(seconds: 2),
                    infinite: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withOpacity(0.1),
                        border: Border.all(color: Colors.white24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        width: 360,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PhoneScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.app_registration),
                          label: const Text('Register Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 8,
                            shadowColor: Colors.yellow.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final CategoryDetailData data;
  const _InfoRow({required this.data});
  @override
  Widget build(BuildContext context) {
    Widget chip(IconData icon, String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.accentCyan),
          const SizedBox(width: 8),
          Text(text, style: GoogleFonts.montserrat(color: Colors.white)),
        ],
      ),
    );

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        chip(Icons.wifi, data.mode),
        chip(Icons.people, data.participants),
        chip(Icons.schedule, data.timeline),
      ],
    );
  }
}

class _FullPageTimeline extends StatelessWidget {
  final EntryFormat format;
  
  const _FullPageTimeline({required this.format});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: screenWidth, // Full screen width
      height: screenHeight * 0.8, // Take up 80% of screen height for more impact
      margin: EdgeInsets.zero, // Remove any margin
      padding: EdgeInsets.zero, // Remove any padding
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0F0F23), // Very dark navy
            const Color(0xFF1A1A2E), // Dark purple similar to image
            const Color(0xFF16213E), // Darker blue
            const Color(0xFF0F3460), // Navy blue
            const Color(0xFF533483), // Purple accent
          ],
        ),
      ),
      child: Stack(
        children: [
          // Timeline Header
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.pink,
                      size: 30,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'ENTRY FORMAT',
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.yellow,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(
                      Icons.star,
                      color: Colors.pink,
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Curved Timeline Path
          Positioned.fill(
            child: CustomPaint(
              painter: _FullPageTimelinePainter(),
            ),
          ),
          
          // Timeline Items positioned along the curve - using full width
          Positioned(
            left: 20, // Close to edge for full width effect
            top: screenHeight * 0.25,
            child: FadeInLeft(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 300),
              child: _FullPageTimelineItem(
                icon: Icons.flag,
                title: 'TYPE',
                subtitle: format.type,
                color: Colors.cyan,
              ),
            ),
          ),
          
          Positioned(
            left: screenWidth * 0.25,
            top: screenHeight * 0.15,
            child: FadeInDown(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 500),
              child: _FullPageTimelineItem(
                icon: Icons.schedule,
                title: 'DURATION',
                subtitle: format.duration,
                color: Colors.orange,
              ),
            ),
          ),
          
          Positioned(
            right: screenWidth * 0.25,
            top: screenHeight * 0.15,
            child: FadeInDown(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 700),
              child: _FullPageTimelineItem(
                icon: Icons.language,
                title: 'LANGUAGE',
                subtitle: format.language,
                color: Colors.purple,
              ),
            ),
          ),
          
          Positioned(
            right: 20, // Close to edge for full width effect
            top: screenHeight * 0.25,
            child: FadeInRight(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 900),
              child: _FullPageTimelineItem(
                icon: Icons.palette,
                title: 'STYLE',
                subtitle: format.style,
                color: Colors.green,
              ),
            ),
          ),
          
          // Center bottom item
          Positioned(
            left: 0,
            right: 0,
            bottom: screenHeight * 0.08,
            child: FadeInUp(
              duration: Duration(milliseconds: 800),
              delay: Duration(milliseconds: 1100),
              child: Center(
                child: _FullPageTimelineItem(
                  icon: Icons.upload,
                  title: 'SUBMISSION',
                  subtitle: format.submissionFormat,
                  color: Colors.red,
                  isCenter: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FullPageTimelineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isCenter;
  
  const _FullPageTimelineItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: isCenter ? 220 : 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.orbitron(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _FullPageTimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.cyan,
          Colors.purple,
          Colors.orange,
          Colors.green,
          Colors.red,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    
    // Create a flowing curved path using full width - edge to edge
    // Start from far left edge
    path.moveTo(40, size.height * 0.4);
    
    // Curve to top left item
    path.quadraticBezierTo(
      size.width * 0.15, size.height * 0.2,
      size.width * 0.25, size.height * 0.25,
    );
    
    // Smooth curve across the top to top right item
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.1,
      size.width * 0.75, size.height * 0.25,
    );
    
    // Curve to far right edge
    path.quadraticBezierTo(
      size.width * 0.85, size.height * 0.2,
      size.width - 40, size.height * 0.4,
    );
    
    // Dramatic curve down to center bottom spanning full width
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.65,
      size.width * 0.5, size.height * 0.75,
    );
    
    // Complete the full-width curve back to start
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.65,
      40, size.height * 0.4,
    );
    
    canvas.drawPath(path, paint);
    
    // Add outer glow effect
    final glowPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.cyan.withOpacity(0.3),
          Colors.purple.withOpacity(0.3),
          Colors.orange.withOpacity(0.3),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);
    
    canvas.drawPath(path, glowPaint);
    
    // Add particles along the path
    final particlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    // Draw small particles along the path
    for (double t = 0; t <= 1; t += 0.05) {
      final metric = path.computeMetrics().first;
      final position = metric.getTangentForOffset(metric.length * t)?.position;
      if (position != null) {
        canvas.drawCircle(
          position,
          2,
          particlePaint..color = Colors.white.withOpacity(0.6),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardBlock extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon;
  const _CardBlock({required this.title, required this.child, this.icon});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.black87),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: GoogleFonts.orbitron(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _AwardItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _AwardItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: GoogleFonts.montserrat(
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.accentCyan),
        const SizedBox(width: 10),
        Text(
          '$title: ',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.montserrat(color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

class _HeroImageCard extends StatelessWidget {
  final String imageAsset;
  final String mode;
  final double width;
  final double height;

  const _HeroImageCard({
    required this.imageAsset,
    required this.mode,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
