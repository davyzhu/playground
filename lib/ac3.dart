enum Direction { left2right, right2left }

/// variable node
class Node<T> {
  final String name;
  final Set<T> domain;
  final outEdges = <DirectedEdge<T>>{};

  Node(this.name, this.domain);
}

/// binary constraint
class Edge<T> {
  final Node<T> left;
  final Node<T> right;
  final bool Function(T left, T right) constraint;

  Edge(this.left, this.right, this.constraint);
}

class DirectedEdge<T> {
  final Edge<T> edge;
  final Direction direction;

  DirectedEdge(this.edge, this.direction);
}

class AC3<T> {
  final edgeQueue = <DirectedEdge<T>>{};

  void addEdge(Edge<T> edge) {
    var de1 = DirectedEdge(edge, Direction.left2right);
    var de2 = DirectedEdge(edge, Direction.right2left);
    edgeQueue
      ..add(de1)
      ..add(de2);
    de1.edge.left.outEdges.add(de1);
    de2.edge.right.outEdges.add(de2);
  }

  /// return false if inconsistency is detected
  bool ac3() {
    while (edgeQueue.isNotEmpty) {
      var e = edgeQueue.first;
      edgeQueue.remove(e);
      var (revised, inconsist) = revise(e);
      if (inconsist) {
        assert(revised);
        return false;
      }
      if (revised) {
        var node =
            (e.direction == Direction.left2right) ? e.edge.left : e.edge.right;
        edgeQueue.addAll(node.outEdges);
      }
    }
    return true;
  }

  /// return true if revise domain
  (bool, bool) revise(DirectedEdge<T> e) {
    var revised = false;
    var inconsist = false;
    var shouldRemove = <T>{};
    var left = e.edge.left;
    var right = e.edge.right;
    switch (e.direction) {
      case Direction.left2right:
        {
          for (var rValue in right.domain) {
            if (!left.domain
                .any((lValue) => e.edge.constraint(lValue, rValue))) {
              revised = true;
              shouldRemove.add(rValue);
            }
          }
          if (revised) {
            right.domain.removeWhere((v) => shouldRemove.contains(v));
            inconsist = right.domain.isEmpty;
          }
        }
        break;
      case Direction.right2left:
        {
          for (var lValue in left.domain) {
            if (!right.domain
                .any((rValue) => e.edge.constraint(lValue, rValue))) {
              revised = true;
              shouldRemove.add(lValue);
            }
          }
          if (revised) {
            left.domain.removeWhere((v) => shouldRemove.contains(v));
            inconsist = left.domain.isEmpty;
          }
        }
        break;
    }
    return (revised, inconsist);
  }
}
