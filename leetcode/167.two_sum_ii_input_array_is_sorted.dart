// https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/description/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! Binary Search
  ////! The more hard solution with Binary Search TC: O(n*log(n))
  ////! Accepted And Faster
  List<int> twoSum(List<int> numbers, int target) {
    for (int i = 0; i < numbers.length - 1; i++) {
      final int otherNumber = target - numbers[i];
      int leftIndex = i + 1;
      int rightIndex = numbers.length - 1;

      while (leftIndex <= rightIndex) {
        int mid = leftIndex + (rightIndex - leftIndex) ~/ 2;
        if (numbers[mid] == otherNumber) {
          return [i + 1, mid + 1];
        } else if (numbers[mid] > otherNumber) {
          rightIndex = mid - 1;
        } else {
          leftIndex = mid + 1;
        }
      }
    }

    return [];
  }

  ////! Burte Force
  ////! The easy solution --> TC: O(n^2)
  ////! Accepted But Slow
  // List<int> twoSum(List<int> numbers, int target) {
  //   for (int i = 0; i < numbers.length; i++) {
  //     for (var j = i + 1; j < numbers.length; j++) {
  //       if (numbers[i] + numbers[j] == target) {
  //         return [i + 1, j + 1];
  //       } else if (numbers[i] + numbers[j] > target) {
  //         break;
  //       }
  //     }
  //   }

  //   return [];
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Two Sum II - Input Array Is Sorted', () {
    // Basic examples from problem statement
    test('Example 1: [2,7,11,15], target=9 → [1,2]', () {
      expect(s.twoSum([2, 7, 11, 15], 9), equals([1, 2]));
    });

    test('Example 2: [2,3,4], target=6 → [1,3]', () {
      expect(s.twoSum([2, 3, 4], 6), equals([1, 3]));
    });

    test('Example 3: [-1,0], target=-1 → [1,2]', () {
      expect(s.twoSum([-1, 0], -1), equals([1, 2]));
    });

    // Edge cases
    test('Minimum length array: [1,2], target=3 → [1,2]', () {
      expect(s.twoSum([1, 2], 3), equals([1, 2]));
    });

    test('Negative numbers: [-5,-3,-1], target=-8 → [1,2]', () {
      expect(s.twoSum([-5, -3, -1], -8), equals([1, 2]));
    });

    test('Zero sum: [-2,0,1,2], target=0 → [1,4]', () {
      expect(s.twoSum([-2, 0, 1, 2], 0), equals([1, 4]));
    });

    // Duplicate numbers
    test('Duplicate numbers: [1,1,2,3], target=2 → [1,2]', () {
      expect(s.twoSum([1, 1, 2, 3], 2), equals([1, 2]));
    });

    test('Duplicate numbers at solution: [1,2,2,4], target=4 → [2,3]', () {
      expect(s.twoSum([1, 2, 2, 4], 4), equals([2, 3]));
    });

    // Large numbers
    test('Large numbers: [1000,1000], target=2000 → [1,2]', () {
      expect(s.twoSum([1000, 1000], 2000), equals([1, 2]));
    });

    // Large array
    test('Large array', () {
      final nums = List.generate(30000, (i) => i + 1);
      final target = 59999; // 30000 + 29999
      expect(s.twoSum(nums, target), equals([29999, 30000]));
    });

    // First and last elements
    test('First and last elements: [1,2,3,4,5], target=6 → [1,5]', () {
      expect(s.twoSum([1, 2, 3, 4, 5], 6), equals([1, 5]));
    });

    // Consecutive elements
    test('Consecutive elements: [1,2,3,4], target=7 → [3,4]', () {
      expect(s.twoSum([1, 2, 3, 4], 7), equals([3, 4]));
    });

    test('Minimum target: [-1000,0,1000], target=-1000 → [1,2]', () {
      expect(s.twoSum([-1000, 0, 1000], -1000), equals([1, 2]));
    });

    test('Maximum target: [-1000,0,1000], target=1000 → [2,3]', () {
      expect(s.twoSum([-1000, 0, 1000], 1000), equals([2, 3]));
    });

    // Random cases
    test('Random case 2: [2,4,6,8,10], target=10 → [1,4]', () {
      expect(s.twoSum([2, 4, 6, 8, 10], 10), equals([1, 4]));
    });

    /// Leet code
    test('Leet code: [0,0,3,4], target=0 → [1,2]', () {
      expect(s.twoSum([0, 0, 3, 4], 0), equals([1, 2]));
    });
  });
}
