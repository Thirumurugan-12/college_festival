// Demo data for Spotify cards when API is not available
class SpotifyDemoData {
  static const List<Map<String, String>> featuredSongs = [
    {
      'id': '4iV5W9uYEdYUVa79Axb7Rh',
      'title': 'Never Gonna Give You Up',
      'artist': 'Rick Astley',
      'thumbnail':
          'https://via.placeholder.com/300x300/FF6B6B/FFFFFF?text=Rick+Astley',
      'url': 'https://open.spotify.com/track/4iV5W9uYEdYUVa79Axb7Rh',
    },
    {
      'id': '60nZcImufyMA1MKQY3dcCH',
      'title': 'Hotel California',
      'artist': 'Eagles',
      'thumbnail':
          'https://via.placeholder.com/300x300/4ECDC4/FFFFFF?text=Eagles',
      'url': 'https://open.spotify.com/track/60nZcImufyMA1MKQY3dcCH',
    },
    {
      'id': '7qiZfU4dY1lWllzX7mPBI3',
      'title': 'Shape of You',
      'artist': 'Ed Sheeran',
      'thumbnail':
          'https://via.placeholder.com/300x300/45B7D1/FFFFFF?text=Ed+Sheeran',
      'url': 'https://open.spotify.com/track/7qiZfU4dY1lWllzX7mPBI3',
    },
    {
      'id': '1mea3bSkSGXuIRvnydlB5b',
      'title': 'Levitating',
      'artist': 'Dua Lipa',
      'thumbnail':
          'https://via.placeholder.com/300x300/F7DC6F/000000?text=Dua+Lipa',
      'url': 'https://open.spotify.com/track/1mea3bSkSGXuIRvnydlB5b',
    },
    {
      'id': '11dFghVXANMlKmJXsNCbNl',
      'title': 'Rather Be',
      'artist': 'Clean Bandit feat. Jess Glynne',
      'thumbnail':
          'https://via.placeholder.com/300x300/BB8FCE/FFFFFF?text=Clean+Bandit',
      'url': 'https://open.spotify.com/track/11dFghVXANMlKmJXsNCbNl',
    },
    {
      'id': '2WfaOiMkCvy7F5fcp2zZ8L',
      'title': 'Blinding Lights',
      'artist': 'The Weeknd',
      'thumbnail':
          'https://via.placeholder.com/300x300/85C1E9/000000?text=The+Weeknd',
      'url': 'https://open.spotify.com/track/2WfaOiMkCvy7F5fcp2zZ8L',
    },
  ];

  static Map<String, String>? getSongData(String spotifyUrl) {
    for (final song in featuredSongs) {
      if (spotifyUrl.contains(song['id']!)) {
        return song;
      }
    }
    return null;
  }
}
