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
                            child: FadeInUp(
                              duration: const Duration(milliseconds: 700),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.28),
                                      blurRadius: 28,
                                      offset: const Offset(0, 14),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white24,
                                    width: 1,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    SizedBox(
                                      height: cardH,
                                      width: cardW,
                                      child: Image.asset(
                                        widget.imageAsset,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    Container(
                                      height: cardH * 0.45,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Color.fromARGB(180, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                              border: Border.all(
                                                color: Colors.white24,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.wifi,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  widget.data.mode,
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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

                      // Content blocks with icons and glass look
                      _CardBlock(
                        title: 'Entry Format',
                        icon: Icons.library_music,
                        child: _EntryFormatBlock(widget.data.entryFormat),
                      ),
                      if (widget.data.entryFormat.songSelection.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        _CardBlock(
                          title: 'Suggested Songs',
                          icon: Icons.queue_music,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.data.entryFormat.songSelection
                                .map(
                                  (s) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      '• $s',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Rules',
                        icon: Icons.rule,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.data.rules
                              .map(
                                (r) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    '• $r',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Judging Criteria',
                        icon: Icons.assessment,
                        child: Column(
                          children: widget.data.judgingCriteria
                              .map(
                                (c) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        c.parameter,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${c.weightage}%',
                                        style: GoogleFonts.montserrat(),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Awards',
                        icon: Icons.emoji_events,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Winner: ${widget.data.awards.winner}',
                              style: GoogleFonts.montserrat(),
                            ),
                            Text(
                              'Runner Up: ${widget.data.awards.runnerUp}',
                              style: GoogleFonts.montserrat(),
                            ),
                            Text(
                              'Audience Choice: ${widget.data.awards.audienceChoice}',
                              style: GoogleFonts.montserrat(),
                            ),
                            Text(
                              'Top College: ${widget.data.awards.topCollege}',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Voting',
                        icon: Icons.how_to_vote,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deadline: ${widget.data.voting.deadline.toLocal()}',
                              style: GoogleFonts.montserrat(),
                            ),
                            Text(
                              'Platform: ${widget.data.voting.platform}',
                              style: GoogleFonts.montserrat(),
                            ),
                            Text(
                              'Notes: ${widget.data.voting.notes}',
                              style: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Jury Panel',
                        icon: Icons.gavel,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.data.juryPanel
                              .map(
                                (j) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    '• $j',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _CardBlock(
                        title: 'Important Notes',
                        icon: Icons.info_outline,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.data.importantNotes
                              .map(
                                (n) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    '• $n',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
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
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black.withOpacity(0.08),
                    border: Border.all(color: Colors.black12),
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
                        backgroundColor: Colors.yellow[800],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w800),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
