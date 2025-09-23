import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/spotify_demo_data.dart';

class SpotifyEmbedCard extends StatelessWidget {
  final String spotifyUrl;

  const SpotifyEmbedCard({super.key, required this.spotifyUrl});

  String _getTrackId() {
    final uri = Uri.parse(spotifyUrl);
    return uri.pathSegments.last;
  }

  String _getEmbedUrl() {
    final trackId = _getTrackId();
    return 'https://open.spotify.com/embed/track/$trackId?utm_source=generator&theme=0';
  }

  Map<String, String>? _getSongData() {
    return SpotifyDemoData.getSongData(spotifyUrl);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final songData = _getSongData();

    return Container(
      width: isMobile ? 250 : 300,
      height: isMobile ? 380 : 420,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Comic-style header with song info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: isMobile ? 16 : 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'SPOTIFY TRACK',
                        style: GoogleFonts.fredoka(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: isMobile ? 16 : 18,
                      ),
                    ],
                  ),
                  if (songData != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      songData['title'] ?? 'Unknown Track',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      songData['artist'] ?? 'Unknown Artist',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 10 : 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),

            // Spotify embed simulation with album art
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.grey[900]!],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Album art placeholder
                    Container(
                      width: isMobile ? 120 : 140,
                      height: isMobile ? 120 : 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: _getGradientColors(),
                        ),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.music_note,
                          size: isMobile ? 40 : 50,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Play button
                    Container(
                      width: isMobile ? 60 : 70,
                      height: isMobile ? 60 : 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          try {
                            if (await canLaunchUrl(Uri.parse(spotifyUrl))) {
                              await launchUrl(
                                Uri.parse(spotifyUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          } catch (e) {
                            // Handle error
                          }
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: isMobile ? 30 : 35,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Play on Spotify',
                      style: GoogleFonts.fredoka(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientColors() {
    final trackId = _getTrackId();
    final hash = trackId.hashCode;

    final colorSets = [
      [Colors.purple[400]!, Colors.pink[400]!],
      [Colors.blue[400]!, Colors.cyan[400]!],
      [Colors.green[400]!, Colors.teal[400]!],
      [Colors.orange[400]!, Colors.red[400]!],
      [Colors.indigo[400]!, Colors.purple[400]!],
      [Colors.teal[400]!, Colors.green[400]!],
    ];

    return colorSets[hash.abs() % colorSets.length];
  }
}
