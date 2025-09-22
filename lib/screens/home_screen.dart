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
import 'home/widgets/auto_scroll_text_strip.dart';
import 'home/widgets/auto_scroll_card_strip.dart';
import 'home/widgets/bottom_looping_image_strip.dart';
import 'home/widgets/menu_pill.dart';
import 'home/widgets/section3_card.dart';
import 'home/widgets/info_pill.dart';
import 'home/widgets/auto_horizontal_category_cards.dart';
import 'home/widgets/countdown_band.dart';
import 'home/widgets/sponsors_strip.dart';

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
          child: AutoScrollTextStrip(
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
            child: AutoScrollTextStrip(
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
    return AutoScrollCardStrip(
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
              child: Section3Card(
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
              child: Section3Card(
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
              child: Section3Card(
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
          child: Section3Card(
            asset: 'lib/assets/singing_card.png',
            height: cardHeight,
          ),
        ),
        SizedBox(height: gap),
        GestureDetector(
          onTap: openPhoto,
          child: Section3Card(
            asset: 'lib/assets/photo_card.png',
            height: cardHeight,
          ),
        ),
        SizedBox(height: gap),
        GestureDetector(
          onTap: openActing,
          child: Section3Card(
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
                                child: CountdownBand(
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
                                CategoryCardSpec(
                                  'lib/assets/singing_card.png',
                                  cardH,
                                  openSinging,
                                ),
                                CategoryCardSpec(
                                  'lib/assets/photo_card.png',
                                  cardH,
                                  openPhoto,
                                ),
                                CategoryCardSpec(
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
                                    child: AutoHorizontalCategoryCards(
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
                      return AutoScrollCardStrip(
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
                                    InfoPill(
                                      icon: Icons.music_note,
                                      label: 'Music & Performance',
                                    ),
                                    InfoPill(
                                      icon: Icons.camera_alt,
                                      label: 'Photo & Visuals',
                                    ),
                                    InfoPill(
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
                              child: AutoScrollCardStrip(
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
                child: BottomLoopingImageStrip(
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
                                MenuPill(
                                  'DATES',
                                  active: activeFooterIndex == 0,
                                ),
                                MenuPill(
                                  'CATEGORIES',
                                  active: activeFooterIndex == 1,
                                ),
                                MenuPill('JURY', active: false),
                                MenuPill(
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
// moved AutoScrollTextStrip to home/widgets/auto_scroll_text_strip.dart

// Reusable continuous auto-scrolling card strip for carousels.
// moved AutoScrollCardStrip and HoverableImageCard to home/widgets/auto_scroll_card_strip.dart

// Extracted private widgets moved to lib/screens/home/widgets/*
