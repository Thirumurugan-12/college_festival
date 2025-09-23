import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

class SpotifyIframeCard extends StatefulWidget {
  final String spotifyUrl;

  const SpotifyIframeCard({super.key, required this.spotifyUrl});

  @override
  State<SpotifyIframeCard> createState() => _SpotifyIframeCardState();
}

class _SpotifyIframeCardState extends State<SpotifyIframeCard> {
  late String embedUrl;
  late String trackId;
  late String viewId;

  @override
  void initState() {
    super.initState();
    _setupIframe();
  }

  void _setupIframe() {
    // Extract track ID from Spotify URL
    final uri = Uri.parse(widget.spotifyUrl);
    trackId = uri.pathSegments.last;

    // Create Spotify embed URL
    embedUrl =
        'https://open.spotify.com/embed/track/$trackId?utm_source=generator&theme=0';

    // Create unique view ID
    viewId = 'spotify-iframe-$trackId';

    // Register the iframe
    _registerIframe();
  }

  void _registerIframe() {
    // Create iframe element
    final iframe = html.IFrameElement()
      ..src = embedUrl
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.borderRadius = '8px'
      ..allow =
          'autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture';

    // Register the iframe as a platform view
    ui_web.platformViewRegistry.registerViewFactory(viewId, (int id) => iframe);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      width: isMobile ? 300 : 350,
      height: isMobile ? 300 : 350,
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
            // Comic-style header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 8 : 10,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: isMobile ? 18 : 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'MUSIC CARDS',
                    style: GoogleFonts.fredoka(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: isMobile ? 18 : 20,
                  ),
                ],
              ),
            ),

            // Spotify iframe
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: HtmlElementView(viewType: viewId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
