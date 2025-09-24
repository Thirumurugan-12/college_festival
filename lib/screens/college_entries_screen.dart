import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'reels_screen.dart';
import 'college_dashboard.dart';

class CollegeEntriesScreen extends StatefulWidget {
  final CollegeData college;

  const CollegeEntriesScreen({super.key, required this.college});

  @override
  State<CollegeEntriesScreen> createState() => _CollegeEntriesScreenState();
}

class _CollegeEntriesScreenState extends State<CollegeEntriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  // Track which videos have been voted for
  final Map<String, bool> _votedVideos = {};
  final Map<String, int> _videoVoteCounts = {};

  // Mock video data
  final List<VideoEntry> _allVideos = [
    // Singing entries
    VideoEntry(
      id: '1',
      title: 'Classical Tamil Song',
      category: 'Singing',
      studentName: 'Priya Sharma',
      thumbnailUrl: 'https://picsum.photos/300/400?random=1',
      videoUrl: 'sample_video_1.mp4',
      votes: 245,
      duration: '2:30',
    ),
    VideoEntry(
      id: '2',
      title: 'Bollywood Cover',
      category: 'Singing',
      studentName: 'Raj Kumar',
      thumbnailUrl: 'https://picsum.photos/300/400?random=2',
      videoUrl: 'sample_video_2.mp4',
      votes: 189,
      duration: '1:45',
    ),
    VideoEntry(
      id: '3',
      title: 'Western Song Performance',
      category: 'Singing',
      studentName: 'Sarah Joseph',
      thumbnailUrl: 'https://picsum.photos/300/400?random=3',
      videoUrl: 'sample_video_3.mp4',
      votes: 312,
      duration: '2:15',
    ),
    // Acting entries
    VideoEntry(
      id: '4',
      title: 'Monologue Performance',
      category: 'Acting',
      studentName: 'Arjun Menon',
      thumbnailUrl: 'https://picsum.photos/300/400?random=4',
      videoUrl: 'sample_video_4.mp4',
      votes: 156,
      duration: '1:50',
    ),
    VideoEntry(
      id: '5',
      title: 'Comedy Skit',
      category: 'Acting',
      studentName: 'Maya Patel',
      thumbnailUrl: 'https://picsum.photos/300/400?random=5',
      videoUrl: 'sample_video_5.mp4',
      votes: 278,
      duration: '2:05',
    ),
    // Dancing entries
    VideoEntry(
      id: '6',
      title: 'Bharatanatyam Performance',
      category: 'Dancing',
      studentName: 'Lakshmi Nair',
      thumbnailUrl: 'https://picsum.photos/300/400?random=6',
      videoUrl: 'sample_video_6.mp4',
      votes: 423,
      duration: '2:45',
    ),
    VideoEntry(
      id: '7',
      title: 'Hip Hop Dance',
      category: 'Dancing',
      studentName: 'Kevin Thomas',
      thumbnailUrl: 'https://picsum.photos/300/400?random=7',
      videoUrl: 'sample_video_7.mp4',
      votes: 367,
      duration: '1:30',
    ),
    VideoEntry(
      id: '8',
      title: 'Folk Dance Fusion',
      category: 'Dancing',
      studentName: 'Aishwarya Rao',
      thumbnailUrl: 'https://picsum.photos/300/400?random=8',
      videoUrl: 'sample_video_8.mp4',
      votes: 298,
      duration: '2:20',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Initialize vote counts from video data
    for (var video in _allVideos) {
      _videoVoteCounts[video.id] = video.votes;
      _votedVideos[video.id] = false;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<VideoEntry> get _filteredVideos {
    if (_selectedCategory == 'All') return _allVideos;
    return _allVideos
        .where((video) => video.category == _selectedCategory)
        .toList();
  }

  Widget _buildStatsRow(bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildStatItem(
              'TOTAL',
              widget.college.totalEntries.toString(),
              Colors.red,
              Icons.video_library,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildStatItem(
              'SINGING',
              widget.college.singingEntries.toString(),
              Colors.blue,
              Icons.music_note,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildStatItem(
              'ACTING',
              widget.college.actingEntries.toString(),
              Colors.green,
              Icons.theater_comedy,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildStatItem(
              'DANCING',
              widget.college.danceEntries.toString(),
              Colors.purple,
              Icons.sports_handball,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(height: 2),
          Text(
            count,
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 8,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomTabs(bool isMobile) {
    final categories = [
      {'name': 'ALL', 'icon': Icons.apps, 'color': Colors.orange},
      {'name': 'SINGING', 'icon': Icons.music_note, 'color': Colors.blue},
      {'name': 'ACTING', 'icon': Icons.theater_comedy, 'color': Colors.green},
      {
        'name': 'DANCING',
        'icon': Icons.sports_handball,
        'color': Colors.purple,
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < categories.length - 1 ? 4 : 0,
              ),
              child: _buildTabButton(category, index),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabButton(Map<String, dynamic> category, int index) {
    final isSelected = () {
      switch (index) {
        case 0:
          return _selectedCategory == 'All';
        case 1:
          return _selectedCategory == 'Singing';
        case 2:
          return _selectedCategory == 'Acting';
        case 3:
          return _selectedCategory == 'Dancing';
        default:
          return false;
      }
    }();

    return GestureDetector(
      onTap: () {
        setState(() {
          switch (index) {
            case 0:
              _selectedCategory = 'All';
              break;
            case 1:
              _selectedCategory = 'Singing';
              break;
            case 2:
              _selectedCategory = 'Acting';
              break;
            case 3:
              _selectedCategory = 'Dancing';
              break;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? category['color'] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 0,
                    offset: const Offset(2, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              category['icon'],
              color: isSelected ? Colors.white : Colors.black54,
              size: 16,
            ),
            const SizedBox(height: 2),
            Text(
              category['name'],
              style: GoogleFonts.bebasNeue(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverVideoGrid(bool isMobile) {
    final crossAxisCount = isMobile ? 2 : 4;
    final videos = _filteredVideos;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final video = videos[index];
          return SlideInUp(
            delay: Duration(milliseconds: 100 * (index % 8)),
            child: _buildEnhancedVideoCard(video, index),
          );
        }, childCount: videos.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Beautiful App Bar with college info
          SliverAppBar(
            expandedHeight: isMobile ? 280 : 320,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF230023),
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF230023),
                      Color(0xFF4A0E4E),
                      Color(0xFF6A1B9A),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Comic dots pattern
                    Positioned.fill(
                      child: CustomPaint(painter: ComicDotsPainter()),
                    ),
                    // College info hero section
                    Positioned.fill(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              // College name with comic styling
                              FadeInDown(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 0,
                                        offset: const Offset(4, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    widget.college.name,
                                    style: GoogleFonts.bebasNeue(
                                      color: Colors.black,
                                      fontSize: isMobile ? 16 : 20,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Location badge
                              FadeInUp(
                                delay: const Duration(milliseconds: 200),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.college.location,
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Statistics row
                              FadeInUp(
                                delay: const Duration(milliseconds: 400),
                                child: _buildStatsRow(isMobile),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Custom tabs section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _buildCustomTabs(isMobile),
              ),
            ),
          ),

          // Content section
          _filteredVideos.isEmpty
              ? SliverToBoxAdapter(child: _buildEmptyState())
              : _buildSliverVideoGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: FadeInUp(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Comic-style empty state container
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 4),
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
                    // Comic-style icon with burst effect
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                          ),
                          child: const Icon(
                            Icons.video_library_outlined,
                            size: 48,
                            color: Colors.black54,
                          ),
                        ),
                        // Burst lines around the icon
                        for (int i = 0; i < 8; i++)
                          Positioned(
                            top: 50 + 50 * (i % 2 == 0 ? -0.8 : -1.2),
                            left: 50 + 50 * (i % 2 == 0 ? -0.8 : -1.2),
                            child: Transform.rotate(
                              angle: (i * 3.14159) / 4,
                              child: Container(
                                width: 20,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Comic-style title
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
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
                        'OOPS! NO ENTRIES FOUND',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description with comic styling
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'This category doesn\'t have any submissions yet!',
                            style: GoogleFonts.montserrat(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Check back later or try a different category',
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Action button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 0,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TRY ALL CATEGORIES',
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
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
  }

  Widget _buildEnhancedVideoCard(VideoEntry video, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReelsScreen(
              videos: _allVideos,
              initialIndex: _allVideos.indexOf(video),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Thumbnail with comic filter
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getCategoryColor(video.category).withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: _getCategoryColor(video.category).withOpacity(0.2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.video_library,
                            color: _getCategoryColor(video.category),
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video.category.toUpperCase(),
                            style: GoogleFonts.bebasNeue(
                              color: _getCategoryColor(video.category),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Gradient overlay with comic style
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Comic-style play button
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 0,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: _getCategoryColor(video.category),
                    size: 32,
                  ),
                ),
              ),

              // Top badges row
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category badge with comic styling
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(video.category),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 0,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        video.category.toUpperCase(),
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    // Duration badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Text(
                        video.duration,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom info panel with comic styling
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title with comic styling
                      Text(
                        video.title,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Student info row
                      Row(
                        children: [
                          // Student avatar
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(video.category),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                video.studentName[0].toUpperCase(),
                                style: GoogleFonts.bebasNeue(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              video.studentName,
                              style: GoogleFonts.montserrat(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Interactive vote button
                      Row(
                        children: [
                          _buildVoteButton(video),
                          const Spacer(),
                          // Rank badge if in top 3
                          if (index < 3)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: index == 0
                                    ? Colors.amber
                                    : index == 1
                                    ? Colors.grey[300]
                                    : Colors.orange[300],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '#${index + 1}',
                                style: GoogleFonts.bebasNeue(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleVote(String videoId) {
    setState(() {
      bool currentlyVoted = _votedVideos[videoId] ?? false;
      _votedVideos[videoId] = !currentlyVoted;

      if (!currentlyVoted) {
        // User is voting
        _videoVoteCounts[videoId] = (_videoVoteCounts[videoId] ?? 0) + 1;
        // Show feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.thumb_up, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Vote added!',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } else {
        // User is removing vote
        _videoVoteCounts[videoId] = (_videoVoteCounts[videoId] ?? 1) - 1;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.thumb_down, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Vote removed',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.grey[600],
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    });
  }

  Widget _buildVoteButton(VideoEntry video) {
    bool hasVoted = _votedVideos[video.id] ?? false;
    int voteCount = _videoVoteCounts[video.id] ?? video.votes;

    return GestureDetector(
      onTap: () => _toggleVote(video.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: hasVoted ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                hasVoted ? Icons.thumb_up : Icons.thumb_up_outlined,
                color: Colors.white,
                size: 14,
                key: ValueKey(hasVoted),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              hasVoted ? 'VOTED' : 'VOTE',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$voteCount',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Singing':
        return Colors.blue;
      case 'Acting':
        return Colors.green;
      case 'Dancing':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class VideoEntry {
  final String id;
  final String title;
  final String category;
  final String studentName;
  final String thumbnailUrl;
  final String videoUrl;
  final int votes;
  final String duration;

  VideoEntry({
    required this.id,
    required this.title,
    required this.category,
    required this.studentName,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.votes,
    required this.duration,
  });
}

class ComicDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Create a comic-style dot pattern
    const dotRadius = 2.0;
    const spacing = 20.0;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
