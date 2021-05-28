import 'package:minesweeper/models/position.dart';

/// Class representing a single block on the playing field of the game.
class Block {
  /// Absolute position of block on field.
  final Position _position;

  /// Indicates whether block is mined or not
  final bool _mine;

  /// Indicates whether block is mined or not
  bool get mine => _mine;

  /// Indicates whether block is fagged or not
  bool flagged = false;

  /// How many mines are on the neighboring 8 blocks
  int _closeMines = 0;

  /// How many mines are on the neighboring 8 blocks
  int get closeMines => _closeMines;

  /// Indicates whether the player already opened this block or not
  bool open = false;

  /// Standard contructor for a block.
  Block({required position, mine = false})
      : _position = position,
        _mine = mine;

  /// List of all neighboring blocks. Convenience getter, so that we do not
  /// have to implement the same logic whenever we need that information
  List<Block> _neighbors(Map<Position, Block> map) {
    final list = <Block>[];
    if (map[Position(_position.x + 0, _position.y + 1)] != null) list.add(map[Position(_position.x + 0, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 1)] != null) list.add(map[Position(_position.x + 1, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 0)] != null) list.add(map[Position(_position.x + 1, _position.y + 0)]!);
    if (map[Position(_position.x + 1, _position.y - 1)] != null) list.add(map[Position(_position.x + 1, _position.y - 1)]!);
    if (map[Position(_position.x + 0, _position.y - 1)] != null) list.add(map[Position(_position.x + 0, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y - 1)] != null) list.add(map[Position(_position.x - 1, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y + 0)] != null) list.add(map[Position(_position.x - 1, _position.y + 0)]!);
    if (map[Position(_position.x - 1, _position.y + 1)] != null) list.add(map[Position(_position.x - 1, _position.y + 1)]!);
    return list;
  }

  /// Updates the count of mines within the neighboring fields
  void updateCloseMines(Map<Position, Block> map) {
    _neighbors(map).forEach((block) {
      if (block.mine) _closeMines++;
    });
  }

  /// Reveals (opens) this block. If this block has no mines in its neighboring
  /// fields, it will reveal its neighbors too.
  void reveal(Map<Position, Block> map) {
    open = true;
    if (mine) return;
    if (closeMines == 0) {
      _neighbors(map).forEach((block) {
        if (!block.open) {
          block.reveal(map);
        }
      });
    }
  }
}
