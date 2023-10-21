import 'package:test/test.dart';
import 'package:playground/ac3.dart';

void main() {
    test('ac3 fail #1', () {
    // x,y = [0..9]
    // y == x + 10
    var xd = List.generate(10, (index) => index).toSet();
    var yd = Set.of(xd);
    var x = Node('x', xd);
    var y = Node('y', yd);
    var edge1 = Edge(y, x, (int y, int x) => y == x + 10);
    var ac3 = AC3<int>();
    ac3.addEdge(edge1);
    expect(ac3.ac3(), false);
  });
  test('ac3 pass #1', () {
    // x,y = [0..9]
    // y == x^2
    var xd = List.generate(10, (index) => index).toSet();
    var yd = Set.of(xd);
    var x = Node('x', xd);
    var y = Node('y', yd);
    var edge1 = Edge(y, x, (int y, int x) => y == x * x);
    var ac3 = AC3<int>();
    ac3.addEdge(edge1);
    expect(ac3.ac3(), true);
    expect(x.domain, {0,1,2,3});
    expect(y.domain, {0,1,4,9});
  });

  test('ac3 pass #2', () {
    // x,y,z = [0..9]
    // y == 2x, z == x + 5
    var xd = List.generate(10, (index) => index).toSet();
    var yd = Set.of(xd);
    var zd = Set.of(xd);
    var x = Node('x', xd);
    var y = Node('y', yd);
    var z = Node('z', zd);
    var edge1 = Edge(y, x, (int y, int x) => y == 2 * x);
    var edge2 = Edge(z, x, (int z, int x) => z == x + 6);
    var ac3 = AC3<int>();
    ac3.addEdge(edge1);
    ac3.addEdge(edge2);
    expect(ac3.ac3(), true);
    expect(x.domain, {0,1,2,3});
    expect(y.domain, {0,2,4,6});
    expect(z.domain, {6,7,8,9});        
  });
}
