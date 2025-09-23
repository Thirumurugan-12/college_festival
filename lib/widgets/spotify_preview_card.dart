import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/spotify_demo_data.dart';

class SpotifyPreviewCard extends StatefulWidget {
  final String spotifyUrl;

  const SpotifyPreviewCard({super.key, required this.spotifyUrl});

  @override
  State<SpotifyPreviewCard> createState() => _SpotifyPreviewCardState();
}

class _SpotifyPreviewCardState extends State<SpotifyPreviewCard> {
  String? title;
  String? artist;
  String? thumbnailUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // For demo purposes, let's try API first but fallback quickly
    _initializeData();
  }

  void _initializeData() async {
    // Simulate shorter loading for better UX
    await Future.delayed(const Duration(milliseconds: 300));

    // Use demo data first
    final demoData = SpotifyDemoData.getSongData(widget.spotifyUrl);

    if (demoData != null && mounted) {
      setState(() {
        title = demoData['title'];
        artist = demoData['artist'];
        thumbnailUrl = demoData['thumbnail'];
        isLoading = false;
      });
    } else {
      // Fallback to static data
      _loadFallbackData();
    }
  }

  Future<void> fetchSpotifyData() async {
    try {
      final url =
          "https://open.spotify.com/oembed?url=${Uri.encodeComponent(widget.spotifyUrl)}";

      print('Fetching Spotify data from: $url'); // Debug log

      final res = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${res.statusCode}'); // Debug log
      print('Response body: ${res.body}'); // Debug log

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (mounted) {
          setState(() {
            title = data["title"];
            artist = data["author_name"];
            thumbnailUrl = data["thumbnail_url"];
            isLoading = false;
          });
        }
      } else {
        print('API Error: ${res.statusCode} - ${res.body}'); // Debug log
        _loadFallbackData(); // Use fallback data
      }
    } catch (e) {
      print('Exception occurred: $e'); // Debug log
      _loadFallbackData(); // Use fallback data
    }
  }

  void _loadFallbackData() {
    // Fallback data based on common track IDs
    final fallbackData = _getFallbackData(widget.spotifyUrl);

    if (mounted) {
      setState(() {
        title = fallbackData['title'];
        artist = fallbackData['artist'];
        thumbnailUrl = fallbackData['thumbnail'];
        isLoading = false;
      });
    }
  }

  Map<String, String> _getFallbackData(String spotifyUrl) {
    // Extract track ID from URL and provide fallback data
    if (spotifyUrl.contains('4iV5W9uYEdYUVa79Axb7Rh')) {
      return {
        'title': 'Never Gonna Give You Up',
        'artist': 'Rick Astley',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b2735755e164993798e0c9ef7d7a',
      };
    } else if (spotifyUrl.contains('60nZcImufyMA1MKQY3dcCH')) {
      return {
        'title': 'Hotel California',
        'artist': 'Eagles',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b273ce4f1737bc8a646c8c4bd25a',
      };
    } else if (spotifyUrl.contains('7qiZfU4dY1lWllzX7mPBI3')) {
      return {
        'title': 'Shape of You',
        'artist': 'Ed Sheeran',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b273ba5db46f4b838ef6027e6f96',
      };
    } else if (spotifyUrl.contains('1mea3bSkSGXuIRvnydlB5b')) {
      return {
        'title': 'Levitating',
        'artist': 'Dua Lipa',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b273be841ba4bc24340152e3a79a',
      };
    } else if (spotifyUrl.contains('11dFghVXANMlKmJXsNCbNl')) {
      return {
        'title': 'Rather Be',
        'artist': 'Clean Bandit feat. Jess Glynne',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b273a74c4bb7e8133b8f9212caec',
      };
    } else if (spotifyUrl.contains('2WfaOiMkCvy7F5fcp2zZ8L')) {
      return {
        'title': 'Blinding Lights',
        'artist': 'The Weeknd',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b2738863bc11d2aa12b54f5aeb36',
      };
    } else {
      return {
        'title': 'Featured Song',
        'artist': 'Various Artists',
        'thumbnail':
            'https://i.scdn.co/image/ab67616d0000b273a74c4bb7e8133b8f9212caec',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (isLoading) {
      return Container(
        width: isMobile ? 250 : 300,
        height: isMobile ? 300 : 350,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.green, strokeWidth: 3),
        ),
      );
    }

    if (title == null || artist == null || thumbnailUrl == null) {
      return Container(
        width: isMobile ? 250 : 300,
        height: isMobile ? 300 : 350,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: isMobile ? 40 : 50,
              ),
              const SizedBox(height: 8),
              Text(
                'Unable to load\nSpotify preview',
                textAlign: TextAlign.center,
                style: GoogleFonts.fredoka(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: isMobile ? 250 : 300,
      height: isMobile ? 300 : 350,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(6, 6),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with comic-style overlay
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: isMobile ? 180 : 200,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    thumbnailUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      print('Image loading error: $error'); // Debug log
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple[300]!,
                              Colors.blue[400]!,
                              Colors.green[400]!,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.music_note,
                                size: isMobile ? 40 : 50,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'MUSIC',
                                style: GoogleFonts.fredoka(
                                  fontSize: isMobile ? 16 : 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: const Offset(2, 2),
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
                  // Comic-style gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Spotify logo overlay
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: isMobile ? 16 : 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Title + Artist with comic styling
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    artist!,
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Play button with comic styling
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          if (await canLaunchUrl(
                            Uri.parse(widget.spotifyUrl),
                          )) {
                            await launchUrl(
                              Uri.parse(widget.spotifyUrl),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        } catch (e) {
                          // Handle error silently or show a snackbar
                        }
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: Text(
                        "Play on Spotify",
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 8 : 10,
                          horizontal: 12,
                        ),
                      ),
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
