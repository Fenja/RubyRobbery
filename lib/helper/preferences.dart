import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    sharedPreferences.setStringList('unlocked_levels', value);
  }

  void saveSolvedLevels(List<String> value) {
    sharedPreferences.setStringList('saved_levels', value);
  }

  List<String> getUnlockedLevels() {
    return sharedPreferences.getStringList('unlocked_levels') ?? [];
  }

  List<String> getSolvedLevels() {
    return sharedPreferences.getStringList('solved_levels') ?? [];
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

  Future<bool> load() async {
    sharedPreferences = await SharedPreferences.getInstance();

    unlockedLevels = sharedPreferences.getStringList('unlocked_levels') ?? [];
    solvedLevels = sharedPreferences.getStringList('solved_levels') ?? [];
    purchasedPro = sharedPreferences.getBool('is_pro') ?? false;
    version = sharedPreferences.getString('version');
    isLightMode = sharedPreferences.getBool('is_lightmode') ?? (ThemeMode.system == ThemeMode.light);
    // language = getLanguageFromString(sharedPreferences.getString('language')) ?? Locale('de', 'DE'); // TODO default

    return true;
  }

  Locale getLanguageFromString(String string) {
    print('string: ' + string);
    List langStrings = string.split('-');
    return Locale(langStrings.first, langStrings.last);
  }
}
