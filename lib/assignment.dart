/// [start, end] inclusive
class Range {
  final int start;
  final int end;

  Range(this.start, this.end);
}

// domain can be list or range
Iterable<List<int>> assign(List<dynamic> domains) sync* {
  if (domains.isNotEmpty) {
    var last = domains.removeLast();
    for (var assignment in assign(domains)) {
      switch (last) {
        case List<int> l:
          {
            for (var e in l) {
              yield assignment..add(e);
              assignment.removeLast();
            }
          }
        case Range r:
          {
            for (var i = r.start; i <= r.end; i++) {
              yield assignment..add(i);
              assignment.removeLast();
            }
          }
      }
    }
  } else {
    yield [];
  }
}

