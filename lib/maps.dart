import 'dart:collection';

/// Map:
/// A collection of key/value pairs,
/// from which you retrieve a value using its associated key.
///
/// There is a finite number of keys in the map, 
/// and each key has exactly one value associated with it.
///
/// Maps, and their keys and values, can be iterated. 
/// The order of iteration is defined by the individual type of map.
/// 
/// Examples:
/// 
/// 1. The plain [HashMap] is unordered (no order is guaranteed),
/// 2. the [LinkedHashMap] iterates in key insertion order,
/// 3. and a sorted map like [SplayTreeMap] iterates the keys in sorted order.
/// 
/// It is generally not allowed to modify the map (add or remove keys) while an operation is being performed on the map,
/// for example in functions called during a [forEach] or [putIfAbsent] call.
/// Modifying the map while iterating the keys or values may also break the iteration.
///
/// It is generally not allowed to modify the equality of keys (and thus not their hashcode) while they are in the map.
/// Some specialized subtypes may be more permissive, in which case they should document this behavior.
///

void main() {
  Maps().map();
  Maps().hashMap();
  Maps().linkedHashMap();
  Maps().splayTreeMap();
}

class Maps {
  void map() {
    final Map planetsByDiameter = <double, String>{};
    planetsByDiameter[0.949] = 'Venus';
    planetsByDiameter[1.0] = 'Earth';
    planetsByDiameter[0.532] = 'Mars';
    planetsByDiameter[11.209] = 'Jupiter';

    print("Map: ${planetsByDiameter.entries}");
  }

  void hashMap() {
    final HashMap planetsByDiameter = HashMap<double, String>();
    planetsByDiameter[0.949] = 'Venus';
    planetsByDiameter[1.0] = 'Earth';
    planetsByDiameter[0.532] = 'Mars';
    planetsByDiameter[11.209] = 'Jupiter';

    print("HashMap: ${planetsByDiameter.entries}");
  }

  void linkedHashMap() {
    final LinkedHashMap planetsByDiameter = LinkedHashMap<double, String>();
    planetsByDiameter[0.949] = 'Venus';
    planetsByDiameter[1.0] = 'Earth';
    planetsByDiameter[0.532] = 'Mars';
    planetsByDiameter[11.209] = 'Jupiter';

    print("LinkedHashMap: ${planetsByDiameter.entries}");
  }

  void splayTreeMap() {
    final SplayTreeMap planetsByDiameter = SplayTreeMap<double, String>();
    planetsByDiameter[0.949] = 'Venus';
    planetsByDiameter[1.0] = 'Earth';
    planetsByDiameter[0.532] = 'Mars';
    planetsByDiameter[11.209] = 'Jupiter';

    print("SplayTreeMap: ${planetsByDiameter.entries}");
  }
}
