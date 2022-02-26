import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/sound_module.dart';
import 'package:ruby_robbery/models/level_model.dart';
import 'package:ruby_robbery/models/tile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PuzzleResult {
  PuzzleResult({
    required this.level,
    this.tiles,
    this.numMoves
  });

  final String level;
  List<Tile>? tiles;
  //time
  int? numMoves;

  @override
  String toString() {
    String string = level.toString();
    if (tiles != null && numMoves != null) {
      string += ';' + tiles.toString() + ';' + numMoves.toString();
    }
    return string;
  }

  static PuzzleResult? fromString(String? string) {
    if (string == null) return null;
    List<String> params = string.split(';');

    PuzzleResult result = PuzzleResult(level: params[0]);
    if (params.length > 1) {
      result.numMoves = params[2] as int?;
      result.tiles = params[1] as List<Tile>?;
    }
    print(result);
    return result;
  }

}

class Preferences {

  static final Preferences _prefs = Preferences._internal();

  late SharedPreferences sharedPreferences;
  bool isLoaded = false;

  int rubies = 0;
  Set<String> unlockedLevels = {};
  Set<String> solvedLevels = {};
  bool purchasedPro = false;
  bool? isLightMode;
  //Locale language;
  String? version;

  // sound volume: 1.0 = max; 0.0 = mute
  double effectVolume = 0.8;
  double backgroundVolume = 0.7;
  bool mute = false;

  PuzzleResult? currentPuzzleState;

  factory Preferences() {
    return _prefs;
  }

  Preferences._internal();

  setRubies(int rubies) {
    this.rubies = rubies;
    sharedPreferences.setInt('rubies', this.rubies);
  }

  addRubies(int rubies) {
    this.rubies += rubies;
    sharedPreferences.setInt('rubies', this.rubies);
  }

  payRubies(int rubies) {
    this.rubies -= rubies;
    sharedPreferences.setInt('rubies', this.rubies);
  }

  getRubies() {
    return rubies;
  }

  setPurchasePro(bool purchased) {
    purchasedPro = purchased;
    sharedPreferences.setBool('is_pro', purchased);
  }

  bool? getIsLightMode() {
    return isLightMode;
  }

  void setIsLightMode(bool isLightMode) {
    this.isLightMode = isLightMode;
    sharedPreferences.setBool('is_lightmode', isLightMode);
  }

  /*Locale getLanguage() {
    return this.language;
  }

  void setLanguage(Locale language) {
    this.language = language;
    sharedPreferences.setString('language', language.toLanguageTag());
  }*/

  void saveUnlockedLevels(Set<String> value) {
    unlockedLevels = value;
    sharedPreferences.setStringList('unlocked_levels', unlockedLevels.toList());
  }

  void saveSolvedLevels(Set<String> value) {
    solvedLevels = value;
    sharedPreferences.setStringList('solved_levels', solvedLevels.toList());
  }

  bool buyLevel(Level level) {
    if (rubies < level.rubyCost) {
      return false;
    }
    payRubies(level.rubyCost);
    unlockedLevels.add(level.id);
    sharedPreferences.setStringList('unlocked_levels', unlockedLevels.toList());
    return true;
  }

  Set<String> getUnlockedLevels() {
    return unlockedLevels;
  }

  Set<String> getSolvedLevels() {
    return solvedLevels;
  }

  void solveLevel(String levelId) {
    solvedLevels.add(levelId);
    sharedPreferences.setStringList('solved_levels', solvedLevels.toList());
  }

  bool isPro() {
    print('isPro? '+purchasedPro.toString());
    return purchasedPro;
  }

  /*
    returns null when no version is set yet
   */
  String? getVersion() {
    return version; // returning null is a valid option
  }

  void setVersion(String newVersion) {
    version = newVersion;
    sharedPreferences.setString('version', newVersion);
  }

  PuzzleResult? getSavedPuzzleResult() {
    return currentPuzzleState;
  }

  void saveCurrentPuzzleState(PuzzleResult state) {
    currentPuzzleState = state;
    sharedPreferences.setString('puzzle_result', state.toString());
  }

  Future<bool> load() async {
    sharedPreferences = await SharedPreferences.getInstance();

    unlockedLevels = {};
    if(sharedPreferences.getStringList('unlocked_levels') != null) {
      unlockedLevels.addAll(sharedPreferences.getStringList('unlocked_levels')!);
    }
    solvedLevels = {};
    if(sharedPreferences.getStringList('solved_levels') != null) {
      solvedLevels.addAll(sharedPreferences.getStringList('solved_levels')!);
    }
    purchasedPro = sharedPreferences.getBool('is_pro') ?? false;
    rubies = sharedPreferences.getInt('rubies') ?? 0;
    version = sharedPreferences.getString('version');
    isLightMode = sharedPreferences.getBool('is_lightmode') ?? (ThemeMode.system == ThemeMode.light);
    // language = getLanguageFromString(sharedPreferences.getString('language')) ?? Locale('de', 'DE'); // TODO default
    currentPuzzleState = PuzzleResult.fromString(sharedPreferences.getString('puzzle_result'));

    effectVolume = sharedPreferences.getDouble('effect_volume') ?? 0.7;
    backgroundVolume = sharedPreferences.getDouble('background_volume') ?? 0.7;
    mute = sharedPreferences.getBool('mute') ?? false;
    return true;
  }

  Locale getLanguageFromString(String string) {
    print('string: ' + string);
    List langStrings = string.split('-');
    return Locale(langStrings.first, langStrings.last);
  }

  double getEffectVolume() {
    return effectVolume;
  }

  void setEffectVolume(double volume) {
    effectVolume = volume;
    sharedPreferences.setDouble('effect_volume', effectVolume);
  }

  double getBackgroundVolume() {
    return backgroundVolume;
  }

  void setBackgroundVolume(double volume) {
    backgroundVolume = volume;
    sharedPreferences.setDouble('background_volume', backgroundVolume);
    SoundModule soundModule = SoundModule();
    soundModule.updateBackgroundMusic();
  }

  bool isMute() {
    return mute;
  }

  void setMute(bool value) {
    mute = value;
    sharedPreferences.setBool('mute', mute);
    SoundModule soundModule = SoundModule();
    soundModule.muteSound(mute);
  }
}
