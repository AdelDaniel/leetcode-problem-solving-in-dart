// https://leetcode.com/problems/two-sum/description/

import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  /// Faster Solution with HashMap
  /// TC: O(Log(n)) SC: O(n)
  List<int> twoSum(List<int> nums, int target) {
    final Map<int, int> map = <int, int>{};
    for (int i = 0; i < nums.length; i++) {
      int currentNum = nums[i];
      int otherNum = target - currentNum;
      if (map.containsKey(otherNum)) {
        return [i, map[otherNum]!]..sort();
      }
      map[currentNum] = i;
    }

    return [];
  }

  /// TC: O(Log(n^2)) SC: O(1)
  /// Slow Solution
  // List<int> twoSum(List<int> nums, int target) {
  //   final List<int> result = [];
  //   for (int i = 0; i < nums.length - 1; i++) {
  //     for (int j = i + 1; j < nums.length; j++) {
  //       if (nums[i] + nums[j] == target) {
  //         result.add(i);
  //         result.add(j);
  //         return result;
  //       }
  //     }
  //   }
  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Two Sum', () {
    test('Example 1: [2,7,11,15], target 9', () {
      final result = s.twoSum([2, 7, 11, 15], 9);
      expect(result, equals([0, 1]));
    });

    test('Example 2: [3,2,4], target 6', () {
      final result = s.twoSum([3, 2, 4], 6);
      expect(result, equals([1, 2]));
    });

    test('Example 3: [3,3], target 6', () {
      final result = s.twoSum([3, 3], 6);
      expect(result, equals([0, 1]));
    });

    test('Smallest array with negative numbers', () {
      final result = s.twoSum([-1, 2], 1);
      expect(result, equals([0, 1]));
    });

    test('Zero element solution', () {
      final result = s.twoSum([0, 4], 4);
      expect(result, equals([0, 1]));
    });

    test('Negative target sum', () {
      final result = s.twoSum([-3, -1], -4);
      expect(result, equals([0, 1]));
    });

    test('Duplicate numbers different indices', () {
      final result = s.twoSum([3, 2, 3], 6);
      expect(result, equals([0, 2]));
    });

    test('Large number overflow check', () {
      final result = s.twoSum([1000000000, 2000000000], 3000000000);
      expect(result, equals([0, 1]));
    });

    test('Zero in middle of array', () {
      final result = s.twoSum([0, -1, 5], -1);
      expect(result, equals([0, 1]));
    });

    test('Negative and positive combination', () {
      final result = s.twoSum([-5, -3, 2], -1);
      expect(result, equals([1, 2]));
    });

    test('Middle elements solution', () {
      final result = s.twoSum([10, 1, 2, 7], 9);
      expect(result, equals([2, 3]));
    });

    test('Non-consecutive indices', () {
      final result = s.twoSum([4, 5, 1, 3], 5);
      expect(result, equals([0, 2]));
    });

    test('Multiple duplicates valid pair', () {
      final result = s.twoSum([2, 2, 3], 4);
      expect(result, equals([0, 1]));
    });

    test('Large array with end solution', () {
      final nums = List.generate(10000, (i) => i)..add(10000);
      final result = s.twoSum(nums, 9999 + 10000);
      expect(result, equals([9999, 10000]));
    });

    test('Needle in haystack', () {
      final nums = List.generate(1000, (i) => 1)
        ..[500] = 2
        ..[700] = 3;
      final result = s.twoSum(nums, 5);
      expect(result, equals([500, 700]));
    });

    test('Maximum constraints test', () {
      final nums = List.generate(10000, (i) => i)..[5423] = 2147483647;
      final result = s.twoSum(nums, 2147483647 + 5422);
      expect(result, equals([5422, 5423]));
    });

    test('Alternating numbers', () {
      final result = s.twoSum([5, -5, 3, -3], 0);
      expect(result, anyOf(equals([0, 1]), equals([2, 3])));
    });
  });
}
