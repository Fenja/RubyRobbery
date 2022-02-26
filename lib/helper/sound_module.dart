import 'package:audioplayers/audioplayers.dart';
import 'package:ruby_robbery/helper/preferences.dart';

class SoundModule {

  static final SoundModule _soundModule = SoundModule._internal();

  Preferences preferences = Preferences();
  bool mute = false;

  late AudioCache effectCache;
  late AudioCache backgroundCache;
  late AudioPlayer backgroundPlayer;

  String LEVEL_UNLOCK_SOUND = "audio/mixkit-casino-bling-achievement-2067.wav";
  String LEVEL_COMPLETE_SOUND = "audio/mixkit-game-level-completed-2059.wav";
  String TILE_MOVED_SOUND = "audio/mixkit-bonus-earned-in-video-game-2058.wav";

  String BACKGROUND_MUSIC = "audio/FenjaMusikSlide.wav";

  factory SoundModule() {
    return _soundModule;
  }

  SoundModule._internal() {
    effectCache = AudioCache();
    backgroundCache = AudioCache();
    mute = preferences.isMute();
  }


  void startBackgroundMusic() async {
    backgroundPlayer = await backgroundCache.loop(BACKGROUND_MUSIC, volume: preferences.getBackgroundVolume());
  }

  void muteBackground() async {
    await backgroundPlayer.setVolume(0.0);
    preferences.setBackgroundVolume(0.0);
  }

  void playSound(String sound) async {
    if (mute) return;
    try {
      await effectCache.play( sound, volume: preferences.getEffectVolume() );
    } catch (err) {
      print(err);
    }
  }

  void updateBackgroundMusic() async {
    backgroundPlayer.setVolume(preferences.getBackgroundVolume());
  }

  void muteSound() {
    mute = true;
    backgroundPlayer.setVolume(0.0);
  }
}
