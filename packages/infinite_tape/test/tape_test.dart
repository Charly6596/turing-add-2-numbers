import 'package:test/test.dart';

import '../lib/infinite_tape.dart';

void main() {
  const val = "v";
  const blank = "*";
  Tape tape;

  group('A tape with no input', () {
    setUp(() => tape = new Tape(blank: blank));

    test('should have the empty symbol on the head', () {
      expect(tape.read(), equals(tape.blank));
    });

    test('can write on the head', () {
      tape.write(val);
      expect(tape.read(), equals(val));
    });

    test('should read the empty symbol after moving to the right', () {
      tape.moveRight();
      expect(tape.read(), equals(tape.blank));
    });

    test('should read the empty symbol after moving to the left', () {
      tape.moveLeft();
      expect(tape.read(), equals(tape.blank));
    });
  });

  group('A tape with input on the left', () {
    var input = [val, val, blank, val];
    setUp(() => tape = new Tape(left: input, blank: blank));

    test('should read the empty symbol on the head', () {
      expect(tape.read(), equals(tape.blank));
    });

    test('can write on the head', () {
      tape.write(val);
      expect(tape.read(), equals(val));
    });

    test('should read the empty symbol after moving to the right', () {
      tape.moveRight();
      expect(tape.read(), equals(tape.blank));
    });

    test('should read the correct symbols after moving to the left', () {
      for (var s in input.reversed) {
        tape.moveLeft();
        expect(tape.read(), equals(s));
      }

      tape.moveLeft();
      expect(tape.read(), equals(tape.blank),
          reason: "and empty symbol if moving out of the input range");
    });
  });

  group('A tape with input on the right', () {
    var input = [val, val, blank, val];
    setUp(() => tape = new Tape(right: input, blank: blank));

    test('should read the first symbol on the head', () {
      expect(tape.read(), equals(input.first));
    });

    test('can write on the head', () {
      var symbol = input.first + "test";
      tape.write(symbol);
      expect(tape.read(), equals(symbol));
    });

    test('should read the empty symbol after moving to the left', () {
      tape.moveLeft();
      expect(tape.read(), equals(tape.blank));
    });

    test('should read the correct symbols after moving to the right', () {
      for (var s in input) {
        expect(tape.read(), equals(s));
        tape.moveRight();
      }

      tape.moveRight();
      expect(tape.read(), equals(tape.blank),
          reason: "and empty symbol if moving out of the input range");
    });
  });
}
