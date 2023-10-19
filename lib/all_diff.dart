/// Book AIMA 4th Edition, 5.2.5 Global constraints

/// check whether domains have all diff solution
bool allDiff(List<Set<int>> domains) {
  var totalDomain = domains.reduce((domain, other) => domain.union(other));

  while (domains.any((e) => e.length == 1)) {
    var v = domains.firstWhere((e) => e.length == 1).single;
    for (var i = 0; i < domains.length; i++) {
      domains[i].remove(v);
    }
    totalDomain.remove(v);
  }

  // remaining variables <= total domains
  return domains.fold(0, (pv, e) => pv + (e.isNotEmpty ? 1 : 0)) <=
      totalDomain.length;
}
