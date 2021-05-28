import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';
import 'package:minesweeper/notifiers/settings_notifier.dart';

/// Global variable holding a reference to our state object
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());

/// Global variable holding a reference to an int indicating number of columns in the game
final globalSettingsNotifier = StateNotifierProvider((ref) => SettingsNotifier());
