class Meditation {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final int duration;
  final String imageUrl;
  final String audioUrl;
  final String category;
  final double rating;

  Meditation({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.duration,
    required this.imageUrl,
    required this.audioUrl,
    required this.category,
    this.rating = 4.5,
  });
}

class MeditationData {
  static List<Meditation> meditations = [
    Meditation(
      id: '1',
      title: 'Morning Calm',
      description: 'Start your day with peace and clarity',
      instructor: 'Sarah Wilson',
      duration: 600,
      imageUrl: 'assets/images/morning_meditation.jpg',
      audioUrl: 'assets/audio/morning_calm.mp3',
      category: 'Morning',
      rating: 4.8,
    ),
    Meditation(
      id: '2',
      title: 'Sleep Deeply',
      description: 'Gentle guidance into restful sleep',
      instructor: 'Michael Chen',
      duration: 1200,
      imageUrl: 'assets/images/sleep_meditation.jpg',
      audioUrl: 'assets/audio/sleep_deeply.mp3',
      category: 'Sleep',
      rating: 4.9,
    ),
    Meditation(
      id: '3',
      title: 'Anxiety Relief',
      description: 'Release tension and find calm',
      instructor: 'Dr. Emma Roberts',
      duration: 900,
      imageUrl: 'assets/images/anxiety_relief.jpg',
      audioUrl: 'assets/audio/anxiety_relief.mp3',
      category: 'Stress',
      rating: 4.7,
    ),
    Meditation(
      id: '4',
      title: 'Focus Boost',
      description: 'Enhance concentration and clarity',
      instructor: 'James Kumar',
      duration: 480,
      imageUrl: 'assets/images/focus_boost.jpg',
      audioUrl: 'assets/audio/focus_boost.mp3',
      category: 'Focus',
      rating: 4.6,
    ),
  ];
}