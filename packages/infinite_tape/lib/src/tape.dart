import 'dart:collection';

/// Infinite tape that can perform a single operation at once:
/// - Read the symbol on the head with [read()].
/// - Move the head to the right with [moveRight()].
/// - Move the head to the left with [moveLeft()].
/// - Write on the head position with [write(symbol)]
class Tape {
  ListQueue<String> _left;
  ListQueue<String> _right;

  /// A [String] representing the blank symbol of the tape.
  ///
  /// This is added to the internal list when [moveLeft()] or [moveRight()]
  /// is called and there is no next element to simulate an infinite tape.
  final String blank;

  /// Creates a new [Tape]. The head points to the first element of the
  /// [right] input, which is a [blank] symbol by default.
  ///
  /// The following example creates the tape ...|*|||..., where ... denotes infinity
  /// and with the head on the third '|'.
  /// ```
  /// var blank = "*";
  /// var s = "|";
  /// List<String> left = [s, blank, s];
  /// List<String> right = [s, s];
  /// var tape = new Tape(left: left, right: right, blank: blank);
  /// ```
  Tape({
    Iterable<String> left = const [],
    Iterable<String> right = const [],
    this.blank,
  }) {
    _left = ListQueue.of(left);
    if (right.isEmpty) {
      _right = ListQueue();
      _right.add(blank);
    } else {
      _right = ListQueue.of(right);
    }
  }

  /// Returns the symbol under the head.
  String read() => _right.first;

  /// Writes a symbol [s] on the current head position.
  void write(String s) {
    _right.removeFirst();
    _right.addFirst(s);
  }

  /// Moves the head one unit to the right.
  ///
  /// If there is no next element, adds the [blank]
  /// to the list to simulate an infinite size.
  void moveRight() {
    var elem = _right.removeFirst();
    _left.addLast(elem);
    if (_right.isEmpty) {
      _right.add(blank);
    }
  }

  /// Moves the head one unit to the left.
  ///
  /// If there is no next element, adds the [blank]
  /// to the list to simulate an infinite size.
  void moveLeft() {
    var elem = _left.isEmpty ? blank : _left.removeLast();
    _right.addFirst(elem);
  }

  /// Creates a copy of this instance
  Tape copyWith({String blank, Iterable<String> left, Iterable<String> right}) {
    return Tape(
      blank: blank ?? this.blank,
      left: left ?? _left,
      right: right ?? _right,
    );
  }

  List<String> toList() {
    return _left.toList()..addAll(_right);
  }

  /// Returns the value of the cell at position [i] relative to the head
  String readAt(int i) {
    if (i < 0) {
      var index = i + _left.length;
      return index < 0 ? blank : _left.elementAt(index);
    } else {
      return i >= _right.length ? blank : _right.elementAt(i);
    }
  }

  bool isHead(int i) {
    return absoluteToRelative(i) == 0;
  }

  int absoluteToRelative(int i) {
    return i - _left.length;
  }

  int get absoluteIndex => _left.length;

  @override
  String toString() {
    var left = _left.toList().toString();
    var middle = _right.first;
    var right = _right.skip(1).toList().toString();
    return "[$left $middle $right]";
  }
}
