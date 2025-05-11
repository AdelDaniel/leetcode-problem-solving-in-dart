// https://leetcode.com/problems/first-missing-positive/description/

import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();

  runTests();
  print(Solution().firstMissingPositive([1, 2, 6, 3, 5, 4]));

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! Solved The problem
  ////? Hash map is good
  int firstMissingPositive(List<int> nums) {
    final Map<int, int> map = {};

    for (int i = 0; i < nums.length; i++) {
      if (nums[i] > 0) map[nums[i]] = 1;
    }

    for (int i = 1; i <= map.length + 1; i++) {
      if (map[i] == null) return i;
    }
    return -1;
  }

  /// Udemy Solution
  // int firstMissingPositive(List<int> nums) {
  //   int n = nums.length;

  //   // preprocess the array
  //   for (int i = 0; i < n; i++) {
  //     if (nums[i] <= 0) {
  //       nums[i] = n + 1;
  //     }
  //   }

  //   // marking indices
  //   for (int i = 0; i < n; i++) {
  //     int index = nums[i].abs() - 1;
  //     if (index < n && nums[index] > 0) {
  //       nums[index] *= -1;
  //     }
  //   }

  //   // scan the array
  //   for (int i = 0; i < n; i++) {
  //     if (nums[i] > 0) {
  //       return i + 1;
  //     }
  //   }

  //   return n + 1;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('First Missing Positive', () {
    // Basic examples from problem statement
    test('Example 1: [1,2,0] → 3', () {
      expect(s.firstMissingPositive([1, 2, 0]), equals(3));
    });

    test('Example: [1, 2, 6, 3, 5, 4] → 3', () {
      expect(s.firstMissingPositive([1, 2, 6, 3, 5, 4]), equals(7));
    });

    test('Example 2: [3,4,-1,1] → 2', () {
      expect(s.firstMissingPositive([3, 4, -1, 1]), equals(2));
    });

    test('Example 3: [7,8,9,11,12] → 1', () {
      expect(s.firstMissingPositive([7, 8, 9, 11, 12]), equals(1));
    });

    // Edge cases
    test('Single element array [1] → 2', () {
      expect(s.firstMissingPositive([1]), equals(2));
    });

    test('Single element array [2] → 1', () {
      expect(s.firstMissingPositive([2]), equals(1));
    });

    test('Single element array [0] → 1', () {
      expect(s.firstMissingPositive([0]), equals(1));
    });

    test('Single element array [-1] → 1', () {
      expect(s.firstMissingPositive([-1]), equals(1));
    });

    // All negatives
    test('All negatives: [-5,-3,-1] → 1', () {
      expect(s.firstMissingPositive([-5, -3, -1]), equals(1));
    });

    // All positives but missing first
    test('Missing first positive: [2,3,4] → 1', () {
      expect(s.firstMissingPositive([2, 3, 4]), equals(1));
    });

    // Complete sequence
    test('Complete sequence: [1,2,3,4] → 5', () {
      expect(s.firstMissingPositive([1, 2, 3, 4]), equals(5));
    });

    // Large numbers
    test('Large numbers: [2147483647] → 1', () {
      expect(s.firstMissingPositive([2147483647]), equals(1));
    });

    test('Large range: [1,2,3,...,99999,100000] → 100001', () {
      final nums = List.generate(100000, (i) => i + 1);
      expect(s.firstMissingPositive(nums), equals(100001));
    });

    // Missing in middle
    test('Missing in middle: [1,3,4,5] → 2', () {
      expect(s.firstMissingPositive([1, 3, 4, 5]), equals(2));
    });

    test('Multiple missing: [1,5,6] → 2', () {
      expect(s.firstMissingPositive([1, 5, 6]), equals(2));
    });

    // Duplicates
    test('With duplicates: [1,1,2,2] → 3', () {
      expect(s.firstMissingPositive([1, 1, 2, 2]), equals(3));
    });

    test('All duplicates: [7,7,7] → 1', () {
      expect(s.firstMissingPositive([7, 7, 7]), equals(1));
    });

    // Mixed cases
    test('Mixed positive/negative: [-1,-2,0,1,3] → 2', () {
      expect(s.firstMissingPositive([-1, -2, 0, 1, 3]), equals(2));
    });

    test('Mixed with large range: [1,1000] → 2', () {
      expect(s.firstMissingPositive([1, 1000]), equals(2));
    });

    // Maximum constraints
    test('Maximum length array with all numbers', () {
      final nums = List.generate(100000, (i) => i + 1);
      expect(s.firstMissingPositive(nums), equals(100001));
    });

    test('Maximum length array missing 1', () {
      final nums = List.generate(100000, (i) => i + 2);
      expect(s.firstMissingPositive(nums), equals(1));
    });
  });
}
