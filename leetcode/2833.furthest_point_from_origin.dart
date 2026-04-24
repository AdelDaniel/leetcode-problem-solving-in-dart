// leetcode/2833.furthest_point_from_origin.dart
// https://leetcode.com/problems/furthest-point-from-origin/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.furthestDistanceFromOrigin('L_RL__R');

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int furthestDistanceFromOrigin(String moves) {
    int sum = 0;
    int spaceCount = 0;
    for (int i = 0; i < moves.length; i++) {
      if (moves[i] == 'R') {
        sum++;
      } else if (moves[i] == 'L') {
        sum--;
      } else {
        spaceCount++;
      }
    }
    if (sum > 0) {
      return (sum + spaceCount).abs();
    } else {
      return (sum - spaceCount).abs();
    }
  }
}

void runTests() {
  final Solution s = Solution();

  group('Furthest Point From Origin', () {
    // ===== Examples =====
    test('Example 1: "L_RL__R" -> 3', () {
      expect(s.furthestDistanceFromOrigin('L_RL__R'), equals(3));
    });

    test('Example 2: "_R__LL_" -> 5', () {
      expect(s.furthestDistanceFromOrigin('_R__LL_'), equals(5));
    });

    test('Example 3: "_______" -> 7', () {
      expect(s.furthestDistanceFromOrigin('_______'), equals(7));
    });

    // ===== Single Character =====
    test('"L" -> 1', () {
      expect(s.furthestDistanceFromOrigin('L'), equals(1));
    });

    test('"R" -> 1', () {
      expect(s.furthestDistanceFromOrigin('R'), equals(1));
    });

    test('"_" -> 1', () {
      expect(s.furthestDistanceFromOrigin('_'), equals(1));
    });

    // ===== Two Characters =====
    test('"LR" -> 0', () {
      expect(s.furthestDistanceFromOrigin('LR'), equals(0));
    });

    test('"RL" -> 0', () {
      expect(s.furthestDistanceFromOrigin('RL'), equals(0));
    });

    test('"LL" -> 2', () {
      expect(s.furthestDistanceFromOrigin('LL'), equals(2));
    });

    test('"RR" -> 2', () {
      expect(s.furthestDistanceFromOrigin('RR'), equals(2));
    });

    test('"L_" -> 2', () {
      expect(s.furthestDistanceFromOrigin('L_'), equals(2));
    });

    test('"R_" -> 2', () {
      expect(s.furthestDistanceFromOrigin('R_'), equals(2));
    });

    test('"__" -> 2', () {
      expect(s.furthestDistanceFromOrigin('__'), equals(2));
    });

    // ===== No Underscores =====
    test('"LLLRRR" -> 0', () {
      expect(s.furthestDistanceFromOrigin('LLLRRR'), equals(0));
    });

    test('"LLLLR" -> 3', () {
      expect(s.furthestDistanceFromOrigin('LLLLR'), equals(3));
    });

    test('"RRRRL" -> 3', () {
      expect(s.furthestDistanceFromOrigin('RRRRL'), equals(3));
    });

    test('"LLLLL" -> 5', () {
      expect(s.furthestDistanceFromOrigin('LLLLL'), equals(5));
    });

    test('"RRRRR" -> 5', () {
      expect(s.furthestDistanceFromOrigin('RRRRR'), equals(5));
    });

    // ===== Only Underscores =====
    test('"___" -> 3', () {
      expect(s.furthestDistanceFromOrigin('___'), equals(3));
    });

    test('"__________" -> 10', () {
      expect(s.furthestDistanceFromOrigin('__________'), equals(10));
    });

    // ===== Mixed Basic Patterns =====
    test('"L_R" -> 1', () {
      expect(s.furthestDistanceFromOrigin('L_R'), equals(1));
    });

    test('"R_L" -> 1', () {
      expect(s.furthestDistanceFromOrigin('R_L'), equals(1));
    });

    test('"L__" -> 3', () {
      expect(s.furthestDistanceFromOrigin('L__'), equals(3));
    });

    test('"R__" -> 3', () {
      expect(s.furthestDistanceFromOrigin('R__'), equals(3));
    });

    test('"LR_" -> 1', () {
      expect(s.furthestDistanceFromOrigin('LR_'), equals(1));
    });

    test('"RL_" -> 1', () {
      expect(s.furthestDistanceFromOrigin('RL_'), equals(1));
    });

    // ===== Balanced Fixed Moves + Underscores =====
    test('"LLRR_" -> 1', () {
      expect(s.furthestDistanceFromOrigin('LLRR_'), equals(1));
    });

    test('"LLRR__" -> 2', () {
      expect(s.furthestDistanceFromOrigin('LLRR__'), equals(2));
    });

    test('"LLLRRR___" -> 3', () {
      expect(s.furthestDistanceFromOrigin('LLLRRR___'), equals(3));
    });

    test('"LRLRLR___" -> 3', () {
      expect(s.furthestDistanceFromOrigin('LRLRLR___'), equals(3));
    });

    // ===== Mostly One Direction =====
    test('"LLLL__" -> 6', () {
      expect(s.furthestDistanceFromOrigin('LLLL__'), equals(6));
    });

    test('"RRRR__" -> 6', () {
      expect(s.furthestDistanceFromOrigin('RRRR__'), equals(6));
    });

    test('"LLLL_R" -> 4', () {
      expect(s.furthestDistanceFromOrigin('LLLL_R'), equals(4));
    });

    test('"RRRR_L" -> 4', () {
      expect(s.furthestDistanceFromOrigin('RRRR_L'), equals(4));
    });

    // ===== Alternating Patterns =====
    test('"LRLRLRL" -> 1', () {
      expect(s.furthestDistanceFromOrigin('LRLRLRL'), equals(1));
    });

    test('"RLRLRLR" -> 1', () {
      expect(s.furthestDistanceFromOrigin('RLRLRLR'), equals(1));
    });

    test('"LRLR___" -> 3', () {
      expect(s.furthestDistanceFromOrigin('LRLR___'), equals(3));
    });

    test('"RLRL___" -> 3', () {
      expect(s.furthestDistanceFromOrigin('RLRL___'), equals(3));
    });

    // ===== Edge-ish Combinations =====
    test('"L_RL" -> 2', () {
      expect(s.furthestDistanceFromOrigin('L_RL'), equals(2));
    });

    test('"R_LR" -> 2', () {
      expect(s.furthestDistanceFromOrigin('R_LR'), equals(2));
    });

    test('"L__R" -> 2', () {
      expect(s.furthestDistanceFromOrigin('L__R'), equals(2));
    });

    test('"R__L" -> 2', () {
      expect(s.furthestDistanceFromOrigin('R__L'), equals(2));
    });

    test('"L_R_L_" -> 4', () {
      expect(s.furthestDistanceFromOrigin('L_R_L_'), equals(4));
    });

    test('"R_L_R_" -> 4', () {
      expect(s.furthestDistanceFromOrigin('R_L_R_'), equals(4));
    });

    // ===== Max Length Style Cases =====
    test('50 underscores -> 50', () {
      expect(s.furthestDistanceFromOrigin('_' * 50), equals(50));
    });

    test('25 L and 25 R -> 0', () {
      expect(s.furthestDistanceFromOrigin('L' * 25 + 'R' * 25), equals(0));
    });

    test('25 L and 25 underscores -> 50', () {
      expect(s.furthestDistanceFromOrigin('L' * 25 + '_' * 25), equals(50));
    });

    test('25 R and 25 underscores -> 50', () {
      expect(s.furthestDistanceFromOrigin('R' * 25 + '_' * 25), equals(50));
    });

    test('Mixed 50-length pattern', () {
      final moves = 'LR' * 10 + '_' * 30; // 20 fixed balanced + 30 flexible
      expect(s.furthestDistanceFromOrigin(moves), equals(30));
    });

    // ===== Sanity / Formula Checks =====
    test('One fixed imbalance + underscores', () {
      // 3 L, 1 R, 2 _ => |3 - 1| + 2 = 4
      expect(s.furthestDistanceFromOrigin('LLLR__'), equals(4));
    });

    test('Opposite fixed imbalance + underscores', () {
      // 1 L, 3 R, 2 _ => |1 - 3| + 2 = 4
      expect(s.furthestDistanceFromOrigin('LRRR__'), equals(4));
    });

    test('Balanced fixed moves with many underscores', () {
      // 4 L, 4 R, 5 _ => 5
      expect(s.furthestDistanceFromOrigin('LLLLRRRR_____'), equals(5));
    });

    test('Unbalanced fixed moves without underscores', () {
      // 4 L, 2 R => 2
      expect(s.furthestDistanceFromOrigin('LLLLRR'), equals(2));
    });
  });
}
