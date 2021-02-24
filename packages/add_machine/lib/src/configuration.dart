import 'package:meta/meta.dart';
import 'package:infinite_tape/infinite_tape.dart';

import 'instruction.dart';
import 'state_symbol.dart';

class Configuration {
  final int state;
  final Tape tape;
  final Instruction instruction;
  final int index;

  static Configuration get empty => Configuration(
      state: 0,
      tape: Tape(blank: " "),
      instruction: InitialInstruction(),
      index: 0);

  Configuration({
    @required this.state,
    @required this.tape,
    @required this.instruction,
    @required this.index,
  });

  StateSymbol get stateSymbol => StateSymbol(this.state, currentSymbol);
  String get currentSymbol => tape.read();
  bool get isTerminal => instruction is Halt;
}

class TerminalConfiguration<TResult> extends Configuration {
  final TResult result;

  TerminalConfiguration({this.result, Configuration config})
      : super(
            tape: config.tape,
            state: config.state,
            index: config.index,
            instruction: config.instruction);
}
