// https://leetcode.com/problems/subarray-product-less-than-k/description/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  ////! Done: Solved the problem
  int numSubarrayProductLessThanK(List<int> nums, int k) {
    /// Check if empty Array
    if (nums.isEmpty) {
      return 0;
    }

    /// Check if the list only one item
    if (nums.length == 1) {
      if (nums.first < k) {
        return 1;
      } else {
        return 0;
      }
    }

    int subArraysCount = 0;
    int startPointerIndex = 0;
    int endPointerIndex = 0;
    int score = nums[endPointerIndex];

    while (endPointerIndex < nums.length) {
      if (score < k) {
        subArraysCount += endPointerIndex - startPointerIndex + 1;
        endPointerIndex++;
        if (endPointerIndex < nums.length) {
          score *= nums[endPointerIndex];
        }
      } else {
        if (startPointerIndex < nums.length) {
          score ~/= nums[startPointerIndex];
        } else {
          break;
        }
        startPointerIndex++;
        if (endPointerIndex < startPointerIndex) {
          endPointerIndex++;
          if (endPointerIndex < nums.length) {
            score *= nums[endPointerIndex];
          }
        }
      }
    }

    return subArraysCount;
  }

  int factorialIterative(int n) {
    int result = 1;
    for (int i = 1; i <= n; i++) {
      result *= i;
    }
    return result;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Subarray Product Less Than K', () {
    // Basic examples from problem statement
    test('Example 1: [10,5,2,6], k=100 → 8', () {
      expect(s.numSubarrayProductLessThanK([10, 5, 2, 6], 100), equals(8));
    });

    test('Example 2: [1,2,3], k=0 → 0', () {
      expect(s.numSubarrayProductLessThanK([1, 2, 3], 0), equals(0));
    });

    // Edge cases
    test('Single element below k: [5], k=10 → 1', () {
      expect(s.numSubarrayProductLessThanK([5], 10), equals(1));
    });

    test('Single element above k: [5], k=4 → 0', () {
      expect(s.numSubarrayProductLessThanK([5], 4), equals(0));
    });

    test('Empty array: [], k=100 → 0', () {
      expect(s.numSubarrayProductLessThanK([], 100), equals(0));
    });

    // All elements below k
    test('All elements below k: [1,2,3,4], k=100 → 10', () {
      expect(s.numSubarrayProductLessThanK([1, 2, 3, 4], 100), equals(10));
    });

    // All elements above k
    test('All elements above k: [10,20,30], k=5 → 0', () {
      expect(s.numSubarrayProductLessThanK([10, 20, 30], 5), equals(0));
    });

    test('With 1s: [1,1,1,1], k=2 → 10', () {
      expect(s.numSubarrayProductLessThanK([1, 1, 1, 1], 2), equals(10));
    });

    // Large k
    test('Large k: [1,2,3], k=1000 → 6', () {
      expect(s.numSubarrayProductLessThanK([1, 2, 3], 1000), equals(6));
    });

    // k=1 edge case
    test('k=1: [1,1,1], k=1 → 0', () {
      expect(s.numSubarrayProductLessThanK([1, 1, 1], 1), equals(0));
    });

    // Large array
    test('Large array with small k', () {
      final nums = List.filled(30000, 2);
      expect(s.numSubarrayProductLessThanK(nums, 1), equals(0));
    });

    test('Large array with large k', () {
      final nums = List.filled(30000, 1);
      expect(s.numSubarrayProductLessThanK(nums, 1000000),
          equals(30000 * 30001 ~/ 2));
    });

    // Minimum constraints
    test('Minimum length: [1], k=1 → 0', () {
      expect(s.numSubarrayProductLessThanK([1], 1), equals(0));
    });

    /// Leet Code
    test('Example: [1,2,3,4,5], k=1 → 0', () {
      expect(s.numSubarrayProductLessThanK([1, 2, 3, 4, 5], 1), equals(0));
    });
  });
}
