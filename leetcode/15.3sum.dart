// https://leetcode.com/problems/3sum/
// Medium but Very Hard...
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  ////! Time Limit Solution --> TC: O(n^3)
  //// ! Brute Force .
  List<List<int>> threeSum(List<int> nums) {
    nums.sort();

    final Map<String, List<int>> result = {};
    for (int i = 0; i < nums.length - 2; i++) {
      if (nums[i] > 0) break;

      for (int j = i + 1; j < nums.length - 1; j++) {
        if (nums[i] + nums[j] > 0) break;

        for (int k = j + 1; k < nums.length; k++) {
          int sum = nums[i] + nums[j] + nums[k];

          if (sum == 0) {
            result.putIfAbsent(
              "${nums[i]}${nums[j]}${nums[k]}",
              () => [nums[i], nums[j], nums[k]],
            );
          } else if (sum > 0) {
            break;
          }
        }
      }
    }
    return result.values.toList();
  }

  /// Wrong Solution
  /// Will make a duplicate
  // List<List<int>> threeSum(List<int> nums) {
  //   final List<List<int>> result = [];
  //   for (int i = 0; i < nums.length - 2; i++) {
  //     for (int j = i + 1; j < nums.length - 1; j++) {
  //       for (int k = j + 1; k < nums.length; k++) {
  //         if (nums[i] + nums[j] + nums[k] == 0) {
  //           result.add([nums[i], nums[j], nums[k]]);
  //         }
  //       }
  //     }
  //   }
  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('3Sum', () {
    // Basic examples from problem statement
    test('Example 1: [-1,0,1,2,-1,-4] → [[-1,-1,2],[-1,0,1]]', () {
      final result = s.threeSum([-1, 0, 1, 2, -1, -4]);
      expect(
          result,
          containsAllInOrder([
            [-1, -1, 2],
            [-1, 0, 1]
          ]));
    });

    test('Example 2: [0,1,1] → []', () {
      expect(s.threeSum([0, 1, 1]), equals([]));
    });

    test('Example 3: [0,0,0] → [[0,0,0]]', () {
      expect(
          s.threeSum([0, 0, 0]),
          equals([
            [0, 0, 0]
          ]));
    });

    test('No solution: [1,2,3] → []', () {
      expect(s.threeSum([1, 2, 3]), equals([]));
    });

    // Multiple zeros
    test('Two zeros: [0,0,1] → []', () {
      expect(s.threeSum([0, 0, 1]), equals([]));
    });

    test('Four zeros: [0,0,0,0] → [[0,0,0]]', () {
      expect(
          s.threeSum([0, 0, 0, 0]),
          equals([
            [0, 0, 0]
          ]));
    });

    // Positive and negative numbers
    test('All positives: [1,2,3,4] → []', () {
      expect(s.threeSum([1, 2, 3, 4]), equals([]));
    });

    test('All negatives: [-1,-2,-3,-4] → []', () {
      expect(s.threeSum([-1, -2, -3, -4]), equals([]));
    });

    // Duplicate triplets
    test('Duplicate triplets: [-1,0,1,2,-1,-4] → [[-1,-1,2],[-1,0,1]]', () {
      final result = s.threeSum([-1, 0, 1, 2, -1, -4]);
      expect(result, hasLength(2));
      expect(
          result,
          containsAllInOrder([
            [-1, -1, 2],
            [-1, 0, 1]
          ]));
    });

    // Large array
    test('Large array with multiple solutions', () {
      final nums = List.generate(1000, (i) => i - 500);
      final result = s.threeSum(nums);
      // Should find all triplets where a + b + c = 0
      expect(result.length, greaterThan(0));
      for (final triplet in result) {
        expect(triplet[0] + triplet[1] + triplet[2], equals(0));
      }
    });

    // Maximum constraints
    test('Maximum length array', () {
      final nums = List.generate(3000, (i) => (i % 200) - 100);
      final result = s.threeSum(nums);
      expect(result.length, greaterThan(0));
    });

    // Random cases
    test('Random case 1: [-2,0,1,1,2] → [[-2,0,2],[-2,1,1]]', () {
      final result = s.threeSum([-2, 0, 1, 1, 2]);
      expect(
          result,
          containsAllInOrder([
            [-2, 0, 2],
            [-2, 1, 1]
          ]));
    });

    test('Random case 2: [3,0,-2,-1,1,2] → [[-2,-1,3],[-2,0,2],[-1,0,1]]', () {
      final result = s.threeSum([3, 0, -2, -1, 1, 2]);
      expect(
          result,
          containsAllInOrder([
            [-2, -1, 3],
            [-2, 0, 2],
            [-1, 0, 1]
          ]));
    });

    // Special cases
    test('All same number except one: [1,1,1,1,1,-2] → [[1,1,-2]]', () {
      expect(
          s.threeSum([1, 1, 1, 1, 1, -2]),
          equals([
            [1, 1, -2]
          ]));
    });

    test('Large range: [-100000,1,99999] → [[-100000,1,99999]]', () {
      expect(
          s.threeSum([-100000, 1, 99999]),
          equals([
            [-100000, 1, 99999]
          ]));
    });

    // Leet code New test case
    test(
        'Leet code: [-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6] → [[-4,-2,6],[-4,0,4],[-4,1,3],[-4,2,2],[-2,-2,4],[-2,0,2]]',
        () {
      final nums = [-4, -2, -2, -2, 0, 1, 2, 2, 2, 3, 3, 4, 4, 6, 6];
      final expected = [
        [-4, -2, 6],
        [-4, 0, 4],
        [-4, 1, 3],
        [-4, 2, 2],
        [-2, -2, 4],
        [-2, 0, 2]
      ];
      final result = s.threeSum(nums);

      // Verify all expected triplets are present
      for (final triplet in expected) {
        expect(result, contains(triplet));
      }

      // Verify no extra triplets are present
      expect(result.length, equals(expected.length));
    });
  });
}
