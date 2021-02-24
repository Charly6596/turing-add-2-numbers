import 'instruction.dart';

class TableEntry {
  final Instruction instruction;
  final int nextState;

  const TableEntry(this.instruction, this.nextState);
}
