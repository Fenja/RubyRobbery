import 'package:ruby_theft/models/models.dart';

class Level {
  Level(this.id) {
    List<String> levelString = loadLevelString(id).split(';');
    nameKey = levelString[1];
    dimension = int.parse(levelString[2]);
    goal = _position(levelString[3]);
    hasPearls = levelString[4] == 'true';
    unlocked = levelString[5] == 'true';
    difficulty = int.parse(levelString[6]);
    rubyReward = int.parse(levelString[7]);
    rubyRepeat = int.parse(levelString[8]);
    rubyCost = int.parse(levelString[9]);
    tiles = [];
    for (int i = 10; i < levelString.length; i++) {
      List<String> posString = levelString[i].split(',');
      List<Position> positions = [];
      for (int j = 1; j < posString.length; j++) {
        positions.add(_position(posString[j]));
      }

      tiles.add(
        Tile(
          id: posString[0],
          type: _type(posString[0]),
          currentPositions: positions,
        )
      );
    }
  }

  final int id;
  late String nameKey;
  late int dimension;
  late Position goal;
  late List<Tile> tiles;
  late bool hasPearls;

  late bool unlocked;
  late int difficulty;
  late int rubyReward; // reward for first solve
  late int rubyRepeat; // reward for following solves
  late int rubyCost; // cost to unlock level


  /// id;nameKey;dimension;goalPos(x.y);hasPearls;unlocked;difficulty;rubyReward;rubyRepeat;rubyCost;
  /// tiles(id,((x.y),(x.y))
  String loadLevelString(int id) {
    return '0;level_0;3;(2.2);false;true;0;5;0;0;r,(0.0);d1,(1.1);d2,(1.0),(2.0);b1,(1.2)';
    //return '1;level_0;3;(2.2);false;true;0;5;0;0;r,(0.0);d1,(1.1);d2,(1.0),(2.0);b1,(0.2),(1.2)';
  }

  TileType _type(String id) {
    if (id == 'r') return TileType.ruby;
    else if (id.startsWith('b')) return TileType.blocker;
    else if (id.startsWith('d')) return TileType.diamond;
    else if (id.startsWith('p')) return TileType.pearl;
    else return TileType.diamond;
  }

  Position _position(String posString) {
    posString = posString.substring(1,posString.length-1); // remove brackets
    List<String> pos = posString.split('.');
    return Position(x: int.parse(pos.first), y: int.parse(pos.last));
  }
}
