// https://leetcode.com/problems/asteroid-collision/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  ////! Solved the problem --> TC O(N)
  List<int> asteroidCollision(List<int> asteroids) {
    List<int> resultStack = [];

    for (var i = 0; i < asteroids.length; i++) {
      final currentAsteroid = asteroids[i];

      if (resultStack.isEmpty) {
        resultStack.add(currentAsteroid);
      } else {
        while (resultStack.isNotEmpty) {
          final lastAsteroid = resultStack.last;

          /// Both are different Signs
          /// Are the last one is left(Negative Sign) and this one is right(Positive Sign)
          /// Then they are will never meet
          /// And I need to add the new one only
          if (lastAsteroid < 0 && currentAsteroid > 0) {
            resultStack.add(currentAsteroid);
            break;
          }

          /// Both are same direction
          else if (lastAsteroid < 0 && currentAsteroid < 0 ||
              lastAsteroid > 0 && currentAsteroid > 0) {
            resultStack.add(currentAsteroid);
            break;
          } else if (lastAsteroid + currentAsteroid == 0) {
            resultStack.removeLast();
            break;
          }

          /// Both are different direction
          /// And the last is Right (Right) and new is negative (Left)
          /// Collision will happen
          else {
            /// If the current is bigger Then remove last and add the new one
            /// Else the latest added still the same and nothing change
            if (lastAsteroid.abs() < currentAsteroid.abs()) {
              resultStack.removeLast();
              if (resultStack.isEmpty) {
                resultStack.add(currentAsteroid);
                break;
              }
            } else {
              break;
            }
          }
        }
      }
    }

    return resultStack;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Asteroid Collision', () {
    // Basic examples from problem statement
    test('Example 1: [5,10,-5] → [5,10]', () {
      expect(s.asteroidCollision([5, 10, -5]), equals([5, 10]));
    });

    test('Example 2: [8,-8] → []', () {
      expect(s.asteroidCollision([8, -8]), equals([]));
    });

    test('Example 3: [10,2,-5] → [10]', () {
      expect(s.asteroidCollision([10, 2, -5]), equals([10]));
    });

    // Edge cases
    test('Two asteroids same size: [5,-5] → []', () {
      expect(s.asteroidCollision([5, -5]), equals([]));
    });

    test('All positive: [1,2,3] → [1,2,3]', () {
      expect(s.asteroidCollision([1, 2, 3]), equals([1, 2, 3]));
    });

    test('All negative: [-1,-2,-3] → [-1,-2,-3]', () {
      expect(s.asteroidCollision([-1, -2, -3]), equals([-1, -2, -3]));
    });

    // No collisions
    test('No collisions: [-1,1] → [-1,1]', () {
      expect(s.asteroidCollision([-1, 1]), equals([-1, 1]));
    });

    test('No collisions: [-5,-10,5,10] → [-5,-10,5,10]', () {
      expect(s.asteroidCollision([-5, -10, 5, 10]), equals([-5, -10, 5, 10]));
    });

    // Multiple collisions
    test('Multiple collisions: [10,2,-5,-20] → [-20]', () {
      expect(s.asteroidCollision([10, 2, -5, -20]), equals([-20]));
    });

    test('Multiple collisions: [5,5,-10] → [-10]', () {
      expect(s.asteroidCollision([5, 5, -10]), equals([-10]));
    });

    test('Large array with all collisions', () {
      final asteroids = List.generate(10000, (i) => i.isEven ? 1000 : -1000);
      expect(s.asteroidCollision(asteroids), equals([]));
    });

    // Maximum constraints
    test('Maximum length array with alternating collisions', () {
      final asteroids = List.generate(10000, (i) => i % 2 == 0 ? 1 : -1);
      expect(s.asteroidCollision(asteroids), equals([]));
    });

    test('Maximum size difference: [1000,-1] → [1000]', () {
      expect(s.asteroidCollision([1000, -1]), equals([1000]));
    });

    // Complex scenarios
    test('Complex scenario 1: [5,5,5,-5] → [5,5]', () {
      expect(s.asteroidCollision([5, 5, 5, -5]), equals([5, 5]));
    });

    test('Complex scenario 2: [-5,5,5,-5] → [-5,5]', () {
      expect(s.asteroidCollision([-5, 5, 5, -5]), equals([-5, 5]));
    });

    // Random cases
    test('Random case 1: [8,-8,5,10] → [5,10]', () {
      expect(s.asteroidCollision([8, -8, 5, 10]), equals([5, 10]));
    });

    test('Random case 2: [-2,-1,1,2] → [-2,-1,1,2]', () {
      expect(s.asteroidCollision([-2, -1, 1, 2]), equals([-2, -1, 1, 2]));
    });

    /// LeetCode
    test('Leet Code: [-2,-1,1,2] → [-2,-1,1,2]', () {
      expect(s.asteroidCollision([-2, -1, 1, 2]), equals([-2, -1, 1, 2]));
    });
  });
}
