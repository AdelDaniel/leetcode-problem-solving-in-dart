import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  /// TC: O(Log n) --  SC: O(1)
  int search(List<int> nums, int target) {
    int firstIndex = 0;
    int lastIndex = nums.length - 1;

    int leftIndex = firstIndex;
    int rightIndex = lastIndex;
    int middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;

    /// get the index of the smallestNumber of the nums
    while (leftIndex <= rightIndex) {
      middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;
      if (nums[middleIndex] == target) {
        return middleIndex;

        /// Is Left Side Sorted && Left Side Cotains The Target.
        /// Then search in the left side.
      } else if (nums[leftIndex] <= nums[middleIndex]) {
        if (nums[leftIndex] <= target && nums[middleIndex] > target) {
          rightIndex = middleIndex - 1;
        } else {
          leftIndex = middleIndex + 1;
        }

        /// Else: the right side is sorted && right Side Cotains The Target.
        /// Then search in the Right side.
      } else {
        /// Check the target is in the sorted range or the other range
        if (nums[middleIndex] < target && nums[rightIndex] >= target) {
          leftIndex = middleIndex + 1;
        } else {
          rightIndex = middleIndex - 1;
        }
      }
    }

    return -1;
  }

  /// Solution 2 ----- Right Solution ----- 
  /// TC: O(Log n) --  SC: O(1)
  /// 
  // int search(List<int> nums, int target) {
  //   int firstIndex = 0;
  //   int lastIndex = nums.length - 1;

  //   int leftIndex = firstIndex;
  //   int rightIndex = lastIndex;
  //   int middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;

  //   /// get the index of the smallestNumber of the nums
  //   while (leftIndex <= rightIndex) {
  //     middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;
  //     if (nums[middleIndex] == target) {
  //       return middleIndex;

  //       /// Is Left Side Sorted && Left Side Cotains The Target.
  //       /// Then search in the left side.
  //     } else if (nums[leftIndex] < nums[middleIndex]) {
  //       if (nums[leftIndex] <= target && nums[middleIndex] > target) {
  //         rightIndex = middleIndex - 1;
  //       } else {
  //         leftIndex = middleIndex + 1;
  //       }

  //       /// Else: the right side is sorted && right Side Cotains The Target.
  //       /// Then search in the Right side.
  //     } else if (nums[middleIndex] < nums[rightIndex]) {
  //       /// Check the target is in the sorted range or the other range
  //       if (nums[middleIndex] < target && nums[rightIndex] >= target) {
  //         leftIndex = middleIndex + 1;
  //       } else {
  //         rightIndex = middleIndex - 1;
  //       }
  //     } else if (nums[leftIndex] == nums[middleIndex]) {
  //       leftIndex = middleIndex + 1;
  //     } else if (nums[rightIndex] == nums[middleIndex]) {
  //       rightIndex = middleIndex - 1;
  //     }
  //   }

  //   return -1;
  // }

  /// Solution 3 ----- Right Solution -----
  // int search(List<int> nums, int target) {
  //   int firstIndex = 0;
  //   int lastIndex = nums.length - 1;

  //   int leftIndex = firstIndex;
  //   int rightIndex = lastIndex;
  //   int middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;
  //   int smallestNumberIndex = middleIndex;

  //   /// get the index of the smallestNumber of the nums
  //   while (leftIndex < rightIndex) {
  //     smallestNumberIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;
  //     if (nums[smallestNumberIndex] == target) {
  //       return smallestNumberIndex;
  //     } else if (leftIndex == (rightIndex - 1)) {
  //       if (nums[leftIndex] > nums[rightIndex]) {
  //         smallestNumberIndex = rightIndex;
  //       } else {
  //         smallestNumberIndex = leftIndex;
  //       }
  //       break;
  //     } else if (nums[smallestNumberIndex] > nums[rightIndex]) {
  //       leftIndex = smallestNumberIndex;
  //     } else {
  //       rightIndex = smallestNumberIndex;
  //     }
  //   }

  //   if (nums[smallestNumberIndex] <= target && nums[lastIndex] >= target) {
  //     leftIndex = smallestNumberIndex;
  //     rightIndex = lastIndex;
  //   } else {
  //     leftIndex = firstIndex;
  //     rightIndex = smallestNumberIndex - 1 == 0 ? 0 : smallestNumberIndex - 1;
  //   }
  //   middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;

  //   while (leftIndex <= rightIndex) {
  //     middleIndex = leftIndex + (rightIndex - leftIndex) ~/ 2;
  //     if (nums[middleIndex] == target) {
  //       return middleIndex;
  //     } else if (target < nums[middleIndex]) {
  //       rightIndex = middleIndex - 1;
  //     } else {
  //       leftIndex = middleIndex + 1;
  //     }
  //   }

  //   return -1;
  // }
}

void runTests() {
  final Solution s = Solution();
  group('Search in Rotated Sorted Array', () {
    test('Example 1: Target found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), equals(4));
    });

    test('Example 2: Target not found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 3), equals(-1));
    });

    test('Example 3: Single element array, target not found', () {
      expect(s.search([1], 0), equals(-1));
    });

    test('No rotation, target found', () {
      expect(s.search([1, 2, 3, 4, 5, 6, 7], 4), equals(3));
    });

    test('Full rotation, target found', () {
      expect(s.search([1, 2, 3, 4, 5, 6, 7], 7), equals(6));
    });

    test('Rotation at middle, target found', () {
      expect(s.search([6, 7, 1, 2, 3, 4, 5], 7), equals(1));
    });

    test('Target is the pivot (smallest element)', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), equals(4));
    });

    test('Target is the last element', () {
      expect(s.search([5, 6, 7, 0, 1, 2, 4], 4), equals(6));
    });

    test('Target is the first element', () {
      expect(s.search([5, 6, 7, 0, 1, 2, 4], 5), equals(0));
    });

    test('Target not in array but in range', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 3), equals(-1));
    });

    test('Target not in array (out of range)', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 10), equals(-1));
    });

    test('Single element array, target found', () {
      expect(s.search([1], 1), equals(0));
    });

    test('Large rotation (pivot near end)', () {
      expect(s.search([2, 3, 4, 5, 6, 7, 8, 9, 0, 1], 9), equals(7));
    });

    test('Large rotation (pivot near start)', () {
      expect(s.search([8, 9, 0, 1, 2, 3, 4, 5, 6, 7], 9), equals(1));
    });

    test('All elements same except one', () {
      expect(s.search([1, 1, 1, 1, 1, 1, 0, 1, 1], 0), equals(6));
    });

    test('Example 1: Target found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), 4);
    });

    test('Example 2: Target not found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 3), -1);
    });

    test('Example 3: Single element array, target not found', () {
      expect(s.search([1], 0), -1);
    });

    test('Single element array, target found', () {
      expect(s.search([1], 1), 0);
    });

    test('Array not rotated, target found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 4), 4);
    });

    test('Array not rotated, target not found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 8), -1);
    });

    test('Rotation at the beginning', () {
      expect(s.search([1, 2, 3, 4, 5, 6, 7, 0], 0), 7);
    });

    test('Rotation at the end', () {
      expect(s.search([7, 0, 1, 2, 3, 4, 5, 6], 7), 0);
    });

    test('Large array, target in the first half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 4),
          12);
    });

    test('Large array, target in the second half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 10),
          2);
    });
    test('Duplicate at the pivot, target found', () {
      expect(s.search([3, 1, 1, 1, 1], 3), 0);
    });
    test('Duplicate at the pivot, target not found', () {
      expect(s.search([3, 1, 1, 1, 1], 2), -1);
    });

    test('Example 1: Target found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), 4);
    });

    test('Example 2: Target not found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 3), -1);
    });

    test('Example 3: Single element array, target not found', () {
      expect(s.search([1], 0), -1);
    });

    test('Single element array, target found', () {
      expect(s.search([1], 1), 0);
    });

    test('Array not rotated, target found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 4), 4);
    });

    test('Array not rotated, target not found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 8), -1);
    });

    test('Rotation at the beginning', () {
      expect(s.search([1, 2, 3, 4, 5, 6, 7, 0], 0), 7);
    });

    test('Rotation at the end', () {
      expect(s.search([7, 0, 1, 2, 3, 4, 5, 6], 7), 0);
    });

    test('Large array, target in the first half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 4),
          12);
    });

    test('Large array, target in the second half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 10),
          2);
    });

    // Added more test cases
    test('Target is the first element after rotation', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), 4);
    });

    test('Target is the last element before rotation', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 7), 3);
    });

    test('Example 1: Target found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 0), 4);
    });

    test('Example 2: Target not found in rotated array', () {
      expect(s.search([4, 5, 6, 7, 0, 1, 2], 3), -1);
    });

    test('Example 3: Single element array, target not found', () {
      expect(s.search([1], 0), -1);
    });

    test('Single element array, target found', () {
      expect(s.search([1], 1), 0);
    });

    test('Array not rotated, target found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 4), 4);
    });

    test('Array not rotated, target not found', () {
      expect(s.search([0, 1, 2, 3, 4, 5, 6, 7], 8), -1);
    });

    test('Rotation at the beginning', () {
      expect(s.search([1, 2, 3, 4, 5, 6, 7, 0], 0), 7);
    });

    test('Rotation at the end', () {
      expect(s.search([7, 0, 1, 2, 3, 4, 5, 6], 7), 0);
    });

    test('Large array, target in the first half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 4),
          12);
    });

    test('Large array, target in the second half', () {
      expect(
          s.search([8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7], 10),
          2);
    });
    test('Duplicate at the pivot, target found', () {
      expect(s.search([3, 1, 1, 1, 1], 3), 0);
    });
    test('Duplicate at the pivot, target not found', () {
      expect(s.search([3, 1, 1, 1, 1], 2), -1);
    });
    test('Target is the only element and matches', () {
      expect(s.search([5], 5), 0);
    });

    test('Target is the only element and does not match', () {
      expect(s.search([5], 6), -1);
    });
  });
  group('Search in Rotated Sorted Array - Hardest Tests', () {
    test('Large rotated array with target at pivot', () {
      expect(
        s.search([10, 12, 15, 17, 19, 20, 25, 1, 3, 5, 7, 9], 1),
        equals(7),
      );
    });

    test('Very large rotation (almost fully rotated)', () {
      expect(
        s.search([100, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 100),
        equals(0),
      );
    });

    test('Target in second half of large rotated array', () {
      expect(
        s.search(
            [25, 26, 29, 31, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23], 7),
        equals(7),
      );
    });

    test('Large array with rotation at 3/4 point', () {
      expect(
        s.search([
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9
        ], 4),
        equals(14),
      );
    });

    test('Extremely large array with rotation', () {
      final nums =
          List.generate(1000000, (i) => i < 500000 ? i + 500000 : i - 500000);
      expect(s.search(nums, 999999), equals(499999));
    });

    test('Nearly sorted with small rotation', () {
      expect(
        s.search([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0], 0),
        equals(12),
      );
    });

    test('Rotation at 1/4 point with target at boundary', () {
      expect(
        s.search([50, 60, 70, 80, 10, 20, 30, 40], 80),
        equals(3),
      );
    });

    test('Large array with multiple possible segments', () {
      expect(
        s.search([
          100,
          200,
          300,
          400,
          500,
          600,
          700,
          800,
          900,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10
        ], 900),
        equals(8),
      );
    });

    test('Target just before rotation point', () {
      expect(
        s.search([15, 16, 17, 18, 19, 20, 21, 22, 1, 2, 3, 4, 5], 22),
        equals(7),
      );
    });

    test('Very small rotation in large array', () {
      expect(
        s.search([
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          0
        ], 0),
        equals(19),
      );
    });
  });
}
