import 'package:flutter/material.dart';
import 'package:ruby_theft/models/tile_model.dart';
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
  List<String> unlockedLevels = [];
  List<String> solvedLevels = [];
  bool purchasedPro = false;
  bool? isLightMode;
  //Locale language;
  String? version;

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

  void saveUnlockedLevels(List<String> value) {
    unlockedLevels = value;
    sharedPreferences.setStringList('unlocked_levels', unlockedLevels);
  }

  void saveSolvedLevels(List<String> value) {
    solvedLevels = value;
    sharedPreferences.setStringList('solved_levels', solvedLevels);
  }

  List<String> getUnlockedLevels() {
    return unlockedLevels;
  }

  List<String> getSolvedLevels() {
    return solvedLevels;
  }

  void solveLevel(String levelId) {
    solvedLevels.add(levelId);
    sharedPreferences.setStringList('solved_levels', solvedLevels);

    saveCurrentPuzzleState(PuzzleResult(level: levelId));
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

    unlockedLevels = sharedPreferences.getStringList('unlocked_levels') ?? [];
    solvedLevels = sharedPreferences.getStringList('solved_levels') ?? [];
    purchasedPro = sharedPreferences.getBool('is_pro') ?? false;
    version = sharedPreferences.getString('version');
    isLightMode = sharedPreferences.getBool('is_lightmode') ?? (ThemeMode.system == ThemeMode.light);
    // language = getLanguageFromString(sharedPreferences.getString('language')) ?? Locale('de', 'DE'); // TODO default
    currentPuzzleState = PuzzleResult.fromString(sharedPreferences.getString('puzzle_result'));
    return true;
  }

  Locale getLanguageFromString(String string) {
    print('string: ' + string);
    List langStrings = string.split('-');
    return Locale(langStrings.first, langStrings.last);
  }
}
