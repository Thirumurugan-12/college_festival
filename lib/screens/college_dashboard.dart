import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'college_entries_screen.dart';

class CollegeDashboard extends StatefulWidget {
  const CollegeDashboard({super.key});

  @override
  State<CollegeDashboard> createState() => _CollegeDashboardState();
}

class _CollegeDashboardState extends State<CollegeDashboard> {
  String _sortBy = 'Total Entries';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((college) {
        return college.name.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            college.location.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Text(
            'SEARCH COLLEGES',
            style: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter college name or location...',
              prefixIcon: const Icon(Icons.search, color: Colors.black54),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black54),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCollegesList(bool isMobile) {
    final colleges = _filteredData;

    if (colleges.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'NO COLLEGES FOUND',
              style: GoogleFonts.bebasNeue(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            Text(
              'Try adjusting your search or filter criteria',
              style: GoogleFonts.montserrat(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return FadeInUp(
      child: Column(
        children: colleges.asMap().entries.map((entry) {
          final index = entry.key;
          final college = entry.value;
          return SlideInLeft(
            delay: Duration(milliseconds: 50 * index),
            child: _buildClickableCollegeCard(college, index + 1, isMobile),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildClickableCollegeCard(
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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollegeEntriesScreen(college: college),
          ),
        );
      },
      child: Container(
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
                            fontSize: isMobile ? 16 : 18,
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
                  // Click to view arrow
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
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
                          const Icon(
                            Icons.group,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TOTAL: ${college.totalEntries} ENTRIES',
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
                        _buildStatChip(
                          '🎵 SINGING',
                          college.singingEntries,
                          Colors.blue,
                        ),
                        _buildStatChip(
                          '🎭 ACTING',
                          college.actingEntries,
                          Colors.green,
                        ),
                        _buildStatChip(
                          '💃 DANCING',
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
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Search Bar
                    _buildSearchBar(),

                    const SizedBox(height: 16),

                    // Filter Controls with comic style
                    _buildComicFilterControls(isMobile),

                    const SizedBox(height: 16),

                    // All Colleges List
                    _buildAllCollegesList(isMobile),

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
