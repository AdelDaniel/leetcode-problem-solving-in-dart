// https://leetcode.com/problems/move-zeroes/description/
import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  ///! Nicer and More Clear Solution:: TC: O(n) SC: O(1)
  /// Two Pointers Solution
  void moveZeroes(List<int> nums) {
    int left = 0;
    int right = 0;
    for (right = 0; right < nums.length; right++) {
      if (nums[right] != 0) {
        nums[left] = nums[right];
        left++;
      }
    }

    for (int i = left; i < nums.length; i++) {
      nums[i] = 0;
    }
  }

  ///! Nice Solution:: TC: O(n) SC: O(1)
  /// Two Pointers Solution
  // void moveZeroes(List<int> nums) {
  //   int left = 0;
  //   int right = 0;
  //   while (left < nums.length || right < nums.length) {
  //     if (right == nums.length) {
  //       nums[left] = 0;
  //       left++;
  //       continue;
  //     }
  //     if (nums[right] != 0) {
  //       nums[left] = nums[right];
  //       left++;
  //       right++;
  //     } else {
  //       right++;
  //     }
  //   }
  // }

  ///! Good::  TC: O(n) SC: O(1)
  // void moveZeroes(List<int> nums) {
  //   int zerosNumber = 0;
  //   for (int i = 0; i < nums.length; i++) {
  //     if (nums[i] == 0) {
  //       zerosNumber++;
  //       nums.removeAt(i);
  //       i--;
  //     }
  //   }
  //   nums.addAll(List.filled(zerosNumber, 0));
  // }

  ///! BAD:: TC: O(2n) SC: O(n)
  // void moveZeroes(List<int> nums) {
  //   List<int> zerosIndex = [];
  //   for (int i = 0; i < nums.length; i++) {
  //     if (nums[i] == 0) {
  //       zerosIndex.add(i);
  //     }
  //   }

  //   for (int i = 0; i < zerosIndex.length; i++) {
  //     /// This [indexToRemove] used because each time you remove an element, the array is shifted -1
  //     /// So then the next index of zero will be his [index - 1]
  //     int indexToRemove = zerosIndex[i] - i;
  //     nums.removeAt(indexToRemove);
  //     nums.add(0);
  //   }
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Move Zeroes', () {
    test('Example 1: [0,1,0,3,12]', () {
      final nums = [0, 1, 0, 3, 12];
      s.moveZeroes(nums);
      expect(nums, equals([1, 3, 12, 0, 0]));
    });

    test('Example 2: [0]', () {
      final nums = [0];
      s.moveZeroes(nums);
      expect(nums, equals([0]));
    });

    test('No zeros: [1,2,3]', () {
      final nums = [1, 2, 3];
      s.moveZeroes(nums);
      expect(nums, equals([1, 2, 3]));
    });

    test('All zeros except one: [0,0,0,5]', () {
      final nums = [0, 0, 0, 5];
      s.moveZeroes(nums);
      expect(nums, equals([5, 0, 0, 0]));
    });

    test('All zeros: [0,0,0]', () {
      final nums = [0, 0, 0];
      s.moveZeroes(nums);
      expect(nums, equals([0, 0, 0]));
    });

    test('Zeros already at end: [1,2,0,0]', () {
      final nums = [1, 2, 0, 0];
      s.moveZeroes(nums);
      expect(nums, equals([1, 2, 0, 0]));
    });

    test('Zeros at beginning: [0,0,1,2]', () {
      final nums = [0, 0, 1, 2];
      s.moveZeroes(nums);
      expect(nums, equals([1, 2, 0, 0]));
    });

    test('Alternating zeros and non-zeros: [1,0,2]', () {
      final nums = [1, 0, 2];
      s.moveZeroes(nums);
      expect(nums, equals([1, 2, 0]));
    });

    test('Negative numbers: [0,-1,3,0,-2]', () {
      final nums = [0, -1, 3, 0, -2];
      s.moveZeroes(nums);
      expect(nums, equals([-1, 3, -2, 0, 0]));
    });

    test('Zeros in middle: [1,3,0,0,2]', () {
      final nums = [1, 3, 0, 0, 2];
      s.moveZeroes(nums);
      expect(nums, equals([1, 3, 2, 0, 0]));
    });

    test('Single non-zero: [5]', () {
      final nums = [5];
      s.moveZeroes(nums);
      expect(nums, equals([5]));
    });

    test('Alternating pattern: [0,5,0,3,0]', () {
      final nums = [0, 5, 0, 3, 0];
      s.moveZeroes(nums);
      expect(nums, equals([5, 3, 0, 0, 0]));
    });

    test('Minimal case: [0,1]', () {
      final nums = [0, 1];
      s.moveZeroes(nums);
      expect(nums, equals([1, 0]));
    });

    test('Multiple non-consecutive zeros: [4,0,5,0,3]', () {
      final nums = [4, 0, 5, 0, 3];
      s.moveZeroes(nums);
      expect(nums, equals([4, 5, 3, 0, 0]));
    });

    test('Large numbers: [2147483647,0,-2147483648]', () {
      final nums = [2147483647, 0, -2147483648];
      s.moveZeroes(nums);
      expect(nums, equals([2147483647, -2147483648, 0]));
    });

    test('Large array with spread zeros', () {
      final nums = List.generate(10000, (i) => i % 2 == 0 ? 0 : i);
      final expected =
          nums.where((n) => n != 0).toList() + List.filled(nums.length ~/ 2, 0);
      s.moveZeroes(nums);
      expect(nums, equals(expected));
    });
  });
}
