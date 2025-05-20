// https://leetcode.com/problems/sort-colors/description/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro Sec');
}

class Solution {
  ////! Better Accepted From the first time TC: O(N) ----- SC: O(1)
  ////! 2 Pointers Sort
  void sortColors(List<int> nums) {
    int rightIndex = nums.length - 1;
    int leftIndex = 0;
    int midIndex = 0;
    int temp = 0;
    while (midIndex <= rightIndex) {
      if (nums[midIndex] == 0) {
        temp = nums[leftIndex];
        nums[leftIndex] = 0;
        nums[midIndex] = temp;
        leftIndex++;
        if (midIndex <= leftIndex) midIndex++;
      } else if (nums[midIndex] == 2) {
        temp = nums[rightIndex];
        nums[rightIndex] = 2;
        nums[midIndex] = temp;
        rightIndex--;
      } else {
        midIndex++;
      }
    }
  }

  ////! Accepted From the first time TC: O(2N) -- TC: O(N) SC: O(1)
  // void sortColors(List<int> nums) {
  //   int zerosCount = 0;
  //   int onesCount = 0;
  //   for (var i = 0; i < nums.length; i++) {
  //     if (nums[i] == 0) {
  //       zerosCount++;
  //     } else if (nums[i] == 1) {
  //       onesCount++;
  //     }
  //   }
  //   for (var i = 0; i < nums.length; i++) {
  //     if (zerosCount > 0) {
  //       nums[i] = 0;
  //       zerosCount--;
  //     } else if (onesCount > 0) {
  //       nums[i] = 1;
  //       onesCount--;
  //     } else {
  //       nums[i] = 2;
  //     }
  //   }
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Sort Colors', () {
    // Basic examples from problem statement
    test('Example 1: [2,0,2,1,1,0] → [0,0,1,1,2,2]', () {
      final nums = [2, 0, 2, 1, 1, 0];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 1, 1, 2, 2]));
    });

    test('Example 2: [2,0,1] → [0,1,2]', () {
      final nums = [2, 0, 1];
      s.sortColors(nums);
      expect(nums, equals([0, 1, 2]));
    });

    // Edge cases
    test('Single element array: [0] → [0]', () {
      final nums = [0];
      s.sortColors(nums);
      expect(nums, equals([0]));
    });

    test('All zeros: [0,0,0] → [0,0,0]', () {
      final nums = [0, 0, 0];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 0]));
    });

    test('All ones: [1,1,1] → [1,1,1]', () {
      final nums = [1, 1, 1];
      s.sortColors(nums);
      expect(nums, equals([1, 1, 1]));
    });

    test('All twos: [2,2,2] → [2,2,2]', () {
      final nums = [2, 2, 2];
      s.sortColors(nums);
      expect(nums, equals([2, 2, 2]));
    });

    // Already sorted
    test('Already sorted: [0,1,2] → [0,1,2]', () {
      final nums = [0, 1, 2];
      s.sortColors(nums);
      expect(nums, equals([0, 1, 2]));
    });

    // Reverse sorted
    test('Reverse sorted: [2,1,0] → [0,1,2]', () {
      final nums = [2, 1, 0];
      s.sortColors(nums);
      expect(nums, equals([0, 1, 2]));
    });

    // Mixed cases
    test('Mixed case 1: [1,0,2,1,0] → [0,0,1,1,2]', () {
      final nums = [1, 0, 2, 1, 0];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 1, 1, 2]));
    });

    test('Mixed case 2: [2,1,2,0,0,1] → [0,0,1,1,2,2]', () {
      final nums = [2, 1, 2, 0, 0, 1];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 1, 1, 2, 2]));
    });

    // Random cases
    test('Random case 1: [0,2,1,1,2,0] → [0,0,1,1,2,2]', () {
      final nums = [0, 2, 1, 1, 2, 0];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 1, 1, 2, 2]));
    });

    test('Random case 2: [1,2,0,1,2,0,1] → [0,0,1,1,1,2,2]', () {
      final nums = [1, 2, 0, 1, 2, 0, 1];
      s.sortColors(nums);
      expect(nums, equals([0, 0, 1, 1, 1, 2, 2]));
    });
  });
}
