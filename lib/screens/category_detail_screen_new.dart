import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import '../constants/app_colors.dart';
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
    required this.songSelection,
  });
}

class JudgingCriterion {
  final String title;
  final String description;

  const JudgingCriterion({required this.title, required this.description});
}

class Awards {
  final List<String> prizes;

  const Awards({required this.prizes});
}

class Voting {
  final String type;
  final String deadline;
  final String platform;
  final List<String> notes;

  const Voting({
    required this.type,
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
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF0A0A0A),
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
            colors: [Color(0xFF1A1A2E), Color(0xFF0A0A0A)],
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
            SliverToBoxAdapter(child: _CategoryInfoSection(data: widget.data)),

            // Registration Section
            SliverToBoxAdapter(child: _RegistrationSection(data: widget.data)),
          ],
        ),
      ),
    );
  }
}

// Hero Section - Clean and minimal like IFP
class _HeroSection extends StatelessWidget {
  final CategoryDetailData data;
  final String imageAsset;

  const _HeroSection({required this.data, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A0A0A).withOpacity(0.8),
                  ],
                ),
              ),
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          // Overlay Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A0A0A).withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Column(
                children: [
                  Text(
                    data.categoryName.toUpperCase(),
                    style: GoogleFonts.orbitron(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Competition Challenge',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: Colors.white70,
                      letterSpacing: 1,
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
    return Container(
      height: 80,
      color: const Color(0xFF1A1A2E),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              -_controller.value * MediaQuery.of(context).size.width * 2,
              0,
            ),
            child: Row(
              children: List.generate(6, (index) => _buildBannerText()),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBannerText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bannerItem('REGISTER NOW'),
          _bannerItem('✦'),
          _bannerItem('LIMITED SEATS'),
          _bannerItem('✦'),
          _bannerItem('EXCITING PRIZES'),
          _bannerItem('✦'),
        ],
      ),
    );
  }

  Widget _bannerItem(String text) {
    return Text(
      text,
      style: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: 2,
      ),
    );
  }
}

// IFP Style Timeline for Entry Format
class _IFPStyleTimeline extends StatelessWidget {
  final EntryFormat format;

  const _IFPStyleTimeline({required this.format});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0F0F23), Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: Column(
        children: [
          // Header
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 30),
                    const SizedBox(width: 16),
                    Text(
                      'ENTRY FORMAT',
                      style: GoogleFonts.orbitron(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.star, color: Colors.amber, size: 30),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose the format that suits your vision',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white60,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Timeline Cards Grid
          Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Wrap(
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
                ),
                _buildTimelineCard(
                  icon: Icons.schedule,
                  title: 'DURATION',
                  value: format.duration,
                  color: Colors.orange,
                  delay: 500,
                ),
                _buildTimelineCard(
                  icon: Icons.language,
                  title: 'LANGUAGE',
                  value: format.language,
                  color: Colors.purple,
                  delay: 700,
                ),
                _buildTimelineCard(
                  icon: Icons.palette,
                  title: 'STYLE',
                  value: format.style,
                  color: Colors.green,
                  delay: 900,
                ),
                _buildTimelineCard(
                  icon: Icons.upload,
                  title: 'SUBMISSION',
                  value: format.submissionFormat,
                  color: Colors.red,
                  delay: 1100,
                ),
              ],
            ),
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
  }) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
      child: Container(
        width: 280,
        height: 180,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          FadeInDown(
            child: Text(
              'COMPETITION DETAILS',
              style: GoogleFonts.orbitron(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 40),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 20,
            children: [
              _buildInfoCard('MODE', data.mode, Icons.public, Colors.blue),
              _buildInfoCard(
                'PARTICIPANTS',
                data.participants,
                Icons.people,
                Colors.green,
              ),
              _buildInfoCard(
                'TIMELINE',
                data.timeline,
                Icons.schedule,
                Colors.orange,
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
  ) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.orbitron(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: color,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
            ),
            child: Text(
              'REGISTER NOW',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
