/// Book AIMA 4th Edition, 5.2.5 Global constraints

List<Set<int>> deepCopy(List<Set<int>> listSetInt) {
  var result = <Set<int>>[];
  for (var s in listSetInt) {
    result.add(Set.of(s));
  }
  return result;
}

/// check whether domains have all diff solution
class AllDiff {
  final List<Set<int>> domains;
  final List<Set<int>> domainsCopy;
  final List<bool> remains;
  final Set<int> initValues;
  final Set<int> removedValues = {};

  AllDiff(this.domains)
      : remains = List.filled(domains.length, true),
        initValues = domains.reduce((domain, other) => domain.union(other)),
        domainsCopy = deepCopy(domains);

  int get remainValues {
    return initValues.difference(removedValues).length;
  }

  int get remainVariables => remains.fold(0, (pv, e) => pv + (e ? 1 : 0));

  /// check any remaining domain has 0 value
  /// and check remaining variables <= total domain
  bool _isConsistent() {
    for (var i = 0; i < domainsCopy.length; i++) {
      if (remains[i] && domainsCopy.isEmpty) {
        return false;
      }
    }
    if (remainVariables > remainValues) {
      return false;
    }
    return true;
  }

  /// Try find domain with 1 vaule, remove that variable
  /// and remove that value from other domains
  /// If can't find such one value domain, return false
  bool _tryRemoveOneValueDomain() {
    int? index;
    for (var i = 0; i < domainsCopy.length; i++) {
      if (remains[i] && domainsCopy[i].length == 1) {
        index = i;
        break;
      }
    }
    if (index == null) {
      return false;
    } else {
      remains[index] = false;
      var value = domainsCopy[index].single;
      domainsCopy[index].clear();
      for (var i = 0; i < domainsCopy.length; i++) {
        if (remains[i]) {
          domainsCopy[i].remove(value);
        }
      }
      return true;
    }
  }

  bool check() {
    do {
      if (!_isConsistent()) {
        return false;
      }
    } while (_tryRemoveOneValueDomain());
    return _isConsistent();
  }
}
