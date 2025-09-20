import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/app_colors.dart';
import '../widgets/rules_dialog.dart';
import '../widgets/glass_header.dart';
import '../widgets/parallax_section.dart';
import 'registration/phone_screen.dart';
import 'category_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // No video background; gradient used instead
  final PageController _pageController = PageController();
  int _bgIndex = 0;
  // Controller for the bottom strip auto-scroll
  final ScrollController _stripCtrl = ScrollController();
  Timer? _stripTimer;

  @override
  void dispose() {
    _stripTimer?.cancel();
    _stripCtrl.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Removed unused _buildModernRunningText to satisfy analyzer

  // Removed unused _buildRunningTextItem helper

  // Registration marquee strips – matches the provided design: a white top row
  // on transparent background and a bold black-on-yellow bottom row.
  Widget _buildRegistrationMarquees(bool isWide, bool isShort) {
    final topStyle = GoogleFonts.londrinaOutline(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
      fontSize: isShort ? 20 : (isWide ? 36 : 14),
    );

    final bottomStyle = GoogleFonts.bebasNeue(
      color: Colors.black,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.8,
      fontSize: isShort ? 13 : (isWide ? 36 : 16),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top thin strip
        FadeInLeft(
          duration: const Duration(milliseconds: 800),
          child: _AutoScrollTextStrip(
            height: isShort ? 30 : 38,
            background: Colors.black.withOpacity(0.0),
            textStyle: topStyle,
            text: '2,33,314 FILMMAKERS FROM 42 COUNTRIES IN 14 YEARS',
            separator: ' ✧ ',
            reverse: false,
            speed: 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),

        SizedBox(height: isShort ? 10 : 16),

        // Bottom bold yellow strip
        FadeInRight(
          duration: const Duration(milliseconds: 800),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _AutoScrollTextStrip(
              height: isShort ? 42 : 50,
              background: Colors.yellow,
              textStyle: bottomStyle,
              text: 'LAST DATE TO REGISTER - OCTOBER 9TH, 2025',
              separator: ' ♦ ',
              reverse: true,
              speed: 1.0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
          ),
        ),
      ],
    );
  }

  // Continuous auto-scrolling strip of cards (cat1.png) repeated 10 times.
  Widget _buildCatCarousel(bool isWide, bool isShort) {
    final double cardHeight = isShort ? 540 : (isWide ? 240 : 180);
    final double itemWidth = isWide ? 240 : 170; // show multiple at once
    final assets = [
      'lib/assets/engineering.png',
      'lib/assets/medical.png',
      'lib/assets/law.png',
      'lib/assets/arts.png',
    ];
    return _AutoScrollCardStrip(
      height: cardHeight,
      itemWidth: itemWidth,
      itemCount: assets.length,
      assets: assets,
      radius: 18,
      itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      speed: 1.2,
    );
  }

  // Static cards for Section 3 (singing, photo, acting)
  Widget _buildFeatureCards(bool isWide, bool isShort) {
    // Slightly smaller on short/mobile screens to avoid vertical overflow
    final double cardHeight = isShort ? 120 : (isWide ? 320 : 240);
    final double cardWidth = isWide ? 360 : double.infinity;
    final double gap = isWide ? 8 : 0;

    void openSinging() {
      final data = CategoryDetailData(
        categoryName: 'Singing',
        mode: '100% Online',
        participants: 'College students across Tamil Nadu',
        timeline: '30 Days',
        entryFormat: EntryFormat(
          type: 'Solo Singing',
          duration: 'Maximum 2 minutes per performance',
          language: 'Tamil',
          style: 'Original compositions or Cover songs allowed',
          submissionFormat: 'Video',
          songSelection: const [
            'Ennavale Adi Ennavale – Kadhalan',
            'Unnai Kaanadhu Naan – Vishwaroopam',
            'Kanne Kalaimane – Moondram Pirai',
            'Mandram Vandha – Mouna Ragam',
            'Chinna Chinna Vannakuyil – Mouna Ragam',
            'Ilaya Nila – Payanangal Mudivathillai',
            'Malargale Malargale – Love Birds',
            'Putham Pudhu Kaalai – Alaigal Oivathillai',
            'Paadariyen Padippariyen – Sindhu Bhairavi',
            'Raja Raja Chozhan – Rettai Vaal Kuruvi',
            'Tum Tum – Enemy',
            'Vaathi Coming – Master',
            'Naan Pizhai – Kaathuvaakula Rendu Kaadhal',
            'Mallipoo – Vendhu Thanindhathu Kaadu',
            'Aalaporan Tamizhan – Mersal',
            'So Baby – Doctor',
            'Kaarkuzhal Kadavaiye – Karnan',
            'Aval – Manithan',
            'Adiye – Bachelor',
            'Vaa Vaathi – Vaathi',
          ],
        ),
        rules: const [
          'One Entry Per Participant',
          'Fresh Recordings Only',
          'No Auto-tuning or Voice Modifications',
          'Background Tracks Allowed',
          'Songs with hate speech, explicit content, or plagiarism will be disqualified',
          'Face and voice must match; no lip-syncing',
          'No bots or fake accounts for audience votes',
        ],
        judgingCriteria: const [
          JudgingCriterion('Vocal Quality', 30),
          JudgingCriterion('Pitch & Rhythm', 25),
          JudgingCriterion('Expression & Emotion', 20),
          JudgingCriterion('Creativity & Song Choice', 15),
          JudgingCriterion('Overall Presentation', 10),
        ],
        awards: const Awards(
          winner:
              '20,000 INR Cash Prize + Trophy + Certificate + Digital Badge + Social Media Feature',
          runnerUp: '5,000 INR Cash Prize + Certificate + Digital Badge',
          audienceChoice: '2,500 INR Cash Prize + Certificate + Digital Badge',
          topCollege: 'College-level Trophy for highest participation',
        ),
        voting: Voting(
          deadline: DateTime(2025, 11, 5, 23, 59, 59),
          platform: 'College Thiruvizha Website',
          notes: 'One vote per entry per user',
        ),
        juryPanel: const [
          'Playback Singers',
          'Music Directors',
          'Creedom Pro Mentors',
        ],
        importantNotes: const [
          'Rights for winning entries remain with participants',
          'College Thiruvizha may showcase entries on official platforms',
          'Certificates will be issued digitally; trophies & prizes shipped to colleges',
        ],
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailScreen(
            data: data,
            imageAsset: 'lib/assets/singing_card.png',
          ),
        ),
      );
    }

    void openActing() {
      final data = CategoryDetailData(
        categoryName: 'Acting',
        mode: '100% Online',
        participants: 'College students across Tamil Nadu',
        timeline: '30 Days',
        entryFormat: const EntryFormat(
          type: 'Solo Acting',
          duration: 'Maximum 2 minutes per performance',
          language: 'Tamil/English',
          style: 'Monologue or Dialogue',
          submissionFormat: 'Video',
        ),
        rules: const [
          'One Entry Per Participant',
          'Original performances preferred',
          'No explicit or hateful content',
        ],
        judgingCriteria: const [
          JudgingCriterion('Expression & Emotion', 30),
          JudgingCriterion('Dialogue Delivery', 25),
          JudgingCriterion('Originality', 20),
          JudgingCriterion('Stage Presence', 15),
          JudgingCriterion('Overall Presentation', 10),
        ],
        awards: const Awards(
          winner: 'TBA',
          runnerUp: 'TBA',
          audienceChoice: 'TBA',
          topCollege: 'TBA',
        ),
        voting: Voting(
          deadline: DateTime(2025, 11, 5, 23, 59, 59),
          platform: 'College Thiruvizha Website',
          notes: 'One vote per entry per user',
        ),
        juryPanel: const ['Film Artists', 'Directors', 'Creedom Pro Mentors'],
        importantNotes: const ['Details to be announced.'],
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailScreen(
            data: data,
            imageAsset: 'lib/assets/acting_card.png',
          ),
        ),
      );
    }

    void openPhoto() {
      final data = CategoryDetailData(
        categoryName: 'Photography',
        mode: '100% Online',
        participants: 'College students across Tamil Nadu',
        timeline: '30 Days',
        entryFormat: const EntryFormat(
          type: 'Photography',
          duration: 'Single submission',
          language: '-',
          style: 'Theme-based',
          submissionFormat: 'Image',
        ),
        rules: const [
          'One Entry Per Participant',
          'Original photos only',
          'Basic color correction allowed; no heavy manipulation',
        ],
        judgingCriteria: const [
          JudgingCriterion('Composition', 30),
          JudgingCriterion('Creativity', 25),
          JudgingCriterion('Lighting & Focus', 20),
          JudgingCriterion('Theme Relevance', 15),
          JudgingCriterion('Overall Impact', 10),
        ],
        awards: const Awards(
          winner: 'TBA',
          runnerUp: 'TBA',
          audienceChoice: 'TBA',
          topCollege: 'TBA',
        ),
        voting: Voting(
          deadline: DateTime(2025, 11, 5, 23, 59, 59),
          platform: 'College Thiruvizha Website',
          notes: 'One vote per entry per user',
        ),
        juryPanel: const ['Professional Photographers', 'Artists'],
        importantNotes: const ['Details to be announced.'],
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryDetailScreen(
            data: data,
            imageAsset: 'lib/assets/photo_card.png',
          ),
        ),
      );
    }

    if (isWide) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: cardWidth,
            child: GestureDetector(
              onTap: openSinging,
              child: _Section3Card(
                asset: 'lib/assets/singing_card.png',
                height: cardHeight,
              ),
            ),
          ),
          SizedBox(width: gap),
          SizedBox(
            width: cardWidth,
            child: GestureDetector(
              onTap: openPhoto,
              child: _Section3Card(
                asset: 'lib/assets/photo_card.png',
                height: cardHeight,
              ),
            ),
          ),
          SizedBox(width: gap),
          SizedBox(
            width: cardWidth,
            child: GestureDetector(
              onTap: openActing,
              child: _Section3Card(
                asset: 'lib/assets/acting_card.png',
                height: cardHeight,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: openSinging,
          child: _Section3Card(
            asset: 'lib/assets/singing_card.png',
            height: cardHeight,
          ),
        ),
        SizedBox(height: gap),
        GestureDetector(
          onTap: openPhoto,
          child: _Section3Card(
            asset: 'lib/assets/photo_card.png',
            height: cardHeight,
          ),
        ),
        SizedBox(height: gap),
        GestureDetector(
          onTap: openActing,
          child: _Section3Card(
            asset: 'lib/assets/acting_card.png',
            height: cardHeight,
          ),
        ),
      ],
    );
  }

  // Removed unused _showInfoDialog helper

  // Removed mobile menu bottom sheet per new design

  @override
  Widget build(BuildContext context) {
    // no-op
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const GlassHeader(),
      body: Stack(
        children: [
          // Main background - bg.jpg image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/bg.jpg',
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          // Left decoration background
          Positioned(
            left: 0,
            top: 0,
            width: _bgIndex == 0 ? MediaQuery.of(context).size.width * 0.55 : 0,
            height: _bgIndex == 0
                ? MediaQuery.of(context).size.height * 0.55
                : 0,
            child: FadeInLeft(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(
                'lib/assets/Left-decoration-1024x751.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // Right decoration background
          Positioned(
            right: 0,
            top: 0,
            width: _bgIndex == 0 ? MediaQuery.of(context).size.width * 0.55 : 0,
            height: _bgIndex == 0
                ? MediaQuery.of(context).size.height * 0.55
                : 0,
            child: FadeInRight(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(
                'lib/assets/Right-decoration-1024x751.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // Top marquee bar (running words)
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: kToolbarHeight - 40,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //       child: RunningWordsBar(
          //         height: 36,
          //         background: Colors.black.withOpacity(0.35),
          //         borderColor: Colors.white24,
          //         textStyle: GoogleFonts.montserrat(
          //           color: Colors.white,
          //           fontSize: 13,
          //           fontWeight: FontWeight.w700,
          //           letterSpacing: 1.0,
          //         ),
          //         phrases: const [
          //           'Registrations Open Now',
          //           'Early Bird Ends Soon',
          //           'Perform Live On Stage',
          //           'Win Exciting Prizes',
          //           'Jury To Be Announced',
          //           'Submit Your Best Track',
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // // Full-screen vertical pager: one section per scroll
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _bgIndex = i),
              scrollDirection: Axis.vertical,
              children: [
                // Section 1: Hero + CTAs
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 24.0 : 120.0)
                        : (isShort ? 8.0 : 72.0);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: isWide ? 500 : 280,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // 2X.png card (background)
                                    Positioned(
                                      child: Image.asset(
                                        'lib/assets/2X.png',
                                        fit: BoxFit.contain,
                                        height: isWide
                                            ? 400
                                            : MediaQuery.of(
                                                    context,
                                                  ).size.width <
                                                  600
                                            ? 260
                                            : 200,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    // spec.png above (overlapping)
                                    // Positioned(
                                    //   top: 0,
                                    //   child: Image.asset(
                                    //     'lib/assets/spec.png',
                                    //     fit: BoxFit.contain,
                                    //     height: isWide
                                    //         ? 200
                                    //         : MediaQuery.of(
                                    //                 context,
                                    //               ).size.width <
                                    //               600
                                    //         ? 80
                                    //         : 120,
                                    //     filterQuality: FilterQuality.high,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: isShort ? 8 : 16),
                              Transform.translate(
                                offset: const Offset(0, -64),
                                child: _CountdownBand(
                                  target: DateTime(2025, 10, 9),
                                  darkOnLight: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Section 2: Manifesto (bold lines before "Who can participate")
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 24.0 : 120.0)
                        : (isShort ? 8.0 : 72.0);

                    TextStyle lineStyle(double base) => GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      height: 0.95,
                      fontSize: isShort
                          ? (base * 0.7)
                          : (isWide
                                ? base
                                : (MediaQuery.of(context).size.width < 600
                                      ? base * 0.8
                                      : base * 0.9)),
                    );

                    final lines = <String>[
                      'WE MADE A STAGE FOR THE ONES WHO DREAM',
                      'THE VOICES THAT SOAR',
                      'THE BEATS THAT MOVE HEARTS',
                      'BIGGER • BOLDER • BETTER',
                      'THE TALENTS THAT DARE',
                      'AND THE ONES WHO WILL DEFINE THE SOUND OF TOMORROW',
                    ];

                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Staggered bold lines
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                child: Text(
                                  lines[0],
                                  textAlign: TextAlign.center,
                                  style: lineStyle(72),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 80),
                                child: Text(
                                  lines[1],
                                  textAlign: TextAlign.center,
                                  style: lineStyle(68),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 140),
                                child: Text(
                                  lines[2],
                                  textAlign: TextAlign.center,
                                  style: lineStyle(64),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 200),
                                child: Text(
                                  lines[3],
                                  textAlign: TextAlign.center,
                                  style: lineStyle(
                                    72,
                                  ).copyWith(color: Colors.yellow),
                                ),
                              ),
                              const SizedBox(height: 8),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 260),
                                child: Text(
                                  lines[4],
                                  textAlign: TextAlign.center,
                                  style: lineStyle(68),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Section 3: Who can participate + carousel
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 24.0 : 120.0)
                        : (isShort ? 8.0 : 72.0);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 5, 16, bottomPad),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // SizedBox(height: isShort ? 4 : 32),
                            // Inside-to-outside animation for title
                            FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: SlideInUp(
                                duration: const Duration(milliseconds: 800),
                                child: Text(
                                  'WHO CAN PARTICIPATE',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                    fontSize: isShort
                                        ? 28
                                        : (MediaQuery.of(context).size.width <
                                                  600
                                              ? 36
                                              : 48),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            // Running text like the provided image (two broad strips)
                            _buildRegistrationMarquees(isWide, isShort),
                            const SizedBox(height: 20),
                            // Carousel of category cards (cat1.png repeated 10 times)
                            _buildCatCarousel(isWide, isShort),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Section 4: About
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 80.0 : 160.0)
                        : (isShort ? 80.0 : 180.0);
                    // final availableHeight = h - 16 - bottomPad;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: Builder(
                          builder: (_) {
                            final header = Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SectionTitle('CATEGORY'),
                                SizedBox(height: 12),
                                SectionText(
                                  'Rhythm & Waves Fest is a celebration of music, performance, and creativity.\n',
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                            final cardsWide = _buildFeatureCards(
                              isWide,
                              isShort,
                            );
                            // On mobile/narrow screens, keep header fixed and show a horizontal auto carousel for the cards
                            if (!isWide) {
                              final double cardH = isShort ? 120 : 240;
                              final double itemW = (constraints.maxWidth - 64)
                                  .clamp(220.0, 480.0);

                              // Local open handlers (same as in _buildFeatureCards)
                              void openSinging() {
                                final data = CategoryDetailData(
                                  categoryName: 'Singing',
                                  mode: '100% Online',
                                  participants:
                                      'College students across Tamil Nadu',
                                  timeline: '30 Days',
                                  entryFormat: EntryFormat(
                                    type: 'Solo Singing',
                                    duration:
                                        'Maximum 2 minutes per performance',
                                    language: 'Tamil',
                                    style:
                                        'Original compositions or Cover songs allowed',
                                    submissionFormat: 'Video',
                                    songSelection: const [
                                      'Ennavale Adi Ennavale – Kadhalan',
                                      'Unnai Kaanadhu Naan – Vishwaroopam',
                                      'Kanne Kalaimane – Moondram Pirai',
                                      'Mandram Vandha – Mouna Ragam',
                                      'Chinna Chinna Vannakuyil – Mouna Ragam',
                                      'Ilaya Nila – Payanangal Mudivathillai',
                                      'Malargale Malargale – Love Birds',
                                      'Putham Pudhu Kaalai – Alaigal Oivathillai',
                                      'Paadariyen Padippariyen – Sindhu Bhairavi',
                                      'Raja Raja Chozhan – Rettai Vaal Kuruvi',
                                      'Tum Tum – Enemy',
                                      'Vaathi Coming – Master',
                                      'Naan Pizhai – Kaathuvaakula Rendu Kaadhal',
                                      'Mallipoo – Vendhu Thanindhathu Kaadu',
                                      'Aalaporan Tamizhan – Mersal',
                                      'So Baby – Doctor',
                                      'Kaarkuzhal Kadavaiye – Karnan',
                                      'Aval – Manithan',
                                      'Adiye – Bachelor',
                                      'Vaa Vaathi – Vaathi',
                                    ],
                                  ),
                                  rules: const [
                                    'One Entry Per Participant',
                                    'Fresh Recordings Only',
                                    'No Auto-tuning or Voice Modifications',
                                    'Background Tracks Allowed',
                                    'Songs with hate speech, explicit content, or plagiarism will be disqualified',
                                    'Face and voice must match; no lip-syncing',
                                    'No bots or fake accounts for audience votes',
                                  ],
                                  judgingCriteria: const [
                                    JudgingCriterion('Vocal Quality', 30),
                                    JudgingCriterion('Pitch & Rhythm', 25),
                                    JudgingCriterion(
                                      'Expression & Emotion',
                                      20,
                                    ),
                                    JudgingCriterion(
                                      'Creativity & Song Choice',
                                      15,
                                    ),
                                    JudgingCriterion(
                                      'Overall Presentation',
                                      10,
                                    ),
                                  ],
                                  awards: const Awards(
                                    winner:
                                        '20,000 INR Cash Prize + Trophy + Certificate + Digital Badge + Social Media Feature',
                                    runnerUp:
                                        '5,000 INR Cash Prize + Certificate + Digital Badge',
                                    audienceChoice:
                                        '2,500 INR Cash Prize + Certificate + Digital Badge',
                                    topCollege:
                                        'College-level Trophy for highest participation',
                                  ),
                                  voting: Voting(
                                    deadline: DateTime(2025, 11, 5, 23, 59, 59),
                                    platform: 'College Thiruvizha Website',
                                    notes: 'One vote per entry per user',
                                  ),
                                  juryPanel: const [
                                    'Playback Singers',
                                    'Music Directors',
                                    'Creedom Pro Mentors',
                                  ],
                                  importantNotes: const [
                                    'Rights for winning entries remain with participants',
                                    'College Thiruvizha may showcase entries on official platforms',
                                    'Certificates will be issued digitally; trophies & prizes shipped to colleges',
                                  ],
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CategoryDetailScreen(
                                      data: data,
                                      imageAsset: 'lib/assets/singing_card.png',
                                    ),
                                  ),
                                );
                              }

                              void openPhoto() {
                                final data = CategoryDetailData(
                                  categoryName: 'Photography',
                                  mode: '100% Online',
                                  participants:
                                      'College students across Tamil Nadu',
                                  timeline: '30 Days',
                                  entryFormat: const EntryFormat(
                                    type: 'Photography',
                                    duration: 'Single submission',
                                    language: '-',
                                    style: 'Theme-based',
                                    submissionFormat: 'Image',
                                  ),
                                  rules: const [
                                    'One Entry Per Participant',
                                    'Original photos only',
                                    'Basic color correction allowed; no heavy manipulation',
                                  ],
                                  judgingCriteria: const [
                                    JudgingCriterion('Composition', 30),
                                    JudgingCriterion('Creativity', 25),
                                    JudgingCriterion('Lighting & Focus', 20),
                                    JudgingCriterion('Theme Relevance', 15),
                                    JudgingCriterion('Overall Impact', 10),
                                  ],
                                  awards: const Awards(
                                    winner: 'TBA',
                                    runnerUp: 'TBA',
                                    audienceChoice: 'TBA',
                                    topCollege: 'TBA',
                                  ),
                                  voting: Voting(
                                    deadline: DateTime(2025, 11, 5, 23, 59, 59),
                                    platform: 'College Thiruvizha Website',
                                    notes: 'One vote per entry per user',
                                  ),
                                  juryPanel: const [
                                    'Professional Photographers',
                                    'Artists',
                                  ],
                                  importantNotes: const [
                                    'Details to be announced.',
                                  ],
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CategoryDetailScreen(
                                      data: data,
                                      imageAsset: 'lib/assets/photo_card.png',
                                    ),
                                  ),
                                );
                              }

                              void openActing() {
                                final data = CategoryDetailData(
                                  categoryName: 'Acting',
                                  mode: '100% Online',
                                  participants:
                                      'College students across Tamil Nadu',
                                  timeline: '30 Days',
                                  entryFormat: const EntryFormat(
                                    type: 'Solo Acting',
                                    duration:
                                        'Maximum 2 minutes per performance',
                                    language: 'Tamil/English',
                                    style: 'Monologue or Dialogue',
                                    submissionFormat: 'Video',
                                  ),
                                  rules: const [
                                    'One Entry Per Participant',
                                    'Original performances preferred',
                                    'No explicit or hateful content',
                                  ],
                                  judgingCriteria: const [
                                    JudgingCriterion(
                                      'Expression & Emotion',
                                      30,
                                    ),
                                    JudgingCriterion('Dialogue Delivery', 25),
                                    JudgingCriterion('Originality', 20),
                                    JudgingCriterion('Stage Presence', 15),
                                    JudgingCriterion(
                                      'Overall Presentation',
                                      10,
                                    ),
                                  ],
                                  awards: const Awards(
                                    winner: 'TBA',
                                    runnerUp: 'TBA',
                                    audienceChoice: 'TBA',
                                    topCollege: 'TBA',
                                  ),
                                  voting: Voting(
                                    deadline: DateTime(2025, 11, 5, 23, 59, 59),
                                    platform: 'College Thiruvizha Website',
                                    notes: 'One vote per entry per user',
                                  ),
                                  juryPanel: const [
                                    'Film Artists',
                                    'Directors',
                                    'Creedom Pro Mentors',
                                  ],
                                  importantNotes: const [
                                    'Details to be announced.',
                                  ],
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => CategoryDetailScreen(
                                      data: data,
                                      imageAsset: 'lib/assets/acting_card.png',
                                    ),
                                  ),
                                );
                              }

                              final items = [
                                _CategoryCardSpec(
                                  'lib/assets/singing_card.png',
                                  cardH,
                                  openSinging,
                                ),
                                _CategoryCardSpec(
                                  'lib/assets/photo_card.png',
                                  cardH,
                                  openPhoto,
                                ),
                                _CategoryCardSpec(
                                  'lib/assets/acting_card.png',
                                  cardH,
                                  openActing,
                                ),
                              ];

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  header,
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: cardH,
                                    child: _AutoHorizontalCategoryCards(
                                      height: cardH,
                                      itemWidth: itemW,
                                      speed: 3.0,
                                      items: items,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap a card to know more',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white70,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                header,
                                const SizedBox(height: 8),
                                cardsWide,
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),

                // Section 5: Flashbacks (ctEvents)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 80.0 : 160.0)
                        : (isShort ? 64.0 : 120.0);

                    // Assets from lib/assets/ctEvents
                    const ctEventsAssets = [
                      'lib/assets/ctEvents/download.png',
                      'lib/assets/ctEvents/download (1).png',
                      'lib/assets/ctEvents/past_7.4c458172ad4bc461cfae.png',
                      'lib/assets/ctEvents/past_9.edbe9c144008f2ca5ad1.png',
                      'lib/assets/ctEvents/past_10.437b7a9c511d8d650b42.png',
                      'lib/assets/ctEvents/past_11.151f2d5db6fadf8c5d89.png',
                      'lib/assets/ctEvents/past_12.599d30a9dda6becad387.png',
                      'lib/assets/ctEvents/past_13.2e63da7d68cb5536d6a9.png',
                      'lib/assets/ctEvents/past_14.7b2dc2209af480cacead.png',
                    ];

                    final rowHeight = isWide ? 140.0 : (isShort ? 80.0 : 110.0);
                    final itemWidth = isWide ? 240.0 : 200.0;

                    Widget row({required bool reverse, required double speed}) {
                      return _AutoScrollCardStrip(
                        height: rowHeight,
                        itemWidth: itemWidth,
                        itemCount: ctEventsAssets.length,
                        assets: ctEventsAssets,
                        radius: 14,
                        itemMargin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        speed: speed,
                        reverse: reverse,
                        enableHover: true,
                        hoverScale: 1.05,
                        hoverDuration: const Duration(milliseconds: 180),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 650),
                              child: SectionTitle('NOW SOME FLASHBACKS'),
                            ),
                            const SizedBox(height: 10),
                            FadeInUp(
                              duration: const Duration(milliseconds: 650),
                              delay: const Duration(milliseconds: 120),
                              child: SectionText(
                                'This is not our first time. And definitely not the last.',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Three alternating-direction rows with staggered entrance
                            FadeInUp(
                              duration: const Duration(milliseconds: 700),
                              child: row(reverse: false, speed: 0.9),
                            ),
                            const SizedBox(height: 10),
                            FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: const Duration(milliseconds: 100),
                              child: row(reverse: true, speed: 1.1),
                            ),
                            const SizedBox(height: 10),
                            // FadeInUp(
                            //   duration: const Duration(milliseconds: 900),
                            //   delay: const Duration(milliseconds: 180),
                            //   child: row(reverse: false, speed: 1.0),
                            // ),
                            // const SizedBox(height: 20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 700),
                              delay: const Duration(milliseconds: 220),
                              child: Text(
                                'this time exclusively for colleges in tamilnadu',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white70,
                                  fontSize: isWide ? 16 : 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Section 6: About Us
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 80.0 : 160.0)
                        : (isShort ? 64.0 : 120.0);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1000),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FadeInDown(
                                duration: const Duration(milliseconds: 700),
                                child: SectionTitle('ABOUT US'),
                              ),
                              const SizedBox(height: 12),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 120),
                                child: SectionText(
                                  'College Thiruvizha is a creator-first festival bringing talents from across Tamil Nadu together.\n'
                                  'We celebrate voices, visuals, and performances with a platform that is bigger, bolder, and better.',
                                ),
                              ),
                              const SizedBox(height: 16),
                              FadeInUp(
                                duration: const Duration(milliseconds: 700),
                                delay: const Duration(milliseconds: 200),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    _InfoPill(
                                      icon: Icons.music_note,
                                      label: 'Music & Performance',
                                    ),
                                    _InfoPill(
                                      icon: Icons.camera_alt,
                                      label: 'Photo & Visuals',
                                    ),
                                    _InfoPill(
                                      icon: Icons.people_alt,
                                      label: 'Community & Collaboration',
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

                // Section 7: Friends (Sponsors)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 80.0 : 160.0)
                        : (isShort ? 64.0 : 120.0);

                    // Use sponser.png in an auto-scrolling carousel
                    const sponsorAssets = ['lib/assets/sponser.png'];

                    final rowHeight = isWide ? 120.0 : (isShort ? 80.0 : 100.0);
                    final itemWidth = isWide ? 240.0 : 200.0;

                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 650),
                              child: SectionTitle('FRIENDS'),
                            ),
                            const SizedBox(height: 10),
                            FadeInUp(
                              duration: const Duration(milliseconds: 650),
                              delay: const Duration(milliseconds: 120),
                              child: SectionText(
                                'Made possible by our partners',
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 700),
                              child: _AutoScrollCardStrip(
                                height: rowHeight,
                                itemWidth: itemWidth,
                                itemCount: sponsorAssets.length,
                                assets: sponsorAssets,
                                radius: 14,
                                itemMargin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                speed: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Section 8: Stay Connected & Contact
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 900;
                    final h = constraints.maxHeight;
                    final isShort = h < 640;
                    final bottomPad = isWide
                        ? (isShort ? 80.0 : 160.0)
                        : (isShort ? 64.0 : 120.0);
                    final iconSize = isWide ? 28.0 : 24.0;

                    Widget circleIcon(IconData icon, Color bg) {
                      return Container(
                        width: iconSize + 20,
                        height: iconSize + 20,
                        decoration: BoxDecoration(
                          color: bg.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: bg.withOpacity(0.3)),
                        ),
                        child: Icon(icon, color: Colors.white, size: iconSize),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPad),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 650),
                              child: SectionTitle('STAY CONNECTED'),
                            ),
                            const SizedBox(height: 14),
                            FadeInUp(
                              duration: const Duration(milliseconds: 650),
                              delay: const Duration(milliseconds: 100),
                              child: Wrap(
                                spacing: 14,
                                runSpacing: 10,
                                alignment: WrapAlignment.center,
                                children: [
                                  circleIcon(
                                    Icons.camera_alt,
                                    Colors.purple,
                                  ), // Instagram
                                  circleIcon(
                                    Icons.facebook,
                                    Colors.blue,
                                  ), // Facebook
                                  circleIcon(
                                    Icons.alternate_email,
                                    Colors.cyan,
                                  ), // Twitter/X
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            FadeInUp(
                              duration: const Duration(milliseconds: 650),
                              delay: const Duration(milliseconds: 160),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SectionText('Have any questions?'),
                                  const SizedBox(height: 10),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // TODO: Hook to contact action (email/whatsapp)
                                    },
                                    icon: const Icon(
                                      Icons.mail,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      'Contact Us',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Bottom looping image background strip (only on Section 1)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _bgIndex == 0 ? 1.0 : 0.0,
                child: _BottomLoopingImageStrip(
                  controller: _stripCtrl,
                  onTickAttach: (timer) => _stripTimer = timer,
                  height: 600,
                  imageAssetPath: 'lib/assets/caro_chennai_new.png',
                  overlayGradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          // Sticky footer overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.0),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 900;

                      final leftGroup = Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // TODO: Hook WhatsApp deep link
                            },
                            icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text('Details On'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('FAQs'),
                          ),
                        ],
                      );

                      final activeFooterIndex = () {
                        // After inserting Manifesto as Section 2, shift mapping by +1 for subsequent sections
                        // New map: 2->DATES, 3->CATEGORIES, 4->PRIZES
                        switch (_bgIndex) {
                          case 2:
                            return 0; // DATES
                          case 3:
                            return 1; // CATEGORIES
                          case 4:
                            return 2; // PRIZES
                          default:
                            return -1; // none
                        }
                      }();

                      final centerMenu = ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Wrap(
                              spacing: 24,
                              children: [
                                _MenuPill(
                                  'DATES',
                                  active: activeFooterIndex == 0,
                                ),
                                _MenuPill(
                                  'CATEGORIES',
                                  active: activeFooterIndex == 1,
                                ),
                                _MenuPill('JURY', active: false),
                                _MenuPill(
                                  'PRIZES',
                                  active: activeFooterIndex == 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                      final rightGroupWide = Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        alignment: WrapAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () => RulesDialog.show(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Rules'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const PhoneScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[800],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      );

                      final rightGroupMobile = Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => RulesDialog.show(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Rules',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const PhoneScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Register Now',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      );

                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: leftGroup,
                              ),
                            ),
                            Expanded(child: Center(child: centerMenu)),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: rightGroupWide,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return rightGroupMobile;
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          // Sponsors/Partners strip above footer (hidden on small screens)
          // Visibility(
          //   visible: MediaQuery.of(context).size.width >= 700,
          //   child: Positioned(
          //     left: 0,
          //     right: 0,
          //     bottom: 88,
          //     child: SafeArea(
          //       bottom: false,
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: _SponsorsStrip(
          //           height: 56,
          //           background: Colors.black.withOpacity(0.3),
          //           borderColor: Colors.white24,
          //           items: const [
          //             _BrandItem('Presented by', Icons.star),
          //             _BrandItem('Powered by', Icons.flash_on),
          //             _BrandItem('Radio Partner', Icons.radio),
          //             _BrandItem('Streaming', Icons.wifi),
          //             _BrandItem('Hospitality', Icons.hotel),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// A lightweight, reusable horizontally auto-scrolling text strip.
class _AutoScrollTextStrip extends StatefulWidget {
  final double height;
  final Color background;
  final TextStyle textStyle;
  final String text;
  final String separator;
  final bool reverse;
  final double speed; // logical pixels per frame (~16ms)
  final EdgeInsetsGeometry padding;

  const _AutoScrollTextStrip({
    required this.height,
    required this.background,
    required this.textStyle,
    required this.text,
    required this.separator,
    required this.reverse,
    required this.speed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  State<_AutoScrollTextStrip> createState() => _AutoScrollTextStripState();
}

class _AutoScrollTextStripState extends State<_AutoScrollTextStrip> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_controller.hasClients) return;
      final max = _controller.position.maxScrollExtent;
      final next = _controller.offset + widget.speed;
      if (next >= max) {
        _controller.jumpTo(0);
      } else {
        _controller.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repeat the pattern many times to ensure continuous scrolling.
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Container(
        color: widget.background,
        child: ListView.builder(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          reverse: widget.reverse,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 500,
          itemBuilder: (_, i) {
            final isSep = i.isOdd;
            final s = isSep ? widget.separator : widget.text;
            return Padding(
              padding: widget.padding,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(s, style: widget.textStyle),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Reusable continuous auto-scrolling card strip for carousels.
class _AutoScrollCardStrip extends StatefulWidget {
  final double height;
  final double itemWidth;
  final int itemCount;
  final List<String>? assets;
  final double radius;
  final EdgeInsetsGeometry itemMargin;
  final double speed; // pixels per frame
  final bool reverse; // scroll in opposite direction
  final bool enableHover; // enable hover scale effect (web/desktop)
  final double hoverScale;
  final Duration hoverDuration;

  const _AutoScrollCardStrip({
    required this.height,
    required this.itemWidth,
    required this.itemCount,
    this.assets,
    required this.radius,
    required this.itemMargin,
    required this.speed,
    this.reverse = false,
    this.enableHover = false,
    this.hoverScale = 1.04,
    this.hoverDuration = const Duration(milliseconds: 180),
  });

  @override
  State<_AutoScrollCardStrip> createState() => _AutoScrollCardStripState();
}

class _AutoScrollCardStripState extends State<_AutoScrollCardStrip> {
  final ScrollController _ctrl = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_ctrl.hasClients) return;
      final max = _ctrl.position.maxScrollExtent;
      final delta = widget.reverse ? -widget.speed : widget.speed;
      final next = _ctrl.offset + delta;
      if (next >= max) {
        _ctrl.jumpTo(0);
      } else if (next <= 0) {
        _ctrl.jumpTo(max);
      } else {
        _ctrl.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseCount = (widget.assets != null && widget.assets!.isNotEmpty)
        ? widget.assets!.length
        : widget.itemCount;
    final totalItems = baseCount * 50; // long loop
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        controller: _ctrl,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: totalItems,
        itemBuilder: (_, i) {
          // Always render same asset for now
          return Container(
            width: widget.itemWidth,
            margin: widget.itemMargin,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: widget.enableHover
                ? _HoverableImageCard(
                    asset: widget.assets![i % widget.assets!.length],
                    hoverScale: widget.hoverScale,
                    duration: widget.hoverDuration,
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        widget.assets![i % widget.assets!.length],
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

// Hoverable image with gentle scale and bottom gradient overlay
class _HoverableImageCard extends StatefulWidget {
  final String asset;
  final double hoverScale;
  final Duration duration;
  const _HoverableImageCard({
    required this.asset,
    required this.hoverScale,
    required this.duration,
  });

  @override
  State<_HoverableImageCard> createState() => _HoverableImageCardState();
}

class _HoverableImageCardState extends State<_HoverableImageCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? widget.hoverScale : 1.0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.asset,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A bottom-fixed strip that auto-scrolls a long rectangular image in a loop.
class _BottomLoopingImageStrip extends StatefulWidget {
  final ScrollController controller;
  final void Function(Timer timer) onTickAttach;
  final double height;
  final String imageAssetPath;
  final LinearGradient? overlayGradient;

  const _BottomLoopingImageStrip({
    required this.controller,
    required this.onTickAttach,
    required this.height,
    required this.imageAssetPath,
    this.overlayGradient,
  });

  @override
  State<_BottomLoopingImageStrip> createState() =>
      _BottomLoopingImageStripState();
}

class _BottomLoopingImageStripState extends State<_BottomLoopingImageStrip> {
  late final ImageProvider _imageProvider;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _imageProvider = AssetImage(widget.imageAssetPath);
    // Precache the image to get its dimensions for tiling
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await precacheImage(_imageProvider, context);
      } catch (_) {}
      if (!mounted) return;
      setState(() => _ready = true);
      // Start gentle auto-scroll
      final t = Timer.periodic(const Duration(milliseconds: 16), (_) {
        if (!widget.controller.hasClients) return;
        final max = widget.controller.position.maxScrollExtent;
        final next = widget.controller.offset + 0.6; // slow pan
        if (next >= max) {
          widget.controller.jumpTo(0);
        } else {
          widget.controller.jumpTo(next);
        }
      });
      widget.onTickAttach(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return SizedBox(height: widget.height);
    }
    return SizedBox(
      height: widget.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ListView.builder(
            controller: widget.controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) =>
                Image(image: _imageProvider, fit: BoxFit.cover),
            itemCount: 1000, // plenty to allow continuous scroll
          ),
          if (widget.overlayGradient != null)
            Container(
              decoration: BoxDecoration(gradient: widget.overlayGradient),
            ),
        ],
      ),
    );
  }
}

// removed unused _MenuText

class _MenuPill extends StatelessWidget {
  final String label;
  final bool active;
  const _MenuPill(this.label, {required this.active});

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

// Simple image card used in Section 3
class _Section3Card extends StatelessWidget {
  final String asset;
  final double height;
  const _Section3Card({required this.asset, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: height,
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

// removed unused _MenuText and _InfoChip helpers to reduce analyzer noise

// Small rounded info pill used in About Us section
class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.accentCyan, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Auto vertical scroller to avoid overflow on short screens, with gentle auto-scroll
class _AutoVerticalScroller extends StatefulWidget {
  final double height;
  final double speed; // pixels per frame
  final Widget child;
  const _AutoVerticalScroller({
    required this.height,
    required this.speed,
    required this.child,
  });

  @override
  State<_AutoVerticalScroller> createState() => _AutoVerticalScrollerState();
}

class _AutoVerticalScrollerState extends State<_AutoVerticalScroller> {
  final ScrollController _ctrl = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_ctrl.hasClients) return;
      final max = _ctrl.position.maxScrollExtent;
      if (max <= 0) return; // nothing to scroll
      final next = _ctrl.offset + widget.speed;
      if (next >= max) {
        _ctrl.jumpTo(0);
      } else {
        _ctrl.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: SingleChildScrollView(
        controller: _ctrl,
        physics: const NeverScrollableScrollPhysics(),
        child: widget.child,
      ),
    );
  }
}

// Simple spec holder for category cards in mobile carousel
class _CategoryCardSpec {
  final String asset;
  final double height;
  final VoidCallback onTap;
  const _CategoryCardSpec(this.asset, this.height, this.onTap);
}

// Auto horizontal scroller for category cards on mobile
class _AutoHorizontalCategoryCards extends StatefulWidget {
  final double height;
  final double itemWidth;
  // Back-compat: previously interpreted as pixels/frame for auto-scroll.
  // Now used to derive default auto-advance interval if autoAdvanceEvery is null.
  final double speed;
  final List<_CategoryCardSpec> items;

  const _AutoHorizontalCategoryCards({
    required this.height,
    required this.itemWidth,
    required this.speed,
    required this.items,
  });

  @override
  State<_AutoHorizontalCategoryCards> createState() =>
      _AutoHorizontalCategoryCardsState();
}

class _AutoHorizontalCategoryCardsState
    extends State<_AutoHorizontalCategoryCards> {
  late PageController _pageController;
  Timer? _autoTimer;
  Timer? _resumeTimer;
  bool _userInteracting = false;
  static const int _kLoopBase = 10000; // large base for infinite like behavior
  double _viewportFraction = 1.0;

  @override
  void initState() {
    super.initState();
    // Start somewhere in the middle to allow both directions.
    _pageController = PageController(
      initialPage: _kLoopBase * (widget.items.length),
      viewportFraction: _viewportFraction,
    );
    _startAuto();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _resumeTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAuto() {
    _autoTimer?.cancel();
    final interval = _deriveIntervalFromSpeed();
    if (interval <= Duration.zero) return;
    _autoTimer = Timer.periodic(interval, (_) {
      if (!mounted || _userInteracting) return;
      if (!_pageController.hasClients) return;
      final current =
          _pageController.page?.round() ?? _pageController.initialPage;
      final next = current + 1;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  Duration _deriveIntervalFromSpeed() {
    // Treat previous "speed" as pixels per frame (~60fps). Compute seconds for one item.
    // time(sec) = itemWidth / (speed * 60 px/sec)
    final pixelsPerSec = widget.speed * 60.0;
    if (pixelsPerSec <= 0) return const Duration(seconds: 4);
    final seconds = (widget.itemWidth / pixelsPerSec).clamp(1.5, 8.0);
    return Duration(milliseconds: (seconds * 1000).round());
  }

  void _pauseForInteraction() {
    _userInteracting = true;
    _autoTimer?.cancel();
    _resumeTimer?.cancel();
  }

  void _scheduleResume() {
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      _userInteracting = false;
      _startAuto();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final fraction = (widget.itemWidth / maxW).clamp(0.5, 1.0);
        // Recreate controller if fraction changed
        if ((fraction - _viewportFraction).abs() > 0.001) {
          final currentPage = _pageController.hasClients
              ? _pageController.page?.round() ?? _pageController.initialPage
              : _pageController.initialPage;
          final old = _pageController;
          _viewportFraction = fraction;
          _pageController = PageController(
            initialPage: currentPage,
            viewportFraction: _viewportFraction,
          );
          // Restart auto timer to use the new controller
          if (!_userInteracting) {
            _startAuto();
          }
          // Dispose old after frame to avoid disrupting current build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            old.dispose();
          });
        }
        return Listener(
          onPointerDown: (_) => _pauseForInteraction(),
          onPointerUp: (_) => _scheduleResume(),
          onPointerCancel: (_) => _scheduleResume(),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (_) {
              // Keep primary controller in sync if needed
              // (we use a separate instance with same initialPage to apply viewportFraction)
            },
            itemBuilder: (_, index) {
              final it = widget.items[index % widget.items.length];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: it.onTap,
                  child: Center(
                    child: SizedBox(
                      height: widget.height,
                      width: widget.itemWidth,
                      child: _Section3Card(asset: it.asset, height: it.height),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _CountdownBand extends StatefulWidget {
  final DateTime target;
  final bool darkOnLight;
  const _CountdownBand({required this.target, this.darkOnLight = false});

  @override
  State<_CountdownBand> createState() => _CountdownBandState();
}

class _CountdownBandState extends State<_CountdownBand> {
  late Duration remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.target.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final diff = widget.target.difference(DateTime.now());
      setState(() => remaining = diff.isNegative ? Duration.zero : diff);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String two(int n) => n.toString().padLeft(2, '0');
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;

    final bool darkOnLight = widget.darkOnLight;
    Widget box(String label, String value) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: darkOnLight
              ? Colors.black.withValues(alpha: 0.08)
              : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: darkOnLight ? Colors.black26 : Colors.white24,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.orbitron(
                color: darkOnLight ? Colors.black : AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.montserrat(
                color: darkOnLight ? Colors.black54 : Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        box('DAYS', two(days)),
        box('HRS', two(hours)),
        box('MIN', two(minutes)),
        box('SEC', two(seconds)),
      ],
    );
  }
}

class _BrandItem {
  final String label;
  final IconData icon;
  const _BrandItem(this.label, this.icon);
}

class _SponsorsStrip extends StatefulWidget {
  final List<_BrandItem> items;
  final double height;
  final Color background;
  final Color borderColor;
  const _SponsorsStrip({
    required this.items,
    required this.height,
    required this.background,
    required this.borderColor,
  });

  @override
  State<_SponsorsStrip> createState() => _SponsorsStripState();
}

class _SponsorsStripState extends State<_SponsorsStrip> {
  final ScrollController _ctrl = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (_) {
      if (!_ctrl.hasClients) return;
      final max = _ctrl.position.maxScrollExtent;
      final next = _ctrl.offset + 1.2;
      if (next >= max) {
        _ctrl.jumpTo(0);
      } else {
        _ctrl.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repeated = List<_BrandItem>.generate(
      10 * widget.items.length,
      (i) => widget.items[i % widget.items.length],
    );

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: widget.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        controller: _ctrl,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final it = repeated[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(it.icon, color: AppColors.accentCyan),
                const SizedBox(width: 8),
                Text(
                  it.label,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: repeated.length,
      ),
    );
  }
}
