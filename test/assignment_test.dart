import 'package:playground/assignment.dart';
import 'package:test/test.dart';

void main() {
  test('assignment #1', () async {
    var l1 = [1, 2];
    var r1 = Range(3, 4);
    expect(assign([l1, r1]), [
      [1, 3],
      [1, 4],
      [2, 3],
      [2, 4]
    ]);
  });
}
