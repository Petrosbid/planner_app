import 'package:audioplayers/audioplayers.dart';

import 'ambient_sound_type.dart';

class AudioPlayerService {
  AudioPlayerService._();

  static final AudioPlayerService instance = AudioPlayerService._();

  final AudioPlayer _player = AudioPlayer();

  AmbientSoundType? _currentSound;

  String _assetFor(AmbientSoundType sound) {
    switch (sound) {
      case AmbientSoundType.rain:
        return 'audio/rain.mp3';
      case AmbientSoundType.forest:
        return 'audio/forest.mp3';
      case AmbientSoundType.cafe:
        return 'audio/cafe.mp3';
      case AmbientSoundType.waves:
        return 'audio/waves.mp3';
      case AmbientSoundType.whiteNoise:
        return 'audio/white_noise.mp3';
      case AmbientSoundType.zenChimes:
        return 'audio/zen_chimes.mp3';
    }
  }

  Future<void> play(AmbientSoundType sound, double volumePercent) async {
    final normalized = volumePercent.clamp(0, 100).toDouble() / 100.0;
    final asset = _assetFor(sound);

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(normalized);

    if (_currentSound == sound) {
      final state = _player.state;
      if (state == PlayerState.playing) return;
      await _player.resume();
      return;
    }

    _currentSound = sound;
    await _player.play(AssetSource(asset));
  }

  Future<void> stop() async {
    _currentSound = null;
    await _player.stop();
  }

  Future<void> setVolume(double volumePercent) async {
    final normalized = volumePercent.clamp(0, 100).toDouble() / 100.0;
    await _player.setVolume(normalized);
  }
}
