import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/game_status.dart';
import 'package:minesweeper/models/position.dart';

@immutable

/// Class representing the game field
class Field {
/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  /// A map (associative array), linking each Position to its corresponding block.
  late final Map<Position, Block> map;

  /// Number of mines on the field
  final int _mines;

  /// Percentage of mines on the field
  final int _minePercentage;

  /// Number of rows
  final int _numRows;

  /// Number of columns
  final int _numCols;

  /// The status of the game
  late final GameStatus _gameStatus;

/*-----------------------------------------------------------------------------\
| Getters and Setters for private attributes                                   |
\-----------------------------------------------------------------------------*/
  /// Number of mines on the field
  int get mines => _mines;

  /// Number of rows
  int get numRows => _numRows;

  /// Number of columns
  int get numCols => _numCols;

  /// The status of the game
  GameStatus get gameStatus => _gameStatus;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  /// Constructs a game field for our game
  /// It is an empty field. We just use it for instantiating the game in
  /// lib/notifiers/_notfifiers.dart. It will be reconstructed many times using
  /// the .withArguments constructor.
  Field()
      : map = {},
        _mines = 0,
        _minePercentage = 0,
        _numRows = 0,
        _numCols = 0,
        _gameStatus = GameStatus.gameRunning;

  /// Constructs a game field for our game
  Field.withArguments({required numRows, required numCols, required minePercentage})
      : _numRows = numRows,
        _numCols = numCols,
        _minePercentage = minePercentage,
        _mines = (numRows * numCols * minePercentage) ~/ 100,
        _gameStatus = GameStatus.gameRunning {
    final newMap = <Position, Block>{};
    var leftMines = _mines;
    var leftFields = _numRows * _numCols;
    final rng = math.Random();
    for (var col = 0; col < _numCols; col++) {
      for (var row = 0; row < _numRows; row++) {
        final pos = Position(col, row);
        final prob = (100 * leftMines) ~/ leftFields;
        final mine = rng.nextInt(100) < prob;
        newMap[pos] = Block(position: pos, mine: mine);
        if (mine) {
          leftMines--;
        }
        leftFields--;
      }
    }
    // Let each field calculate its nearby mines
    newMap.forEach((pos, block) {
      block.updateCloseMines(newMap);
    });
    map = newMap;
  }

  // ignore: prefer_const_constructors_in_immutables
  Field._internal({
    required this.map,
    required mines,
    required minePercentage,
    required numRows,
    required numCols,
    required gameStatus,
  })   : _minePercentage = minePercentage,
        _mines = mines,
        _numRows = numRows,
        _numCols = numCols {
    _gameStatus = _calculateGameStatus();
  }

/*-----------------------------------------------------------------------------\
| Methods                                                                      |
\-----------------------------------------------------------------------------*/
  /// Returns new Field object, which is a copy of this object, but with
  /// some differences specified when calling this method.
  Field copyWith({Map<Position, Block>? map, int? minePercentage, int? mines, int? numRows, int? numCols, GameStatus? gameStatus}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? _mines,
        minePercentage: minePercentage ?? _minePercentage,
        numRows: numRows ?? _numRows,
        numCols: numCols ?? _numCols,
        gameStatus: gameStatus ?? _gameStatus,
      );

  GameStatus _calculateGameStatus() {
    var status = GameStatus.gameWon;
    for (var pos in map.keys) {
      final block = map[pos]!;
      if (block.mine && block.open) {
        for (var block2 in map.values) {
          if (block2.mine) {
            block2.open = true;
          }
        }
        return GameStatus.gameLost;
      }
      if (!block.mine && !block.open) {
        status = GameStatus.gameRunning;
      }
    }
    // If the game is won now, we open all fields that are still closed
    if (status == GameStatus.gameWon) {
      for (var block in map.values) {
        if (block.mine && !block.open) block.open = true;
      }
    }
    return status;
  }

/*-----------------------------------------------------------------------------\
| Fake getters                                                                 |
\-----------------------------------------------------------------------------*/
  /// Number of flags set on the field
  int get numberOfFlagsSet {
    var flags = 0;
    map.forEach((pos, block) {
      if (block.flagged) flags++;
    });
    return flags;
  }

  /// Number of flags still to be places
  /// The number is limited to the number of mines on the field
  int get numberOfFlagsLeft => _mines - numberOfFlagsSet;
}
