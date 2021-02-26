import 'package:infinite_tape/infinite_tape.dart';

import 'configuration.dart';
import 'instruction.dart';
import 'machine.dart';
import 'state_symbol.dart';
import 'table_entry.dart';

class SucessorSettings extends Machine {
  static const String _blank = " ";
  static const String _symbol = "+";
  final List<String> alphabet = [_symbol];
  final List<int> states = [7, 3, 5];

  final Map<StateSymbol, TableEntry> table = {
    StateSymbol(7, _blank): TableEntry(Write(_symbol), 3),
    StateSymbol(7, _symbol): TableEntry(MoveRight(), 7),
    StateSymbol(3, _blank): TableEntry(MoveRight(), 5),
    StateSymbol(3, _symbol): TableEntry(MoveRight(), 5),
    StateSymbol(5, _blank): TableEntry(Halt(), 5),
    StateSymbol(5, _symbol): TableEntry(Halt(), 5),
  };

  final int n;
  Tape _initialTape;

  SucessorSettings(this.n) {
    var str = _symbol.toListRepeat(n + 1);
    _initialTape = Tape(left: str, blank: _blank);
  }

  Configuration get initialConfiguration => Configuration(
        state: states[0],
        index: 0,
        tape: _initialTape,
        instruction: InitialInstruction(),
      );

  String get blankSymbol => _blank;
}
