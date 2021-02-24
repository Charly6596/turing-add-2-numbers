import 'package:infinite_tape/infinite_tape.dart';
import 'package:meta/meta.dart';

import 'configuration.dart';
import 'instruction.dart';
import 'state_symbol.dart';
import 'table_entry.dart';

/// A Turing Machine implementation.
/// Has a table containing the alphabet, set of states and the instruction
/// and transition functions to work with.
abstract class Machine {
  /// Represents the machine
  Map<StateSymbol, TableEntry> get table;

  /// Represents the empty symbol
  String get blankSymbol;

  /// Non-empty finite set of symbols used by this machine
  List<String> get alphabet;

  /// Non-empty finite set of states used by this machine
  List<int> get states;

  /// The instruction function.
  ///
  /// Returns the instruction to execute given the current state and symbol ([StateSymbol])
  @nonVirtual
  Instruction getInstruction(StateSymbol ss) => table[ss].instruction;

  /// The transition function.
  ///
  /// Returns the next state given the current state and symbol ([StateSymbol])
  @nonVirtual
  int getTransition(StateSymbol ss) => table[ss].nextState;

  /// Checks whether this machine is well defined
  ///
  /// Throws [StateError] if one of the following conditions is not met:
  /// - The number of [states] * (number of symbols in [alphabet] + 1) == number of rows of [table]
  /// - Every (symbol, state) combination has a row in the [table]
  /// - Each state appears | alphabet | + 1 times in the table
  @nonVirtual
  void checkTable() {
    var correctLenght = states.length * (alphabet.length + 1) == table.length;

    if (!correctLenght) {
      throw StateError(
          "Invalid table: a turing machine table must have |states| * (|symbols| + 1) rows.");
    }

    Map<String, int> symbolCount = {};
    Map<int, int> stateCount = {};

    for (var elem in table.entries) {
      symbolCount.update(elem.key.symbol, (i) => i + 1, ifAbsent: () => 1);
      stateCount.update(elem.key.state, (i) => i + 1, ifAbsent: () => 1);
    }

    if (symbolCount.length != alphabet.length + 1) {
      throw StateError(
          "Invalid table: Every symbol including the empty symbol must be in the table");
    }

    if (stateCount.length != states.length) {
      throw StateError("Invalid table: Every state must appear in the table");
    }

    if (symbolCount.values.any((s) => s != states.length)) {
      throw StateError(
          "Invalid table: a turing machine table must have one row per symbol per state");
    }

    if (stateCount.values.any((s) => s != (alphabet.length + 1))) {
      throw StateError(
          "Invalid table: each state must appear | alphabet | + 1 times in the table");
    }
  }

  /// Returns the [Configuration] to which [c] transits directly to.
  ///
  /// The next [Configuration] state is indicated in the [table.getInstruction()] function.
  /// A TM cannot perform more than one [Instruction] in the same step, so
  /// the difference between the given [c] and following [Configuration] is:
  /// * If the [Instruction] is [MoveLeft] or [MoveRight], the index
  /// is decreased or increased by one, thus the symbol might be different.
  /// * If the [Instruction] is [Write], the index does not change
  /// but the current symbol might be different.
  /// * If the [Instruction] is [Halt], the same [Configuration] [c] is returned.
  Configuration transitNext(Configuration c) {
    if (c.isTerminal) {
      return c;
    }

    var ss = c.stateSymbol;

    var instruction = getInstruction(ss);
    var nextState = getTransition(ss);
    Tape tape = c.tape.copyWith();
    int index = c.index;

    if (instruction is Write) {
      tape.write(instruction.symbol);
    } else if (instruction is MoveLeft) {
      index--;
      tape.moveLeft();
    } else {
      index++;
      tape.moveRight();
    }

    return Configuration(
      state: nextState,
      index: index,
      tape: tape,
      instruction: instruction,
    );
  }
}

extension StringExtension on String {
  List<String> toListRepeat(int times) => List.generate(times, (_) => this);
}
