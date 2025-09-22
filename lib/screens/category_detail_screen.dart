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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassHeader(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/bg.jpg',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Image.asset(
              'lib/assets/Left-decoration-1024x751.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            width: MediaQuery.of(context).size.width * 0.55,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Image.asset(
              'lib/assets/Right-decoration-1024x751.png',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                16,
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

                      // Content blocks with icons and glass look - Animated sections
                      SlideInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 200),
                        child: _CardBlock(
                          title: 'Entry Format',
                          icon: Icons.library_music,
                          child: _EntryFormatBlock(widget.data.entryFormat),
                        ),
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

class _EntryFormatBlock extends StatelessWidget {
  final EntryFormat fmt;
  const _EntryFormatBlock(this.fmt);
  @override
  Widget build(BuildContext context) {
    TextStyle s() => GoogleFonts.montserrat(color: Colors.black87);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Type: ${fmt.type}', style: s()),
        Text('Duration: ${fmt.duration}', style: s()),
        Text('Language: ${fmt.language}', style: s()),
        Text('Style: ${fmt.style}', style: s()),
        Text('Submission: ${fmt.submissionFormat}', style: s()),
      ],
    );
  }
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
