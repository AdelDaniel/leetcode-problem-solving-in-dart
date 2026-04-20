// leetcode/2078.two_furthest_houses_with_different_colors.dart
// https://leetcode.com/problems/two-furthest-houses-with-different-colors/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.maxDistance([1, 1, 1, 6, 1, 1, 1]);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int maxDistance(List<int> colors) {
    int lastColor = colors.first;
    int maxDiff = 0;
    for (int i = 1; i < colors.length; i++) {
      if (lastColor != colors[i]) {
        maxDiff = i;
      }
    }
    lastColor = colors.last;
    for (int i = colors.length - 2; i > 0; i--) {
      if (lastColor != colors[i] && maxDiff < colors.length - i - 1) {
        maxDiff = colors.length - i - 1;
      }
    }
    return maxDiff;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Two Furthest Houses With Different Colors', () {
    // ===== Examples =====
    test('Example 1: [1,1,1,6,1,1,1] -> 3', () {
      final colors = [1, 1, 1, 6, 1, 1, 1];
      expect(s.maxDistance(colors), equals(3));
    });

    test('Example 2: [1,8,3,8,3] -> 4', () {
      final colors = [1, 8, 3, 8, 3];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Example 3: [0,1] -> 1', () {
      final colors = [0, 1];
      expect(s.maxDistance(colors), equals(1));
    });

    // ===== Minimum Size =====
    test('Minimum size, two different colors', () {
      final colors = [5, 9];
      expect(s.maxDistance(colors), equals(1));
    });

    test('Minimum size, boundary colors', () {
      final colors = [0, 100];
      expect(s.maxDistance(colors), equals(1));
    });

    // ===== Different at Ends =====
    test('Ends are different, full distance', () {
      final colors = [1, 2, 2, 2, 2, 2, 3];
      expect(s.maxDistance(colors), equals(6));
    });

    test('Ends are different in longer array', () {
      final colors = [4, 4, 4, 4, 4, 7];
      expect(s.maxDistance(colors), equals(5));
    });

    test('Alternating with different ends', () {
      final colors = [1, 2, 1, 2, 1, 2, 1, 3];
      expect(s.maxDistance(colors), equals(7));
    });

    // ===== Same at Ends, Need Inner Different =====
    test('Same ends, different color near left', () {
      final colors = [1, 2, 1];
      expect(s.maxDistance(colors), equals(1));
    });

    test('Same ends, different color near right', () {
      final colors = [1, 1, 2, 1];
      expect(s.maxDistance(colors), equals(2));
    });

    test('Same ends, best from first to inner different', () {
      final colors = [5, 5, 5, 2, 5, 5];
      expect(s.maxDistance(colors), equals(3));
    });

    test('Same ends, best from inner different to last', () {
      final colors = [7, 7, 3, 7, 7, 7];
      expect(s.maxDistance(colors), equals(3));
    });

    test('Same ends, different only in center', () {
      final colors = [9, 9, 9, 1, 9, 9, 9];
      expect(s.maxDistance(colors), equals(3));
    });

    // ===== All but One Same =====
    test('Only one house different near beginning', () {
      final colors = [1, 2, 2, 2, 2, 2, 2];
      expect(s.maxDistance(colors), equals(6));
    });

    test('Only one house different near end', () {
      final colors = [3, 3, 3, 3, 3, 3, 9];
      expect(s.maxDistance(colors), equals(6));
    });

    test('Only one house different in middle', () {
      final colors = [4, 4, 4, 8, 4, 4, 4, 4];
      expect(s.maxDistance(colors), equals(4));
    });

    // ===== Alternating Patterns =====

    test('Alternating two colors even length', () {
      final colors = [1, 2, 1, 2, 1, 2];
      expect(s.maxDistance(colors), equals(5));
    });

    test('Alternating starting with zero', () {
      final colors = [0, 1, 0, 1, 0, 1, 0];
      expect(s.maxDistance(colors), equals(5));
    });

    // ===== Multiple Distinct Colors =====
    test('Strictly increasing colors', () {
      final colors = [1, 2, 3, 4, 5];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Strictly decreasing colors', () {
      final colors = [5, 4, 3, 2, 1];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Many distinct colors with same ends', () {
      final colors = [2, 4, 6, 8, 10, 2];
      expect(s.maxDistance(colors), equals(4));
    });

    // ===== Duplicates / Repeated Blocks =====
    test('Repeated blocks, same ends', () {
      final colors = [1, 1, 2, 2, 1, 1];
      expect(s.maxDistance(colors), equals(3));
    });

    test('Large repeated prefix and suffix', () {
      final colors = [6, 6, 6, 6, 1, 6, 6, 6, 6];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Two repeated groups only', () {
      final colors = [2, 2, 2, 5, 5, 5];
      expect(s.maxDistance(colors), equals(5));
    });

    // ===== Boundary Color Values =====
    test('Uses color 0 and 100', () {
      final colors = [0, 0, 0, 100, 0];
      expect(s.maxDistance(colors), equals(3));
    });

    test('Ends are 0 and 100', () {
      final colors = [0, 50, 50, 50, 100];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Only 0 and 100 alternating', () {
      final colors = [0, 100, 0, 100, 0, 100];
      expect(s.maxDistance(colors), equals(5));
    });

    // ===== Larger Arrays =====
    test('Length 10 with one different at middle', () {
      final colors = [1, 1, 1, 1, 1, 2, 1, 1, 1, 1];
      expect(s.maxDistance(colors), equals(5));
    });

    test('Length 10 with different at both ends', () {
      final colors = [8, 1, 1, 1, 1, 1, 1, 1, 1, 9];
      expect(s.maxDistance(colors), equals(9));
    });

    test('Length 20 repeated pattern', () {
      final colors = [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        2,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1
      ];
      expect(s.maxDistance(colors), equals(10));
    });

    test('Length 100, first differs from all rest', () {
      final colors = [0, ...List.generate(99, (_) => 1)];
      expect(s.maxDistance(colors), equals(99));
    });

    test('Length 100, last differs from all rest', () {
      final colors = [...List.generate(99, (_) => 7), 8];
      expect(s.maxDistance(colors), equals(99));
    });

    test('Length 100, middle differs only once', () {
      final colors = List.generate(100, (_) => 5);
      colors[50] = 9;
      expect(s.maxDistance(colors), equals(50));
    });

    test('Length 100 alternating colors', () {
      final colors = List.generate(100, (i) => i % 2);
      expect(s.maxDistance(colors), equals(99));
    });

    // ===== Trick / Common Mistake Cases =====
    test('Best pair not involving last house', () {
      final colors = [1, 2, 1, 1];
      expect(s.maxDistance(colors), equals(2));
    });

    test('Best pair not involving first house', () {
      final colors = [3, 3, 1, 3];
      expect(s.maxDistance(colors), equals(2));
    });

    test('Need compare first with farthest different from right side', () {
      final colors = [4, 4, 4, 4, 2];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Need compare last with farthest different from left side', () {
      final colors = [2, 7, 7, 7, 7];
      expect(s.maxDistance(colors), equals(4));
    });

    test('Different color appears multiple times, choose farthest', () {
      final colors = [1, 2, 1, 2, 1, 2, 1];
      expect(s.maxDistance(colors), equals(5));
    });

    // ===== Stability / Sanity =====
    test('Answer is always between 1 and n-1', () {
      final colors = [1, 1, 1, 2, 1, 1];
      final result = s.maxDistance(colors);
      expect(result >= 1 && result <= colors.length - 1, isTrue);
    });

    test('Random-like array sanity case 2', () {
      final colors = [2, 5, 5, 5, 2, 5, 5, 9];
      expect(s.maxDistance(colors), equals(7));
    });
  });
}
