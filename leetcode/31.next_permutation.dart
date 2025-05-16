//! Bad Question : I don't recommend to solve
// https://leetcode.com/problems/next-permutation/description/
// https://www.youtube.com/watch?v=JRgIqugFhTo

import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  Solution s = Solution();
  final nums = [2, 3, 1]; // 3,1,2

  s.nextPermutation(nums);

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  void nextPermutation(List<int> nums) {
    int pivotIndex = -1;

    /// find the pivot
    for (int i = nums.length - 2; i >= 0; i--) {
      if (nums[i] < nums[i + 1]) {
        pivotIndex = i;
        break;
      }
    }

    /// find the successorIndex
    int successorIndex = -1;
    for (int i = nums.length - 1; i > pivotIndex && pivotIndex != -1; i--) {
      if (nums[i] > nums[pivotIndex]) {
        if (successorIndex == -1) {
          successorIndex = i;
        } else if (nums[i] < nums[successorIndex]) {
          successorIndex = i;
        }
      }
    }

    /// Switch Povit and successorIndex
    int temp = 0;
    if (pivotIndex != -1) {
      temp = nums[pivotIndex];
      nums[pivotIndex] = nums[successorIndex];
      nums[successorIndex] = temp;
    }

    /// Reverse The rest
    int left = pivotIndex + 1;
    int right = nums.length - 1;
    while (left < right) {
      /// Switch
      temp = nums[left];
      nums[left] = nums[right];
      nums[right] = temp;

      /// go to the next
      left++;
      right--;
    }

    print(nums);
  }
}

void runTests() {
  final Solution s = Solution();

  group('Next Permutation', () {
    // Basic examples from problem statement
    test('Example 1: [1,2,3] → [1,3,2]', () {
      final nums = [1, 2, 3];
      s.nextPermutation(nums);
      expect(nums, equals([1, 3, 2]));
    });

    test('Example 2: [3,2,1] → [1,2,3]', () {
      final nums = [3, 2, 1];
      s.nextPermutation(nums);
      expect(nums, equals([1, 2, 3]));
    });

    test('Example 3: [1,1,5] → [1,5,1]', () {
      final nums = [1, 1, 5];
      s.nextPermutation(nums);
      expect(nums, equals([1, 5, 1]));
    });

    // Edge cases
    test('Single element array: [5] → [5]', () {
      final nums = [5];
      s.nextPermutation(nums);
      expect(nums, equals([5]));
    });

    test('Two elements ascending: [1,2] → [2,1]', () {
      final nums = [1, 2];
      s.nextPermutation(nums);
      expect(nums, equals([2, 1]));
    });

    test('Two elements descending: [2,1] → [1,2]', () {
      final nums = [2, 1];
      s.nextPermutation(nums);
      expect(nums, equals([1, 2]));
    });

    // All same elements
    test('All same elements: [0,0,0] → [0,0,0]', () {
      final nums = [0, 0, 0];
      s.nextPermutation(nums);
      expect(nums, equals([0, 0, 0]));
    });

    // Multiple permutations
    test('Next permutation 1: [1,3,2] → [2,1,3]', () {
      final nums = [1, 3, 2];
      s.nextPermutation(nums);
      expect(nums, equals([2, 1, 3]));
    });

    test('Next permutation 2: [2,1,3] → [2,3,1]', () {
      final nums = [2, 1, 3];
      s.nextPermutation(nums);
      expect(nums, equals([2, 3, 1]));
    });

    test('Next permutation 3: [2,3,1] → [3,1,2]', () {
      final nums = [2, 3, 1];
      s.nextPermutation(nums);
      expect(nums, equals([3, 1, 2]));
    });

    // Complex cases
    test('Complex case 1: [1,5,8,4,7,6,5,3,1] → [1,5,8,5,1,3,4,6,7]', () {
      final nums = [1, 5, 8, 4, 7, 6, 5, 3, 1];
      s.nextPermutation(nums);
      expect(nums, equals([1, 5, 8, 5, 1, 3, 4, 6, 7]));
    });

    test('Complex case 2: [2,4,3,2,1] → [3,1,2,2,4]', () {
      final nums = [2, 4, 3, 2, 1];
      s.nextPermutation(nums);
      expect(nums, equals([3, 1, 2, 2, 4]));
    });

    // Maximum constraints
    test('Maximum length array: 100 elements', () {
      final nums = List.generate(100, (i) => i.isEven ? 1 : 2);
      final expected = [...nums];
      // Manually calculate expected next permutation
      expected[98] = 2;
      expected[99] = 1;
      s.nextPermutation(nums);
      expect(nums, equals(expected));
    });

    test('Maximum value elements: [100,100] → [100,100]', () {
      final nums = [100, 100];
      s.nextPermutation(nums);
      expect(nums, equals([100, 100]));
    });

    // Random cases
    test('Random case 1: [4,2,0,2,3,2,0] → [4,2,0,3,0,2,2]', () {
      final nums = [4, 2, 0, 2, 3, 2, 0];
      s.nextPermutation(nums);
      expect(nums, equals([4, 2, 0, 3, 0, 2, 2]));
    });

    test('Random case 2: [5,4,7,5,3,2] → [5,5,2,3,4,7]', () {
      final nums = [5, 4, 7, 5, 3, 2];
      s.nextPermutation(nums);
      expect(nums, equals([5, 5, 2, 3, 4, 7]));
    });

    /// From Leet Code
    test('From Leet Code 1: [2,2,7,5,4,3,2,2,1] → 2,3,1,2,2,2,4,5,7]', () {
      final nums = [2, 2, 7, 5, 4, 3, 2, 2, 1];
      s.nextPermutation(nums);
      expect(nums, equals([2, 3, 1, 2, 2, 2, 4, 5, 7]));
    });

    test('From Leet Code 1: [2,3,1,3,3] → [2,3,3,1,3]', () {
      final nums = [2, 3, 1, 3, 3];
      s.nextPermutation(nums);
      expect(nums, equals([2, 3, 3, 1, 3]));
    });
  });
}
