import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';
import 'package:minesweeper/models/game_status.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class FieldNotifier extends StateNotifier<Field> {
  /// Standard constructor
  FieldNotifier() : super(Field());

  /// Creates a new playing field ... just by instantiating a new state
  /// with a new playing field
  void create({required int numRows, required int numCols, required int minePercentage}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, minePercentage: minePercentage);
  }

  /// Is triggered by users clicking on a certain block in the game (MatchScreen)
  // ignore: avoid_positional_boolean_parameters
  void handleClick(Block block, bool flagMode) {
    if (state.gameStatus != GameStatus.gameRunning) return;
    if (flagMode) {
      block.flagged = !block.flagged;
      state = state.copyWith();
      return;
    }
    if (block.flagged) return;
    if (block.open) return;
    block.reveal(state.map);
    state = state.copyWith();
  }
}
