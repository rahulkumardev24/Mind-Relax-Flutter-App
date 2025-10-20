class Sound {
  final String id;
  final String title;
  final String category;
  final String icon;
  final String audioUrl;
  final bool isFavorite;

  Sound({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.audioUrl,
    this.isFavorite = false,
  });
}

class SoundData {
  static List<Sound> sounds = [
    // Nature Sounds
    Sound(
      id: '1',
      title: 'Rain',
      category: 'Nature',
      icon: '🌧️',
      audioUrl: 'assets/audio/rain.mp3',
    ),
    Sound(
      id: '2',
      title: 'Ocean Waves',
      category: 'Nature',
      icon: '🌊',
      audioUrl: 'assets/audio/ocean.mp3',
    ),
    Sound(
      id: '3',
      title: 'Forest',
      category: 'Nature',
      icon: '🌲',
      audioUrl: 'assets/audio/forest.mp3',
    ),
    Sound(
      id: '4',
      title: 'Thunderstorm',
      category: 'Nature',
      icon: '⛈️',
      audioUrl: 'assets/audio/thunderstorm.mp3',
    ),

    // Ambient Sounds
    Sound(
      id: '5',
      title: 'White Noise',
      category: 'Ambient',
      icon: '📻',
      audioUrl: 'assets/audio/white_noise.mp3',
    ),
    Sound(
      id: '6',
      title: 'Pink Noise',
      category: 'Ambient',
      icon: '🎵',
      audioUrl: 'assets/audio/pink_noise.mp3',
    ),

    // Instruments
    Sound(
      id: '7',
      title: 'Piano',
      category: 'Instruments',
      icon: '🎹',
      audioUrl: 'assets/audio/piano.mp3',
    ),
    Sound(
      id: '8',
      title: 'Flute',
      category: 'Instruments',
      icon: '🎶',
      audioUrl: 'assets/audio/flute.mp3',
    ),
  ];
}