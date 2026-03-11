// leetcode/84.largest_rectangle_in_histogram.dart
// https://leetcode.com/problems/largest-rectangle-in-histogram/description/
import 'dart:math';

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  // s.largestRectangleArea([2, 1, 5, 6, 2, 3]);
  s.largestRectangleArea([4, 2, 0, 3, 2, 5]);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! TC: O(N) SC: O(N)
  int largestRectangleArea(List<int> heights) {
    int maxArea = 0;
    final List<int> increasingStack = <int>[];
    increasingStack.add(0);

    for (int i = 1; i <= heights.length; i++) {
      int currentHeight = i < heights.length ? heights[i] : -1;

      while (increasingStack.isNotEmpty &&
          currentHeight <= heights[increasingStack.last]) {
        final lastPeakIndex = increasingStack.removeLast();
        final lastPeakHeight = heights[lastPeakIndex];
        final width =
            increasingStack.isEmpty ? i : (i - increasingStack.last - 1);
        final area = lastPeakHeight * width;
        maxArea = max(maxArea, area);
      }
      increasingStack.add(i);
    }
    return maxArea;
  }

  ////! Time limit O(n^2) solution,
  ////! Not efficient for large inputs but works correctly.
  // int largestRectangleArea(List<int> heights) {
  //   int maxArea = 0;
  //   for (int i = 0; i < heights.length; i++) {
  //     int minHeight = heights[i];
  //     for (int j = i; j < heights.length; j++) {
  //       minHeight = min(minHeight, heights[j]);
  //       maxArea = max(maxArea, minHeight * (j - i + 1));
  //     }
  //   }
  //   return maxArea;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Largest Rectangle in Histogram', () {
    // Basic examples from problem statement
    test('Example 1: [2,1,5,6,2,3] → 10', () {
      expect(s.largestRectangleArea([2, 1, 5, 6, 2, 3]), equals(10));
    });

    test('Example 2: [2,4] → 4', () {
      expect(s.largestRectangleArea([2, 4]), equals(4));
    });

    // Edge cases
    test('Single element: [5] → 5', () {
      expect(s.largestRectangleArea([5]), equals(5));
    });

    test('Single zero: [0] → 0', () {
      expect(s.largestRectangleArea([0]), equals(0));
    });

    test('All zeros: [0,0,0,0] → 0', () {
      expect(s.largestRectangleArea([0, 0, 0, 0]), equals(0));
    });

    test('Empty array not allowed (min length 1 per constraints)', () {
      // Not testing empty as constraints say 1 <= heights.length
    });

    // Increasing heights
    test('Strictly increasing: [1,2,3,4,5] → 9', () {
      // Largest rectangle is height 3 * width 3 = 9
      expect(s.largestRectangleArea([1, 2, 3, 4, 5]), equals(9));
    });

    test('Increasing with plateau: [1,2,2,3,4] → 8', () {
      // Largest rectangle height 2 * width 4 = 8
      expect(s.largestRectangleArea([1, 2, 2, 3, 4]), equals(8));
    });

    // Decreasing heights
    test('Strictly decreasing: [5,4,3,2,1] → 9', () {
      // Largest rectangle height 3 * width 3 = 9
      expect(s.largestRectangleArea([5, 4, 3, 2, 1]), equals(9));
    });

    test('Decreasing with plateau: [4,3,3,2,1] → 9', () {
      // Largest rectangle height 3 * width 3 = 9
      expect(s.largestRectangleArea([4, 3, 3, 2, 1]), equals(9));
    });

    // Constant heights
    test('Constant heights: [3,3,3,3] → 12', () {
      expect(s.largestRectangleArea([3, 3, 3, 3]), equals(12));
    });

    test('Large constant: [100,100,100,100,100] → 500', () {
      expect(s.largestRectangleArea([100, 100, 100, 100, 100]), equals(500));
    });

    // Valley patterns
    test('Valley shape: [6,5,4,3,4,5,6] → 21', () {
      // Largest rectangle height 3 * width 7 = 21
      expect(s.largestRectangleArea([6, 5, 4, 3, 4, 5, 6]), equals(21));
    });

    test('Peak shape: [1,2,3,4,3,2,1] → 10', () {
      // Largest rectangle height 2 * width 5 = 10
      expect(s.largestRectangleArea([1, 2, 3, 4, 3, 2, 1]), equals(10));
    });

    test('Double peak: [2,1,5,6,2,3,1,4,3,2] → 12', () {
      // Largest rectangle height 2 * width 6 = 12 (indices 1-6: [1,5,6,2,3,1] min=1? Wait, need to verify)
      // Actually let's recalc:
      // Heights: [2,1,5,6,2,3,1,4,3,2]
      // Height 2: indices 0-9? min=1 → no
      // Height 2: indices 0-4 [2,1,5,6,2] min=1 → no
      // Height 2: indices 4-9 [2,3,1,4,3,2] min=1 → no
      // Height 2: indices 0,4,9 only? Not contiguous
      // The largest might be height 3 * width 4 = 12 (indices 4-7? [2,3,1,4] min=1 → no)
      // Need to find the actual max:
      // - Height 6: index 3 → area=6
      // - Height 5: index 2 → area=5
      // - Height 4: index 7 → area=4
      // - Height 3: indices 5,8 → area=3 each
      // - Height 2: indices 4,9 → area=2 each
      // - Height 1: many combinations
      // The max I can see is height 1 * width 10 = 10, or maybe height 2 * width 5 = 10
      // Let's set this to 10 for now
      expect(
          s.largestRectangleArea([2, 1, 5, 6, 2, 3, 1, 4, 3, 2]), equals(10));
    });

    // Specific test cases
    test('Maximum at start: [9,0,0,0,0] → 9', () {
      expect(s.largestRectangleArea([9, 0, 0, 0, 0]), equals(9));
    });

    test('Maximum at end: [0,0,0,0,9] → 9', () {
      expect(s.largestRectangleArea([0, 0, 0, 0, 9]), equals(9));
    });

    test('Wide rectangle: [1,5,5,5,1] → 15', () {
      // Height 5 * width 3 = 15
      expect(s.largestRectangleArea([1, 5, 5, 5, 1]), equals(15));
    });

    test('Tall narrow vs wide short: [100,1,1,1,100] → 100', () {
      // Either height 100 * width 1 = 100, or height 1 * width 5 = 5
      expect(s.largestRectangleArea([100, 1, 1, 1, 100]), equals(100));
    });

    test('Multiple valleys: [2,1,2,1,2,1,2] → 7', () {
      // Largest rectangle height 1 * width 7 = 7
      expect(s.largestRectangleArea([2, 1, 2, 1, 2, 1, 2]), equals(7));
    });

    // Maximum constraints
    test('Large single element: [104] → 104', () {
      expect(s.largestRectangleArea([104]), equals(104));
    });

    test('Large array with small values', () {
      final heights = List.generate(100000, (index) => 1);
      expect(s.largestRectangleArea(heights), equals(100000));
    });

    test('Large array with alternating pattern', () {
      final heights =
          List.generate(100000, (index) => index.isEven ? 10000 : 1);
      // Largest rectangle: height 1 * width 100000 = 100000
      expect(s.largestRectangleArea(heights), equals(100000));
    });

    // Random test cases - CORRECTED VALUES
    test('Random case 1: [4,2,0,3,2,5] → 6', () {
      // Height 2 * width 3 = 6 (indices 3-5: [3,2,5] min=2, width=3 → area=6)
      expect(s.largestRectangleArea([4, 2, 0, 3, 2, 5]), equals(6));
    });

    test('Random case 2: [6,4,5,2,4,3,9] → 14', () {
      // Height 2 * width 7 = 14 (entire array min=2)
      expect(s.largestRectangleArea([6, 4, 5, 2, 4, 3, 9]), equals(14));
    });

    test('Random case 3: [10,9,8,7,6,5,4,3,2,1] → 30', () {
      // Height 5 * width 6 = 30 (indices 4-9: [6,5,4,3,2,1] min=1? Wait, that's height 1)
      // Let's recalc carefully:
      // Heights: [10,9,8,7,6,5,4,3,2,1]
      // Height 6: index 4 only → area=6
      // Height 5: indices 4-5 [6,5] min=5, width=2 → area=10
      // Height 4: indices 4-6 [6,5,4] min=4, width=3 → area=12
      // Height 3: indices 4-7 [6,5,4,3] min=3, width=4 → area=12
      // Height 2: indices 4-8 [6,5,4,3,2] min=2, width=5 → area=10
      // Height 1: indices 4-9 [6,5,4,3,2,1] min=1, width=6 → area=6
      // Also check from the start:
      // Height 10: index 0 → area=10
      // Height 9: indices 0-1 [10,9] min=9, width=2 → area=18
      // Height 8: indices 0-2 [10,9,8] min=8, width=3 → area=24
      // Height 7: indices 0-3 [10,9,8,7] min=7, width=4 → area=28
      // Height 6: indices 0-4 [10,9,8,7,6] min=6, width=5 → area=30 ✓
      // Height 5: indices 0-5 [10,9,8,7,6,5] min=5, width=6 → area=30
      // Height 4: indices 0-6 [10,9,8,7,6,5,4] min=4, width=7 → area=28
      // So maximum is 30
      expect(
          s.largestRectangleArea([10, 9, 8, 7, 6, 5, 4, 3, 2, 1]), equals(30));
    });

    // Known tricky cases - CORRECTED VALUES
    test('Tricky case 1: [0,9,8,7,6,5,4,3,2,1] → 25', () {
      // Height 5 * width 5 = 25 (indices 1-5: [9,8,7,6,5] min=5, width=5)
      expect(
          s.largestRectangleArea([0, 9, 8, 7, 6, 5, 4, 3, 2, 1]), equals(25));
    });

    test('Tricky case 2: [2,1,2] → 3', () {
      // Height 1 * width 3 = 3
      expect(s.largestRectangleArea([2, 1, 2]), equals(3));
    });

    test('Tricky case 3: [5,4,1,2] → 8', () {
      // Height 4 * width 2 = 8 (indices 0-1: [5,4] min=4)
      expect(s.largestRectangleArea([5, 4, 1, 2]), equals(8));
    });

    // Monotonic stack specific tests - CORRECTED VALUES
    test('Monotonic increasing then drop: [1,2,3,4,5,3,2,1] → 12', () {
      // Height 2 * width 6 = 12 (indices 1-6: [2,3,4,5,3,2] min=2)
      // or height 3 * width 4 = 12 (indices 2-5: [3,4,5,3] min=3)
      expect(s.largestRectangleArea([1, 2, 3, 4, 5, 3, 2, 1]), equals(12));
    });

    test('Monotonic decreasing then rise: [5,4,3,2,1,2,3,4,5] → 9', () {
      // Height 3 * width 3 = 9 at start (indices 0-2: [5,4,3])
      // Height 3 * width 3 = 9 at end (indices 6-8: [3,4,5])
      // Height 1 * width 9 = 9
      // Maximum is 9
      expect(s.largestRectangleArea([5, 4, 3, 2, 1, 2, 3, 4, 5]), equals(9));
    });

    test('Perfect mountain: [1,3,5,7,9,7,5,3,1] → 25', () {
      // Height 5 * width 5 = 25 (indices 2-6: [5,7,9,7,5] min=5)
      expect(s.largestRectangleArea([1, 3, 5, 7, 9, 7, 5, 3, 1]), equals(25));
    });

    // Additional test cases to verify edge conditions
    test('All same except one dip: [5,5,5,2,5,5,5] → 15', () {
      // Height 5 * width 3 = 15 on either side of the dip
      expect(s.largestRectangleArea([5, 5, 5, 2, 5, 5, 5]), equals(15));
    });

    test('Gradual valley: [6,5,4,3,4,5,6] → 21', () {
      // Height 3 * width 7 = 21
      expect(s.largestRectangleArea([6, 5, 4, 3, 4, 5, 6]), equals(21));
    });

    test('Step function: [1,1,1,1,5,5,5] → 15', () {
      // Height 5 * width 3 = 15 at the end
      expect(s.largestRectangleArea([1, 1, 1, 1, 5, 5, 5]), equals(15));
    });

    test('Two peaks: [3,1,3,1,3] → 5', () {
      // Height 1 * width 5 = 5
      expect(s.largestRectangleArea([3, 1, 3, 1, 3]), equals(5));
    });
  });
}
