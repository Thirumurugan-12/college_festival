import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'college_entries_screen.dart';

class ReelsScreen extends StatefulWidget {
  final List<VideoEntry> videos;
  final int initialIndex;

  const ReelsScreen({
    super.key,
    required this.videos,
    required this.initialIndex,
  });

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _heartAnimationController;
  late Animation<double> _heartAnimation;
  int _currentIndex = 0;

  // Track votes for each video
  final Map<String, bool> _videoVotes = {};
  final Map<String, int> _videoVoteCounts = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);

    // Initialize vote counts for all videos
    for (var video in widget.videos) {
      _videoVotes[video.id] = false;
      _videoVoteCounts[video.id] = video.votes;
    }

    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _heartAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _heartAnimationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _toggleVote() {
    final currentVideo = widget.videos[_currentIndex];
    setState(() {
      bool currentlyVoted = _videoVotes[currentVideo.id] ?? false;
      _videoVotes[currentVideo.id] = !currentlyVoted;

      if (!currentlyVoted) {
        _videoVoteCounts[currentVideo.id] =
            (_videoVoteCounts[currentVideo.id] ?? 0) + 1;
        _heartAnimationController.forward();

        // Show vote success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.how_to_vote, color: Colors.white, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Vote Submitted!',
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Supporting ${currentVideo.studentName}',
                        style: GoogleFonts.montserrat(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green[600],
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      } else {
        _videoVoteCounts[currentVideo.id] =
            (_videoVoteCounts[currentVideo.id] ?? 1) - 1;
        _heartAnimationController.reverse();

        // Show vote removal feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Vote Removed',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.grey[700],
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video pages
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
              _heartAnimationController.reset();
            },
            itemCount: widget.videos.length,
            itemBuilder: (context, index) {
              return _buildVideoPage(widget.videos[index]);
            },
          ),

          // Top app bar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Text(
                        '${_currentIndex + 1} / ${widget.videos.length}',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPage(VideoEntry video) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video background (placeholder with image)
        Container(
          color: Colors.black,
          child: Image.network(
            video.thumbnailUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Icon(
                    Icons.video_library,
                    color: Colors.white54,
                    size: 100,
                  ),
                ),
              );
            },
          ),
        ),

        // Play button overlay (center)
        Center(
          child: GestureDetector(
            onTap: () {
              // TODO: Implement video playback
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Playing: ${video.title}'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ),

        // Right side actions
        Positioned(
          right: 16,
          bottom: 100,
          child: Column(
            children: [
              // Dedicated Vote Button
              GestureDetector(
                onTap: _toggleVote,
                child: AnimatedBuilder(
                  animation: _heartAnimation,
                  builder: (context, child) {
                    bool hasVoted = _videoVotes[video.id] ?? false;
                    int voteCount = _videoVoteCounts[video.id] ?? video.votes;

                    return Transform.scale(
                      scale: _heartAnimation.value == 0
                          ? 1.0
                          : 1.0 + (_heartAnimation.value * 0.1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: hasVoted
                                ? [Colors.green[600]!, Colors.green[400]!]
                                : [Colors.grey[800]!, Colors.grey[600]!],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: hasVoted
                                ? Colors.green[300]!
                                : Colors.white24,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (hasVoted ? Colors.green : Colors.black)
                                  .withOpacity(0.3),
                              blurRadius: hasVoted ? 8 : 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              hasVoted
                                  ? Icons.how_to_vote
                                  : Icons.how_to_vote_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              hasVoted ? 'VOTED' : 'VOTE',
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$voteCount',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Share button
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Share functionality coming soon!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 2),
                  ),
                  child: const Icon(Icons.share, color: Colors.white, size: 28),
                ),
              ),

              const SizedBox(height: 24),

              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(video.category),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2),
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
            ],
          ),
        ),

        // Bottom info panel
        Positioned(
          left: 16,
          right: 80,
          bottom: 50,
          child: FadeInUp(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Student name with avatar
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getCategoryColor(video.category),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          video.studentName[0].toUpperCase(),
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.studentName,
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              video.duration,
                              style: GoogleFonts.montserrat(
                                color: Colors.white70,
                                fontSize: 10,
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

                // Video title
                Text(
                  video.title,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 20,
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

                const SizedBox(height: 8),

                // Description or hashtags
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildHashtag('#${video.category.toLowerCase()}'),
                    _buildHashtag('#collegethiruvizha'),
                    _buildHashtag('#talent'),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Swipe indicators
        if (widget.videos.length > 1)
          Positioned(
            right: 8,
            top: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                if (_currentIndex > 0)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                if (_currentIndex < widget.videos.length - 1)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildHashtag(String hashtag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Text(
        hashtag,
        style: GoogleFonts.montserrat(
          color: Colors.blue,
          fontSize: 11,
          fontWeight: FontWeight.w700,
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
