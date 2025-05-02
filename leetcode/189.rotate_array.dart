// https://leetcode.com/problems/rotate-array/description/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // GOOD: Function Execution Time : 32952 micro sec
  // BAD : Function Execution Time : 37960 micro sec
}

class Solution {
  ////! Best Solution
  /// After implement this solution will give you the same shape when you rotate the array
  /// TC: O(3n) == O(n) --- SC: O(1)
  void rotate(List<int> nums, int k) {
    if (nums.isEmpty || k == 0) return;

    final n = nums.length;
    k %= n;

    /// Reverse All The Array [1,2,3,4] --> [4,3,2,1]
    reverse(nums, 0, n - 1);

    /// Reverse First K Elements
    /// K = 2 --> from 0-2 --> [4,3,2,1] --> [3,4,2,1]
    reverse(nums, 0, k - 1);

    /// Reverse Remaining Elements
    /// K = 2 --> from 2-3 -->[3,4,2,1] --> [3,4,1,2]
    reverse(nums, k, n - 1);
  }

  /// How to reverse an array
  void reverse(List<int> nums, int start, int end) {
    while (start < end) {
      final temp = nums[start];
      nums[start] = nums[end];
      nums[end] = temp;
      start++;
      end--;
    }
  }

  ////! My First Solution
  // void rotate(List<int> nums, int k) {
  //   if (nums.length <= 1 || k == 0) return;
  //   k = k % nums.length;
  //   List<int> range = nums.getRange(0, nums.length - k).toList();
  //   nums
  //     ..removeRange(0, nums.length - k)
  //     ..addAll(range);
  // }

  ////! Time Limit --> Slow
  // void rotate(List<int> nums, int k) {
  //   if (nums.length <= 1 || k == 0) return;
  //   k = k % nums.length;

  //   for (int i = 0; i < k; i++) {
  //     nums.insert(0, nums.removeLast());
  //   }
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Rotate Array', () {
    // Basic examples from problem statement

    test('Example 1: [1,2,3,4], k=2', () {
      final nums = [1, 2, 3, 4];
      s.rotate(nums, 2);
      expect(nums, equals([3, 4, 1, 2]));
    });

    test('Example 1: [1,2,3,4,5,6,7], k=3', () {
      final nums = [1, 2, 3, 4, 5, 6, 7];
      s.rotate(nums, 3);
      expect(nums, equals([5, 6, 7, 1, 2, 3, 4]));
    });

    test('Example 2: [-1,-100,3,99], k=2', () {
      final nums = [-1, -100, 3, 99];
      s.rotate(nums, 2);
      expect(nums, equals([3, 99, -1, -100]));
    });

    // Edge cases
    test('Single element array: [5], k=1', () {
      final nums = [5];
      s.rotate(nums, 1);
      expect(nums, equals([5]));
    });

    test('Single element array: [5], k=100', () {
      final nums = [5];
      s.rotate(nums, 100);
      expect(nums, equals([5]));
    });

    test('Empty array: [], k=5', () {
      final nums = <int>[];
      s.rotate(nums, 5);
      expect(nums, equals([]));
    });

    // k larger than array length
    test('k equals array length: [1,2,3], k=3', () {
      final nums = [1, 2, 3];
      s.rotate(nums, 3);
      expect(nums, equals([1, 2, 3]));
    });

    test('k larger than array length: [1,2,3], k=4', () {
      final nums = [1, 2, 3];
      s.rotate(nums, 4);
      expect(nums, equals([3, 1, 2]));
    });

    // Multiple rotations
    test('Multiple rotations: [1,2,3,4,5], k=7', () {
      final nums = [1, 2, 3, 4, 5];
      s.rotate(nums, 7);
      expect(nums, equals([4, 5, 1, 2, 3]));
    });

    // No rotation
    test('k=0: [1,2,3,4]', () {
      final nums = [1, 2, 3, 4];
      s.rotate(nums, 0);
      expect(nums, equals([1, 2, 3, 4]));
    });

    // Negative numbers
    test('Negative numbers: [-1,-2,-3,-4,-5], k=2', () {
      final nums = [-1, -2, -3, -4, -5];
      s.rotate(nums, 2);
      expect(nums, equals([-4, -5, -1, -2, -3]));
    });

    // Large k values
    test('Very large k: [1,2,3,4,5], k=100000', () {
      final nums = [1, 2, 3, 4, 5];
      s.rotate(nums, 100000);
      expect(nums, equals([1, 2, 3, 4, 5]));
    });

    // Large array
    test('Large array rotation', () {
      final nums = List.generate(100000, (i) => i);
      final expected = List.generate(100000, (i) => i < 3 ? 99997 + i : i - 3);
      s.rotate(nums, 3);
      expect(nums, equals(expected));
    });

    // Special cases
    test('All same elements: [2,2,2,2], k=2', () {
      final nums = [2, 2, 2, 2];
      s.rotate(nums, 2);
      expect(nums, equals([2, 2, 2, 2]));
    });

    test('Alternating elements: [1,-1,1,-1], k=3', () {
      final nums = [1, -1, 1, -1];
      s.rotate(nums, 3);
      expect(nums, equals([-1, 1, -1, 1]));
    });

    // Maximum constraints
    test('Maximum array size with k=1', () {
      final nums = List.generate(100000, (i) => i);
      final expected = [99999, ...List.generate(99999, (i) => i)];
      s.rotate(nums, 1);
      expect(nums, equals(expected));
    });

    // New test cases
    test('Two elements with k=3: [1,2] → [2,1]', () {
      final nums = [1, 2];
      s.rotate(nums, 3);
      expect(nums, equals([2, 1]));
    });

    test('Single negative element with k=2: [-1] → [-1]', () {
      final nums = [-1];
      s.rotate(nums, 2);
      expect(nums, equals([-1]));
    });
  });
}
