import 'package:ruby_theft/models/models.dart';

Position getDraggedPositionOfTile(Tile tile, Position newPosition) {
  // TODO get position of drag start. meanwhile get tile adjacent to newPosition
  for (var position in tile.currentPositions) {
    if (isAdjacent(position, newPosition)) {
      return position;
    }
  }
  return const Position(x: 0, y: 0); // TODO better error handling
}

/// Determines if two positions are adjacent on the board
bool isAdjacent(Position pos1, Position pos2) {
  if (pos1.x != pos2.x && pos1.y != pos2.y) return false;
  if (pos1.x == pos2.x) {
    return (pos1.y - pos2.y).abs() <= 1;
  } else if (pos1.y == pos2.y) {
    return (pos1.x - pos2.x).abs() <= 1;
  }
  return false;
}


Level? getNextUnsolvedLevel(String levelId, Levels levels, Set<String> solvedLevels, Set<String> unlockedLevels) {
  int startIndex = levels.getAllLevels().indexOf(levels.getLevelById(levelId));
  Level? nextLevel;
  while (nextLevel == null) {
    startIndex ++;
    if (startIndex > levels.getAllLevels().length) return null;
    Level level = levels.getByIndex(startIndex);
    if (!solvedLevels.contains(level.id) && level.unlocked == true || unlockedLevels.contains(level.id)) nextLevel = level;
  }
  return nextLevel;
}
