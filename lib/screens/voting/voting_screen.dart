import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  final PageController _pageController = PageController();
  final List<Map<String, dynamic>> _entries = [
    {
      'type': 'video',
      'url':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      'name': 'Performer 1',
    },
    {
      'type': 'audio',
      'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      'name': 'Performer 2',
    },
    {
      'type': 'video',
      'url':
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'name': 'Performer 3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          return ReelItem(entry: _entries[index]);
        },
      ),
    );
  }
}

class ReelItem extends StatefulWidget {
  final Map<String, dynamic> entry;
  const ReelItem({super.key, required this.entry});

  @override
  State<ReelItem> createState() => _ReelItemState();
}

class _ReelItemState extends State<ReelItem> {
  VideoPlayerController? _videoController;
  AudioPlayer? _audioPlayer;
  bool _isLiked = false;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.entry['type'] == 'video') {
      _initializeVideoPlayer();
    } else {
      _audioPlayer = AudioPlayer();
      _audioPlayer?.play(UrlSource(widget.entry['url']));
      // Assuming audio plays instantly, no complex loading state needed for this example
    }
  }

  void _initializeVideoPlayer() {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.entry['url']),
    );

    _videoController!
        .initialize()
        .then((_) {
          if (mounted) {
            _videoController!.play();
            _videoController!.setLooping(true);
            setState(() {
              _isVideoInitialized = true;
            });
          }
        })
        .catchError((error) {
          // ignore: avoid_print
          print("Error initializing video in ReelItem: $error");
          // Optionally retry initialization
          Future.delayed(const Duration(seconds: 5), () {
            if (mounted && !_isVideoInitialized) {
              _initializeVideoPlayer();
            }
          });
        });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer?.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      _isLiked = true;
    });
    // Handle vote logic here
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLiked = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleLike,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.entry['type'] == 'video')
            _isVideoInitialized
                ? VideoPlayer(_videoController!)
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentPink,
                    ),
                  )
          else // Audio
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.backgroundGradient,
              ),
              child: const Center(
                child: Icon(
                  Icons.music_note,
                  color: AppColors.white,
                  size: 100,
                ),
              ),
            ),
          if (_isLiked)
            const Center(
              child: Icon(Icons.favorite, color: Colors.red, size: 100),
            ),
          _buildOverlay(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.entry['name'],
            style: GoogleFonts.orbitron(
              color: AppColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Song Name',
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Double tap to vote',
                style: TextStyle(color: AppColors.white),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: AppColors.white,
                  size: 30,
                ),
                onPressed: _handleLike,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
