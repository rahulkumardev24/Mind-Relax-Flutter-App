import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> playSound(String audioUrl) async {
    try {
      await _audioPlayer.play(UrlSource(audioUrl));
      _isPlaying = true;
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> pauseSound() async {
    await _audioPlayer.pause();
    _isPlaying = false;
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}