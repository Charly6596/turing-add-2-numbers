import 'package:infinite_tape/infinite_tape.dart';

import 'configuration.dart';
import 'instruction.dart';
import 'machine.dart';
import 'state_symbol.dart';
import 'table_entry.dart';

class SumMachine extends Machine {
  static const String blank = " ";
  static const String symbol = "|";

  int _index;

  final List<Configuration> _history = [];

  @override
  final List<String> alphabet = [symbol];

  @override
  final String blankSymbol = blank;

  @override
  final List<int> states = [0, 1, 2, 3, 4];

  @override
  final Map<StateSymbol, TableEntry> table = {
    StateSymbol(0, blank): TableEntry(MoveLeft(), 1),
    StateSymbol(0, symbol): TableEntry(MoveLeft(), 1),
    StateSymbol(1, blank): TableEntry(Write(symbol), 2),
    StateSymbol(1, symbol): TableEntry(MoveLeft(), 1),
    StateSymbol(2, blank): TableEntry(MoveLeft(), 3),
    StateSymbol(2, symbol): TableEntry(MoveRight(), 2),
    StateSymbol(3, blank): TableEntry(MoveLeft(), 4),
    StateSymbol(3, symbol): TableEntry(Write(blank), 3),
    StateSymbol(4, blank): TableEntry(Halt(), 4),
    StateSymbol(4, symbol): TableEntry(Write(blank), 4),
  };

  Configuration initialConfiguration;

  SumMachine() {
    checkTable();
  }

  void initialize(int n1, int n2) {
    var left = symbol.toListRepeat(n1 + 1)
      ..add(blank)
      ..addAll(symbol.toListRepeat(n2 + 1));

    initialConfiguration = Configuration(
        state: 0,
        index: 0,
        instruction: InitialInstruction(),
        tape: Tape(
          left: left,
          blank: blank,
        ));

    _initializeHistory(initialConfiguration);
  }

  void _initializeHistory(Configuration c) {
    reset();
    _history.add(c);
  }

  Configuration next() {
    _ensureInitialized();

    if (_index + 1 < _history.length) {
      return _history[++_index];
    }

    return transitNext(_history[_index]);
  }

  Configuration previous() {
    _ensureInitialized();

    if (_index - 1 >= 0) {
      return _history[--_index];
    }

    return null;
  }

  @override
  Configuration transitNext(Configuration c) {
    _ensureInitialized();
    var config = super.transitNext(c);
    _history.add(config);
    _index++;
    return config;
  }

  void _ensureInitialized() {
    if (!isInitialized) {
      throw StateError(
          "AddMachine not initialized. Did you call [initialize(int, int)]?");
    }
  }

  void reset() {
    _history.clear();
    _index = 0;
  }

  bool get hasNext => isInitialized && !_history[_index].isTerminal;
  bool get hasPrevious => isInitialized && _index > 0;
  bool get isInitialized => initialConfiguration != null && _history.isNotEmpty;
}
