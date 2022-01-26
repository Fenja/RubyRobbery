import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'models.dart';

class Levels {
  static final Levels _levels = new Levels._internal();

  List<Level> _levelList = [];

  factory Levels() {
    return _levels;
  }

  Levels._internal() {
    _load();
  }

  List<Level> getAllLevels() {
    return _levelList;
  }

  Level getLevelById(String id) {
    return _levelList.firstWhere((level) => level.id == id);
  }

  Future<bool> _load() async {
    if (kDebugMode) {
      print('load levels');
    }
    String data = await rootBundle.loadString(
        'assets/data/levels.json');
    final _result = json.decode(data).cast<Map<String,dynamic>>();
    var _list = _result.map<Level>((json) => Level.fromJson(json)).toList();

    _list.forEach((Level value) {
      _levelList.add(value);
    });

    return true;
  }

  Level getByIndex(int startIndex) {
    return _levelList[startIndex];
  }

  Level? getNextUnsolvedLevel(String levelId, Set<String> solvedLevels) {
    int startIndex = _levelList.indexOf(getLevelById(levelId));
    Level? nextLevel;
    while (nextLevel == null) {
      startIndex ++;
      Level level = getByIndex(startIndex);
      if (!solvedLevels.contains(level.id)) nextLevel = level;
      // TODO do not return locked levels!!!
    }
    return nextLevel;
  }
}
