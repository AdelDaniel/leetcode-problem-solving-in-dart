// leetcode/169.majority_element.dart
// https://leetcode.com/problems/majority-element/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.majorityElement([6, 5, 5]);
  s.majorityElement([2, 2, 1, 1, 1, 2, 2]);

  /// Run All tests
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Solved O(n) time and O(n) space with HashMap
  int majorityElement(List<int> nums) {
    final Map hashMap = <int, int>{
      nums[0]: 1,
    };
    int maxRepeatedKey = nums[0];
    int maxRepeatedValue = 1;
    for (int i = 1; i < nums.length; i++) {
      int newValue;
      int key = nums[i];
      if (!hashMap.containsKey(key)) {
        hashMap[key] = 1;
        newValue = 1;
      } else {
        newValue = (hashMap[key]) + 1;
        hashMap[key] = newValue;
      }
      if (newValue > maxRepeatedValue) {
        maxRepeatedValue = newValue;
        maxRepeatedKey = key;
      }
    }

    return maxRepeatedKey;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Majority Element', () {
    // Basic examples from problem statement
    test('Example 1: [3,2,3] → 3', () {
      expect(s.majorityElement([3, 2, 3]), equals(3));
    });

    test('Example 2: [2,2,1,1,1,2,2] → 2', () {
      expect(s.majorityElement([2, 2, 1, 1, 1, 2, 2]), equals(2));
    });

    // Edge cases - single element
    test('Single element: [1] → 1', () {
      expect(s.majorityElement([1]), equals(1));
    });

    test('Single negative element: [-5] → -5', () {
      expect(s.majorityElement([-5]), equals(-5));
    });

    test('Single zero: [0] → 0', () {
      expect(s.majorityElement([0]), equals(0));
    });

    // Small arrays
    test('Two same elements: [7,7] → 7', () {
      expect(s.majorityElement([7, 7]), equals(7));
    });

    test('Majority appears twice in three elements: [1,2,1] → 1', () {
      expect(s.majorityElement([1, 2, 1]), equals(1));
    });

    test('Majority at end: [4,3,4] → 4', () {
      expect(s.majorityElement([4, 3, 4]), equals(4));
    });

    // Majority clearly dominant
    test('All elements same: [5,5,5,5,5] → 5', () {
      expect(s.majorityElement([5, 5, 5, 5, 5]), equals(5));
    });

    test('Majority dominates strongly: [9,9,9,9,1,2,3] → 9', () {
      expect(s.majorityElement([9, 9, 9, 9, 1, 2, 3]), equals(9));
    });

    // Majority just over half
    test('Majority just over half odd length: [1,1,2] → 1', () {
      expect(s.majorityElement([1, 1, 2]), equals(1));
    });

    test('Majority just over half even length: [2,2,2,1] → 2', () {
      expect(s.majorityElement([2, 2, 2, 1]), equals(2));
    });

    test('Majority just over half larger array: [3,3,4,2,3,3,5] → 3', () {
      expect(s.majorityElement([3, 3, 4, 2, 3, 3, 5]), equals(3));
    });

    // Negative numbers
    test('Negative majority: [-1,-1,-1,2,3] → -1', () {
      expect(s.majorityElement([-1, -1, -1, 2, 3]), equals(-1));
    });

    test('Mixed negatives and positives: [-2,-2,1,1,-2] → -2', () {
      expect(s.majorityElement([-2, -2, 1, 1, -2]), equals(-2));
    });

    // Zero as majority
    test('Zero majority: [0,0,0,1,2] → 0', () {
      expect(s.majorityElement([0, 0, 0, 1, 2]), equals(0));
    });

    test('Zero majority with negatives: [0,-1,0,2,0] → 0', () {
      expect(s.majorityElement([0, -1, 0, 2, 0]), equals(0));
    });

    // Majority in different positions
    test('Majority at beginning: [8,8,8,1,2,3,8] → 8', () {
      expect(s.majorityElement([8, 8, 8, 1, 2, 3, 8]), equals(8));
    });

    test('Majority at end: [1,2,3,7,7,7,7] → 7', () {
      expect(s.majorityElement([1, 2, 3, 7, 7, 7, 7]), equals(7));
    });

    test('Majority spread out: [6,1,6,2,6,3,6] → 6', () {
      expect(s.majorityElement([6, 1, 6, 2, 6, 3, 6]), equals(6));
    });

    // Boyer-Moore style cancellation cases
    test('Cancellation case 1: [2,1,2,1,2] → 2', () {
      expect(s.majorityElement([2, 1, 2, 1, 2]), equals(2));
    });

    test('Cancellation case 2: [4,5,4,5,4,5,4] → 4', () {
      expect(s.majorityElement([4, 5, 4, 5, 4, 5, 4]), equals(4));
    });

    test('Cancellation case 3: [10,9,10,8,10,7,10] → 10', () {
      expect(s.majorityElement([10, 9, 10, 8, 10, 7, 10]), equals(10));
    });

    // Large values within constraints
    test(
        'Large positive values: [1000000000,1000000000,-1,1000000000] → 1000000000',
        () {
      expect(s.majorityElement([1000000000, 1000000000, -1, 1000000000]),
          equals(1000000000));
    });

    test(
        'Large negative values: [-1000000000,-1000000000,5,-1000000000] → -1000000000',
        () {
      expect(s.majorityElement([-1000000000, -1000000000, 5, -1000000000]),
          equals(-1000000000));
    });

    // Random cases
    test('Random case 1: [1,3,1,1,4] → 1', () {
      expect(s.majorityElement([1, 3, 1, 1, 4]), equals(1));
    });

    test('Random case 2: [7,7,2,7,3,7,7] → 7', () {
      expect(s.majorityElement([7, 7, 2, 7, 3, 7, 7]), equals(7));
    });

    test('Random case 3: [11,11,11,2,2] → 11', () {
      expect(s.majorityElement([11, 11, 11, 2, 2]), equals(11));
    });

    test('Random case 4: [4,4,4,1,2,4,3] → 4', () {
      expect(s.majorityElement([4, 4, 4, 1, 2, 4, 3]), equals(4));
    });

    test('Random case 5: [9,1,9,2,9,3,9,4,9] → 9', () {
      expect(s.majorityElement([9, 1, 9, 2, 9, 3, 9, 4, 9]), equals(9));
    });

    // Performance tests
    test('Large array all same', () {
      final nums = List.generate(50000, (_) => 1);
      expect(s.majorityElement(nums), equals(1));
    });

    test('Large array majority spread out', () {
      final nums = <int>[];
      for (int i = 0; i < 25001; i++) {
        nums.add(5);
      }
      for (int i = 0; i < 24999; i++) {
        nums.add(i);
      }
      nums.shuffle();
      expect(s.majorityElement(nums), equals(5));
    });

    // Verification against frequency count for a small case
    test('Verification against counting for small array', () {
      final nums = [2, 2, 1, 3, 2, 4, 2];

      final Map<int, int> freq = {};
      for (final num in nums) {
        freq[num] = (freq[num] ?? 0) + 1;
      }

      int expected = nums[0];
      int bestCount = 0;
      freq.forEach((key, value) {
        if (value > bestCount) {
          bestCount = value;
          expected = key;
        }
      });

      expect(s.majorityElement(nums), equals(expected));
    });
  });
}
