import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/settings.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class SettingsNotifier extends StateNotifier<Settings> {
  /// Standard constructor
  SettingsNotifier() : super(Settings());

  void setCols(int cols) {
    state = state.copyWith(cols: cols);
  }

  void setRows(int rows) {
    state = state.copyWith(rows: rows);
  }

  void setMinePercentage(int minePerc) {
    state = state.copyWith(minePercentage: minePerc);
  }
}
