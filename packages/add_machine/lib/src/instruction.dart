class Instruction {
  const Instruction();
}

class InitialInstruction extends Instruction {
  const InitialInstruction();

  @override
  String toString() => "Initialized";
}

class Write extends Instruction {
  final String symbol;

  const Write(this.symbol);

  @override
  String toString() => "Write '$symbol'";
}

class MoveLeft extends Instruction {
  const MoveLeft();

  @override
  String toString() => "Move left";
}

class MoveRight extends Instruction {
  const MoveRight();

  @override
  String toString() => "Move right";
}

class Halt extends Instruction {
  const Halt();

  @override
  String toString() => "Halt";
}
