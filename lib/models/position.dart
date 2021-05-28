import 'package:flutter/foundation.dart';

/// Defines an absolute position (of a block)
@immutable
class Position {
  /// Horizontal component of position, from 0 (left) to numCols-1 (right)
  final int _x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  final int _y;

  /// Standard constructor for position
  const Position(this._x, this._y);

  /// Horizontal component of position, from 0 (left) to numCols-1 (right)
  int get x => _x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  int get y => _y;

  /// Overridden toString method, for better output instead of "Instance of <Posiion>"
  @override
  String toString() => 'Position($x/$y)';

  @override
  bool operator ==(Object o) => o is Position && o.x == _x && o.y == _y;

  @override
  int get hashCode => 1000 * x + y;
}
