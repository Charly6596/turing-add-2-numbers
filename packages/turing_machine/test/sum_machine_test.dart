import 'package:add_machine/turing_machine.dart';
import 'package:test/test.dart';

void main() {
  test("Add machine should run without errors", () {
    var m = SumMachine();
    m.initialize(1, 1);

    var config = m.initialConfiguration;

    while (!config.isTerminal) {
      config = m.transitNext(config);
    }

    expect(config.tape.readAt(config.index - 1), equals(m.alphabet[0]));
    expect(config.tape.toList().where((e) => e == m.alphabet[0]), hasLength(3));
  });

  test("Add machine should run without errors", () {
    var m = SumMachine();
    m.initialize(5, 3);

    List<Configuration> configs = [];

    Configuration last = m.initialConfiguration;

    do {
      configs.add(last);
      last = m.next();
    } while (!last.isTerminal);

    expect(last.tape.readAt(last.index - 1), equals(m.alphabet[0]));
    expect(last.tape.toList().where((e) => e == m.alphabet[0]),
        hasLength(5 + 3 + 1));
    List<Configuration> previousConfigs = [];
    Configuration previous;

    do {
      previous = m.previous();
      previousConfigs.add(previous);
    } while (!(previous.instruction is InitialInstruction));

    expect(configs, containsAll(previousConfigs));
  });
}
