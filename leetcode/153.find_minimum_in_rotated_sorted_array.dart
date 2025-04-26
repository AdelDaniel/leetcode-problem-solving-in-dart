// https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/
import 'package:test/test.dart';

void main() {
  runTests();
  // Solution().findMin([4, 5, 1, 2, 3]);
}

class Solution {
  int findMin(List<int> nums) {
    int left = 0;
    int right = nums.length - 1;
    int middle = left + (right - left) ~/ 2;

    do {
      /// if the most right side is less than the middle
      /// then the minimum is on the right side
      /// else
      /// - the right is sorted
      /// - the minimum number is on the left side
      if (nums[middle] > nums[right]) {
        left = middle + 1;
      } else {
        right = middle;
      }

      middle = left + (right - left) ~/ 2;
    } while (left < right);
    return nums[middle];
  }
}

void runTests() {
  final Solution s = Solution();

  group('Find Minimum in Rotated Sorted Array', () {
    // Easiest Test Cases (Basic scenarios)
    test('Already sorted array (no rotation)', () {
      expect(s.findMin([1, 2, 3, 4, 5]), equals(1));
    });

    test('Single rotation (minimum before end)', () {
      expect(s.findMin([6, 7, 8, 9, 0, 1]), equals(0));
    });

    test('Single rotation (minimum at end)', () {
      expect(s.findMin([2, 3, 4, 5, 1]), equals(1));
    });

    test('Rotation at middle', () {
      expect(s.findMin([4, 5, 1, 2, 3]), equals(1));
    });

    test('Fully rotated (equivalent to original)', () {
      expect(s.findMin([1, 2, 3, 4, 5]), equals(1));
    });

    test('Single element array', () {
      expect(s.findMin([5]), equals(5));
    });

    // Medium Test Cases (More complex rotations)
    test('Example 1 from problem', () {
      expect(s.findMin([3, 4, 5, 1, 2]), equals(1));
    });

    test('Example 2 from problem', () {
      expect(s.findMin([4, 5, 6, 7, 0, 1, 2]), equals(0));
    });

    test('Example 3 from problem (no rotation)', () {
      expect(s.findMin([11, 13, 15, 17]), equals(11));
    });

    test('Rotation point at first element', () {
      expect(s.findMin([5, 1, 2, 3, 4]), equals(1));
    });

    test('Large rotation (minimum at start)', () {
      expect(s.findMin([0, 1, 2, 4, 5, 6, 7]), equals(0));
    });

    // Harder Test Cases (Edge cases and larger arrays)
    test('Negative numbers', () {
      expect(s.findMin([-5, -4, -3, -2, -1]), equals(-5));
    });

    test('Negative numbers with rotation', () {
      expect(s.findMin([-2, -1, -5, -4, -3]), equals(-5));
    });

    test('Mixed positive and negative numbers', () {
      expect(s.findMin([4, -1, 0, 1, 2]), equals(-1));
    });

    test('Large array with rotation at 1/4 point', () {
      expect(
        s.findMin([10, 11, 12, 13, 1, 2, 3, 4, 5, 6, 7, 8, 9]),
        equals(1),
      );
    });

    test('Large array with rotation at 3/4 point', () {
      expect(
        s.findMin([5, 6, 7, 8, 9, 10, 11, 12, 13, 1, 2, 3, 4]),
        equals(1),
      );
    });

    // Extreme Test Cases (Maximum constraints)
    test('Minimum possible array (length 1)', () {
      expect(s.findMin([0]), equals(0));
    });

    test('Maximum rotation (length = n rotations)', () {
      expect(s.findMin([1, 2, 3, 4, 5]), equals(1));
    });

    test('Large array with minimum at end', () {
      final nums = List.generate(5000, (i) => i + 1)..insert(0, 0);
      nums.removeLast();
      expect(s.findMin(nums), equals(0));
    });

    test('Large array with minimum at start', () {
      final nums = List.generate(5000, (i) => i);
      expect(s.findMin(nums), equals(0));
    });

    test('Large array with minimum at middle', () {
      final nums =
          List.generate(2500, (i) => i + 2501) + List.generate(2500, (i) => i);
      expect(s.findMin(nums), equals(0));
    });

    // Special Edge Cases (note: problem specifies unique elements)
    test('Nearly sorted with small rotation', () {
      expect(s.findMin([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 0]), equals(0));
    });
  });
}
