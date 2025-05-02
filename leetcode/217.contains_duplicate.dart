// https://leetcode.com/problems/contains-duplicate/

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
  /// This is ART
  bool containsDuplicate(List<int> nums) {
    return Set.from(nums).length != nums.length;
  }

  /// Using Set And Enhance --> TC: O(n) SC: O(n)
  // bool containsDuplicate(List<int> nums) {
  //   final Set<int> set = <int>{};
  //   for (int num in nums) {
  //     if (!set.add(num)) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  /// Using Set instead of Map --> TC: O(n) SC: O(n)
  // bool containsDuplicate(List<int> nums) {
  //   final Set<int> set = <int>{};
  //   for (int i = 0; i < nums.length; i++) {
  //     if (set.contains(nums[i])) {
  //       return true;
  //     }
  //     set.add(nums[i]);
  //   }
  //   return false;
  // }

  ///! TC: O(n) SC: O(n)
  // bool containsDuplicate(List<int> nums) {
  //   final Map<int, int> map = <int, int>{};
  //   for (int i = 0; i < nums.length; i++) {
  //     if (map.containsKey(nums[i])) {
  //       return true;
  //     }
  //     map[nums[i]] = i;
  //   }
  //   return false;
  // }
}

void runTests() {
  final Solution s = Solution();

  for (var i = 0; i < 100; i++) {
    group('Contains Duplicate', () {
      // Basic examples from problem statement
      test('Example 1: [1,2,3,1]', () {
        expect(s.containsDuplicate([1, 2, 3, 1]), isTrue);
      });

      test('Example 2: [1,2,3,4]', () {
        expect(s.containsDuplicate([1, 2, 3, 4]), isFalse);
      });

      test('Example 3: [1,1,1,3,3,4,3,2,4,2]', () {
        expect(s.containsDuplicate([1, 1, 1, 3, 3, 4, 3, 2, 4, 2]), isTrue);
      });

      // Edge cases
      test('Single element array', () {
        expect(s.containsDuplicate([5]), isFalse);
      });

      test('Two identical elements', () {
        expect(s.containsDuplicate([7, 7]), isTrue);
      });

      test('Two distinct elements', () {
        expect(s.containsDuplicate([8, 9]), isFalse);
      });

      // Large numbers
      test('Large positive numbers', () {
        expect(
            s.containsDuplicate([1000000000, 1000000001, 1000000000]), isTrue);
      });

      test('Large negative numbers', () {
        expect(s.containsDuplicate([-1000000000, -1000000001, -1000000000]),
            isTrue);
      });

      test('Mixed large positive and negative', () {
        expect(s.containsDuplicate([-2147483648, 2147483647, -2147483648]),
            isTrue);
      });

      // Duplicate positions
      test('Duplicates at start', () {
        expect(s.containsDuplicate([1, 1, 2, 3]), isTrue);
      });

      test('Duplicates at end', () {
        expect(s.containsDuplicate([1, 2, 3, 3]), isTrue);
      });

      test('Duplicates in middle', () {
        expect(s.containsDuplicate([1, 2, 2, 3]), isTrue);
      });

      // Large arrays
      test('Large array with no duplicates', () {
        final nums = List.generate(100000, (i) => i);
        expect(s.containsDuplicate(nums), isFalse);
      });

      test('Large array with duplicates at end', () {
        final nums = List.generate(100000, (i) => i)..add(99999);
        expect(s.containsDuplicate(nums), isTrue);
      });

      test('Large array with early duplicate', () {
        final nums = List.generate(100000, (i) => i)..[50000] = 0;
        expect(s.containsDuplicate(nums), isTrue);
      });

      // All identical elements
      test('All elements same', () {
        expect(s.containsDuplicate([5, 5, 5, 5]), isTrue);
      });

      // Minimum and maximum constraints
      test('Minimum array length', () {
        expect(s.containsDuplicate([1]), isFalse);
      });

      test('Maximum constraint values', () {
        expect(s.containsDuplicate([-1000000000, 1000000000]), isFalse);
      });

      // Random test cases
      test('Random array with no duplicates', () {
        expect(s.containsDuplicate([3, 7, 2, 9, 5]), isFalse);
      });

      test('Random array with duplicates', () {
        expect(s.containsDuplicate([4, 2, 7, 4, 1]), isTrue);
      });
    });
  }
}
