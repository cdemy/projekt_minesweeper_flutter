import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

void main() {
  test('Field should be created and have the right number of fields/mines', () {
    final fieldNotifier = FieldNotifier();
    // ignore: cascade_invocations
    fieldNotifier.create(numRows: 10, numCols: 10, minePercentage: 20);
    // ignore: invalid_use_of_protected_member
    final state = fieldNotifier.state;
    var numMines = 0;
    var numFields = 0;
    var numFlags = 0;
    state.map.forEach((pos, block) {
      numFields++;
      if (block.mine) numMines++;
      if (block.flagged) numFlags++;
    });
    expect(numMines, 20);
    expect(numFields, 100);
    expect(numFlags, 0);
  });
}
