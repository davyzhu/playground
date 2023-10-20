import 'package:playground/all_diff.dart';
import 'package:test/test.dart';

void main() {
  test('all diff #1', () async {
    var d1 = {1, 2, 3};
    var d2 = {1, 2, 3};
    var d3 = {1};
    var d4 = {1, 2, 3};
    expect(AllDiff([d1, d2, d3, d4]).check(), false);
  });

  test('all diff #2', () async {
    var d1 = {1, 2, 3, 4};
    var d2 = {1, 2, 3};
    var d3 = {1};
    var d4 = {1, 2, 3};
    expect(AllDiff([d1, d2, d3, d4]).check(), true);
  });

  test('all diff #3', () async {
    var d1 = {1, 2, 3};
    var d2 = {1, 2, 3};
    expect(AllDiff([d1, d2]).check(), true);
  });
  test('all diff #4', () async {
    var d1 = {1};
    var d2 = {1};
    expect(AllDiff([d1, d2]).check(), false);
  });
}
