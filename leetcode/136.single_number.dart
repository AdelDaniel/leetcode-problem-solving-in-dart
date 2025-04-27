// https://leetcode.com/problems/single-number/description/
import 'dart:math';

import 'package:test/test.dart';

void main() {
  runTests();
  // Solution().singleNumber([1, 2, 3, 4, 4, 3, 2]);
}

/// All Solutions Works only if the number is repeat only one time more
class Solution {
  /// XOR: Best Solution Depends on XOR
  int singleNumber(List<int> nums) {
    int number = 0;
    for (final int num in nums) {
      number = number ^ num;
    }
    return number;
  }

  /// Solution Depend on sets
  /// Slow and Bad Solution
  // int singleNumber(List<int> nums) {
  //   final Set<int> set = {};
  //   for (final int num in nums) {
  //     set.contains(num) ? set.remove(num) : set.add(num);
  //   }
  //   return set.first;
  // }

  /// Slow and Bad Solution
  /// Solution Depend on Map
  // int singleNumber(List<int> nums) {
  //   final Map<int, int> map = {};
  //   for (final int num in nums) {
  //     if (map.containsKey(num)) {
  //       map.remove(num);
  //     } else {
  //       map[num] = num;
  //     }
  //   }
  //   return map.keys.first;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Single Number', () {
    // Basic test cases
    test('Example 1: [2,2,1]', () {
      expect(s.singleNumber([2, 2, 1]), equals(1));
    });

    test('Example 2: [4,1,2,1,2]', () {
      expect(s.singleNumber([4, 1, 2, 1, 2]), equals(4));
    });

    test('Example 3: [1] (single element)', () {
      expect(s.singleNumber([1]), equals(1));
    });

    // Small arrays
    test('Pair at beginning [3,3,2]', () {
      expect(s.singleNumber([3, 3, 2]), equals(2));
    });

    test('Pair at end [1,3,3]', () {
      expect(s.singleNumber([1, 3, 3]), equals(1));
    });

    // Medium arrays
    test('Multiple pairs with single in middle [4,2,3,2,3]', () {
      expect(s.singleNumber([4, 2, 3, 2, 3]), equals(4));
    });

    test('Single at beginning [5,4,4,3,3]', () {
      expect(s.singleNumber([5, 4, 4, 3, 3]), equals(5));
    });

    test('Single at end [2,2,3,3,1]', () {
      expect(s.singleNumber([2, 2, 3, 3, 1]), equals(1));
    });

    // Negative numbers
    test('Negative numbers [-1,-1,-2]', () {
      expect(s.singleNumber([-1, -1, -2]), equals(-2));
    });

    test('Mixed positive and negative [1,-1,1]', () {
      expect(s.singleNumber([1, -1, 1]), equals(-1));
    });

    // Larger arrays
    test('Larger array with single in middle', () {
      expect(
        s.singleNumber([10, 20, 30, 40, 30, 20, 10]),
        equals(40),
      );
    });

    test('Large array with single at beginning', () {
      final nums = List.generate(10000, (i) => i + 1)
          .followedBy(List.generate(10000, (i) => i + 1))
          .toList()
        ..insert(0, 0);
      expect(s.singleNumber(nums), equals(0));
    });

    test('Large array with single at end', () {
      final nums = List.generate(10000, (i) => i)
          .followedBy(List.generate(10000, (i) => i))
          .toList()
        ..add(10000);
      expect(s.singleNumber(nums), equals(10000));
    });

    // Edge cases
    test('Maximum constraint array', () {
      final nums = List.generate(30000, (i) => i ~/ 2)
          .followedBy(List.generate(30000, (i) => i ~/ 2))
          .toList()
        ..add(30000);
      expect(s.singleNumber(nums), equals(30000));
    });

    test('Minimum value in array', () {
      expect(s.singleNumber([-30000, 1, 1]), equals(-30000));
    });

    test('Maximum value in array', () {
      expect(s.singleNumber([30000, 1, 1]), equals(30000));
    });

    test('All pairs except one (large random array)', () {
      final random = Random();
      final single = random.nextInt(60001) - 30000;
      final firstHalf =
          List.generate(14999, (i) => random.nextInt(60001) - 30000);
      final nums = [...firstHalf, ...firstHalf, single]..shuffle();
      expect(s.singleNumber(nums), equals(single));
    });
  });
}
