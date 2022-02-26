import 'package:audioplayers/audioplayers.dart';
import 'package:ruby_robbery/helper/preferences.dart';

class SoundModule {

  static final SoundModule _soundModule = SoundModule._internal();

  Preferences preferences = Preferences();

  late AudioCache audioPlayer;
  late AudioCache backgroundPlayer;

  String LEVEL_UNLOCK_SOUND = "audio/mixkit-casino-bling-achievement-2067.wav";
  String LEVEL_COMPLETE_SOUND = "audio/mixkit-game-level-completed-2059.wav";
  String TILE_MOVED_SOUND = "audio/mixkit-bonus-earned-in-video-game-2058.wav";

  String BACKGROUND_MUSIC = "audio/FenjaMusikSlide.wav";

  factory SoundModule() {
    return _soundModule;
  }

  SoundModule._internal() {
    audioPlayer = AudioCache();
    backgroundPlayer = AudioCache();
  }


  void startBackgroundMusic() async {
    await backgroundPlayer.loop(BACKGROUND_MUSIC, volume: preferences.getBackgroundVolume());
  }

  void stopBackgroundMusic() async {
    await backgroundPlayer.clearAll();
  }

  void playSound(String sound) async {
    try {
      await audioPlayer.play( sound, volume: preferences.getEffectVolume() );
    } catch (err) {
      print(err);
    }
  }
}
