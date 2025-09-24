import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class CollegeDashboard extends StatefulWidget {
  const CollegeDashboard({super.key});

  @override
  State<CollegeDashboard> createState() => _CollegeDashboardState();
}

class _CollegeDashboardState extends State<CollegeDashboard> {
  String _sortBy = 'Total Entries';

  // Mock data for colleges and their entries
  final List<CollegeData> _collegeData = [
    CollegeData(
      name: 'Anna University',
      location: 'Chennai',
      totalEntries: 145,
      singingEntries: 52,
      actingEntries: 43,
      danceEntries: 50,
      rank: 1,
    ),
    CollegeData(
      name: 'Madras Institute of Technology',
      location: 'Chennai',
      totalEntries: 128,
      singingEntries: 45,
      actingEntries: 38,
      danceEntries: 45,
      rank: 2,
    ),
    CollegeData(
      name: 'PSG College of Technology',
      location: 'Coimbatore',
      totalEntries: 112,
      singingEntries: 38,
      actingEntries: 35,
      danceEntries: 39,
      rank: 3,
    ),
    CollegeData(
      name: 'SSN College of Engineering',
      location: 'Chennai',
      totalEntries: 98,
      singingEntries: 32,
      actingEntries: 33,
      danceEntries: 33,
      rank: 4,
    ),
    CollegeData(
      name: 'Loyola College',
      location: 'Chennai',
      totalEntries: 87,
      singingEntries: 29,
      actingEntries: 28,
      danceEntries: 30,
      rank: 5,
    ),
    CollegeData(
      name: 'Stella Maris College',
      location: 'Chennai',
      totalEntries: 76,
      singingEntries: 25,
      actingEntries: 24,
      danceEntries: 27,
      rank: 6,
    ),
    CollegeData(
      name: 'VIT University',
      location: 'Vellore',
      totalEntries: 65,
      singingEntries: 22,
      actingEntries: 21,
      danceEntries: 22,
      rank: 7,
    ),
    CollegeData(
      name: 'SRM Institute of Science and Technology',
      location: 'Chennai',
      totalEntries: 58,
      singingEntries: 19,
      actingEntries: 19,
      danceEntries: 20,
      rank: 8,
    ),
  ];

  List<CollegeData> get _filteredData {
    List<CollegeData> filtered = List.from(_collegeData);

    // Sort by selected criteria
    switch (_sortBy) {
      case 'Total Entries':
        filtered.sort((a, b) => b.totalEntries.compareTo(a.totalEntries));
        break;
      case 'Singing':
        filtered.sort((a, b) => b.singingEntries.compareTo(a.singingEntries));
        break;
      case 'Acting':
        filtered.sort((a, b) => b.actingEntries.compareTo(a.actingEntries));
        break;
      case 'Dance':
        filtered.sort((a, b) => b.danceEntries.compareTo(a.danceEntries));
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF230023).withOpacity(0.9),
        elevation: 0,
        title: FadeInDown(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'COLLEGE DASHBOARD',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Comic burst effect
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 14),
              ),
            ],
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF230023), Color(0xFF4A0E4E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 2.0,
            colors: [
              Color(0xFF4A0E4E),
              Color(0xFF2D1B69),
              Color(0xFF11101D),
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Comic book dots pattern
            Positioned.fill(child: CustomPaint(painter: ComicDotsPainter())),
            // Main content
            SafeArea(
              child: isMobile
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header Stats with comic style
                          _buildComicHeaderStats(isMobile),

                          // Filter Controls with comic style
                          _buildComicFilterControls(isMobile),

                          const SizedBox(height: 16),

                          // Other Colleges Section Header
                          _buildOtherCollegesHeader(),

                          // College List with comic cards (mobile version)
                          _buildMobileCollegeList(),

                          const SizedBox(height: 20), // Bottom padding
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Header Stats with comic style
                          _buildComicHeaderStats(isMobile),

                          // Filter Controls with comic style
                          _buildComicFilterControls(isMobile),

                          const SizedBox(height: 16),

                          // Other Colleges Section Header
                          _buildOtherCollegesHeader(),

                          // College List with comic cards (desktop version)
                          _buildDesktopCollegeList(),

                          const SizedBox(height: 20), // Bottom padding
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComicHeaderStats(bool isMobile) {
    final topThreeColleges = _filteredData.take(3).toList();

    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 0,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    'TOP 3 LEADERS',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: isMobile ? 14 : 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Top 3 Colleges Display
            if (isMobile)
              Column(
                children: topThreeColleges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final college = entry.value;
                  return _buildTopCollegeMobileCard(college, index + 1);
                }).toList(),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: topThreeColleges.asMap().entries.map((entry) {
                  final index = entry.key;
                  final college = entry.value;
                  return Expanded(
                    child: _buildTopCollegeDesktopCard(college, index + 1),
                  );
                }).toList(),
              ),
            const SizedBox(height: 16),
            // Overall Stats Row
            // if (isMobile)
            //   Column(children: _buildComicStatCards())
            // else
            //   Wrap(
            //     spacing: 10,
            //     runSpacing: 10,
            //     alignment: WrapAlignment.spaceEvenly,
            //     children: _buildComicStatCards(),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCollegeMobileCard(CollegeData college, int rank) {
    final colors = [Colors.red, Colors.blue, Colors.green];
    final cardColor = colors[(rank - 1) % colors.length];
    final trophyIcons = [Icons.emoji_events, Icons.military_tech, Icons.stars];
    final trophyIcon = trophyIcons[(rank - 1) % trophyIcons.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(trophyIcon, color: Colors.white, size: 16),
                Text(
                  '#$rank',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // College Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  college.name,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  college.location,
                  style: GoogleFonts.montserrat(
                    color: Colors.grey[600],
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Total Entries
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Text(
              '${college.totalEntries}',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCollegeDesktopCard(CollegeData college, int rank) {
    final colors = [Colors.red, Colors.blue, Colors.green];
    final cardColor = colors[(rank - 1) % colors.length];
    final trophyIcons = [Icons.emoji_events, Icons.military_tech, Icons.stars];
    final trophyIcon = trophyIcons[(rank - 1) % trophyIcons.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Rank Badge
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: cardColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(trophyIcon, color: Colors.white, size: 20),
                Text(
                  '#$rank',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // College Info
          Text(
            college.name,
            style: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            college.location,
            style: GoogleFonts.montserrat(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Total Entries
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Text(
              '${college.totalEntries} TOTAL',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherCollegesHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.format_list_numbered, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            'OTHER COLLEGES',
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComicFilterControls(bool isMobile) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'SORT BY:',
                  style: GoogleFonts.bebasNeue(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: const Icon(Icons.sort, color: Colors.black, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: DropdownButton<String>(
                value: _sortBy,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
                items: ['Total Entries', 'Singing', 'Acting', 'Dance'].map((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sortBy = newValue!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopCollegeList() {
    // Skip top 3 colleges as they're shown in the header
    final remainingColleges = _filteredData.skip(3).toList();

    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Column(
        children: remainingColleges.asMap().entries.map((entry) {
          final index = entry.key;
          final college = entry.value;
          // Display rank should be index + 4 (since top 3 are shown in header)
          return SlideInLeft(
            delay: Duration(milliseconds: 100 * index),
            child: _buildComicCollegeCard(
              college,
              index + 4,
              false,
            ), // false for isMobile
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMobileCollegeList() {
    // Skip top 3 colleges as they're shown in the header
    final remainingColleges = _filteredData.skip(3).toList();

    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Column(
        children: remainingColleges.asMap().entries.map((entry) {
          final index = entry.key;
          final college = entry.value;
          // Display rank should be index + 4 (since top 3 are shown in header)
          return SlideInLeft(
            delay: Duration(milliseconds: 100 * index),
            child: _buildMobileComicCollegeCard(college, index + 4),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildComicCollegeCard(
    CollegeData college,
    int displayRank,
    bool isMobile,
  ) {
    // Rotate colors for comic effect
    final cardColors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
    ];
    final cardColor = cardColors[displayRank % cardColors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isMobile
            ? _buildMobileComicLayout(college, displayRank)
            : _buildDesktopComicLayout(college, displayRank),
      ),
    );
  }

  Widget _buildMobileComicCollegeCard(CollegeData college, int displayRank) {
    // Rotate colors for comic effect
    final cardColors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
    ];
    final cardColor = cardColors[displayRank % cardColors.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with rank badge and college info
            Row(
              children: [
                _buildComicRankBadge(displayRank),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        college.name,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          college.location,
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Stats section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  // Total entries - prominent display
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.group, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'TOTAL: ${college.totalEntries}',
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Category breakdown
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildMobileStatChip(
                        '🎵 SING',
                        college.singingEntries,
                        Colors.blue,
                      ),
                      _buildMobileStatChip(
                        '🎭 ACT',
                        college.actingEntries,
                        Colors.green,
                      ),
                      _buildMobileStatChip(
                        '💃 DANCE',
                        college.danceEntries,
                        Colors.purple,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileComicLayout(CollegeData college, int displayRank) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildComicRankBadge(displayRank),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    college.name,
                    style: GoogleFonts.bebasNeue(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      college.location,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildComicEntryStats(college),
      ],
    );
  }

  Widget _buildDesktopComicLayout(CollegeData college, int displayRank) {
    return Row(
      children: [
        _buildComicRankBadge(displayRank),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                college.name,
                style: GoogleFonts.bebasNeue(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  college.location,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 2, child: _buildComicEntryStats(college)),
      ],
    );
  }

  Widget _buildComicRankBadge(int rank) {
    Color badgeColor;
    String badgeText = '$rank';

    if (rank == 1) {
      badgeColor = const Color(0xFFFFD700); // Gold
      badgeText = '👑';
    } else if (rank == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
      badgeText = '🥈';
    } else if (rank == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
      badgeText = '🥉';
    } else {
      badgeColor = Colors.blue;
    }

    return Container(
      width: MediaQuery.of(context).size.width < 768 ? 45 : 50,
      height: MediaQuery.of(context).size.width < 768 ? 45 : 50,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Center(
        child: rank <= 3
            ? Text(
                badgeText,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width < 768 ? 18 : 20,
                ),
              )
            : Text(
                badgeText,
                style: GoogleFonts.bebasNeue(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width < 768 ? 16 : 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    );
  }

  Widget _buildComicEntryStats(CollegeData college) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        _buildComicStatChip('TOTAL', college.totalEntries, Colors.red),
        _buildComicStatChip('SING', college.singingEntries, Colors.blue),
        _buildComicStatChip('ACT', college.actingEntries, Colors.green),
        _buildComicStatChip('DANCE', college.danceEntries, Colors.purple),
      ],
    );
  }

  Widget _buildComicStatChip(String label, int value, Color color) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 10,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 0,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        '$label: $value',
        style: GoogleFonts.bebasNeue(
          color: Colors.white,
          fontSize: isMobile ? 10 : 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
          shadows: [Shadow(color: Colors.black, offset: const Offset(1, 1))],
        ),
      ),
    );
  }

  Widget _buildMobileStatChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Text(
        '$label: $count',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(color: Colors.black, offset: const Offset(0.5, 0.5)),
          ],
        ),
      ),
    );
  }
}

// Comic dots pattern painter
class ComicDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    const dotSize = 3.0;
    const spacing = 15.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CollegeData {
  final String name;
  final String location;
  final int totalEntries;
  final int singingEntries;
  final int actingEntries;
  final int danceEntries;
  final int rank;

  CollegeData({
    required this.name,
    required this.location,
    required this.totalEntries,
    required this.singingEntries,
    required this.actingEntries,
    required this.danceEntries,
    required this.rank,
  });
}
