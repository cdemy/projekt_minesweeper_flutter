import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/settings.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';

/// Welcome Screen for the app
class StartScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    final settingsNotifier = useProvider(globalSettingsNotifier);
    final settings = useProvider(globalSettingsNotifier.state);
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter-Minesweeper')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const Text(
              'Spiel-Einstellungen',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Anzahl Reihen: ${settings.rows}'),
            ),
            Slider(
              value: settings.rows.toDouble(),
              min: Settings.stdRowsMin.toDouble(),
              max: Settings.stdRowsMax.toDouble(),
              label: 'Reihen: ${settings.rows}',
              onChanged: (newValue) {
                settingsNotifier.setRows(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Anzahl Spalten: ${settings.cols}'),
            ),
            Slider(
              value: settings.cols.toDouble(),
              min: Settings.stdColsMin.toDouble(),
              max: Settings.stdColsMax.toDouble(),
              label: 'Spalten: ${settings.cols}}',
              onChanged: (newValue) {
                settingsNotifier.setCols(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Minen-Anteil(%): ${settings.minePercentage} %'),
            ),
            Slider(
              value: settings.minePercentage.toDouble(),
              min: Settings.stdMinePercentageMin.toDouble(),
              max: Settings.stdMinePercentageMax.toDouble(),
              label: 'Minen-Anteil: ${settings.minePercentage} %',
              onChanged: (newValue) {
                settingsNotifier.setMinePercentage(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: ElevatedButton(
                child: const Text(
                  'Spiel starten',
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  fieldNotifier.create(numRows: settings.rows, numCols: settings.cols, minePercentage: settings.minePercentage);
                  Navigator.pushNamed(context, '/match');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
