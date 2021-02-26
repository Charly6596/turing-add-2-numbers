import 'tape.dart';

main() {
  Tape t = Tape(left: [], right: [], blank: "*");
  print("Empty: $t");
  t.write("1");
  t.moveRight();
  t.write("1");
  print("After writting: $t");
  t.moveRight();
  t.moveRight();
  print("After moving: $t");
}
