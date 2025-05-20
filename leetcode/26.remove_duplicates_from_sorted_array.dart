// https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Best Solution from the first time
  int removeDuplicates(List<int> nums) {
    if (nums.isEmpty) return 0;
    if (nums.length == 1) return 1;

    int left = 0;
    for (int right = 1; right < nums.length; right++) {
      if (nums[left] != nums[right]) {
        nums[left + 1] = nums[right];
        left++;
      }
    }

    /// added 1 becacuse of length
    return left + 1;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Remove Duplicates from Sorted Array', () {
    // Basic examples from problem statement
    test('Example 1: [1,1,2] → 2, [1,2]', () {
      final nums = [1, 1, 2];
      final k = s.removeDuplicates(nums);
      expect(k, equals(2));
      expect(nums.sublist(0, k), equals([1, 2]));
    });

    test('Example 2: [0,0,1,1,1,2,2,3,3,4] → 5, [0,1,2,3,4]', () {
      final nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4];
      final k = s.removeDuplicates(nums);
      expect(k, equals(5));
      expect(nums.sublist(0, k), equals([0, 1, 2, 3, 4]));
    });

    // Edge cases
    test('Single element array: [5] → 1, [5]', () {
      final nums = [5];
      final k = s.removeDuplicates(nums);
      expect(k, equals(1));
      expect(nums.sublist(0, k), equals([5]));
    });

    test('Empty array: [] → 0, []', () {
      final nums = <int>[];
      final k = s.removeDuplicates(nums);
      expect(k, equals(0));
      expect(nums.sublist(0, k), equals([]));
    });

    // All duplicates
    test('All duplicates: [7,7,7] → 1, [7]', () {
      final nums = [7, 7, 7];
      final k = s.removeDuplicates(nums);
      expect(k, equals(1));
      expect(nums.sublist(0, k), equals([7]));
    });

    // No duplicates
    test('No duplicates: [1,2,3] → 3, [1,2,3]', () {
      final nums = [1, 2, 3];
      final k = s.removeDuplicates(nums);
      expect(k, equals(3));
      expect(nums.sublist(0, k), equals([1, 2, 3]));
    });

    // Negative numbers
    test('Negative numbers: [-2,-2,-1,0,1] → 4, [-2,-1,0,1]', () {
      final nums = [-2, -2, -1, 0, 1];
      final k = s.removeDuplicates(nums);
      expect(k, equals(4));
      expect(nums.sublist(0, k), equals([-2, -1, 0, 1]));
    });

    // Large array
    test('Large array with duplicates', () {
      final nums = List.generate(30000, (i) => i ~/ 2); // Creates duplicates
      final expected = List.generate(15000, (i) => i);
      final k = s.removeDuplicates(nums);
      expect(k, equals(15000));
      expect(nums.sublist(0, k), equals(expected));
    });

    test('Large array without duplicates', () {
      final nums = List.generate(30000, (i) => i);
      final expected = List.generate(30000, (i) => i);
      final k = s.removeDuplicates(nums);
      expect(k, equals(30000));
      expect(nums.sublist(0, k), equals(expected));
    });

    // Mixed cases
    test('Mixed duplicates: [1,1,2,3,3,3,4,5,5] → 5, [1,2,3,4,5]', () {
      final nums = [1, 1, 2, 3, 3, 3, 4, 5, 5];
      final k = s.removeDuplicates(nums);
      expect(k, equals(5));
      expect(nums.sublist(0, k), equals([1, 2, 3, 4, 5]));
    });

    // Maximum constraints
    test('Maximum length with all unique', () {
      final nums = List.generate(30000, (i) => i);
      final k = s.removeDuplicates(nums);
      expect(k, equals(30000));
    });

    test('Maximum length with all duplicates', () {
      final nums = List.filled(30000, 5);
      final k = s.removeDuplicates(nums);
      expect(k, equals(1));
    });

    // Random cases
    test('Random case 1: [1,2,2,3,4,4,4,5] → 5, [1,2,3,4,5]', () {
      final nums = [1, 2, 2, 3, 4, 4, 4, 5];
      final k = s.removeDuplicates(nums);
      expect(k, equals(5));
      expect(nums.sublist(0, k), equals([1, 2, 3, 4, 5]));
    });

    test('Random case 2: [0,0,0,1,1,2,2,2,3] → 4, [0,1,2,3]', () {
      final nums = [0, 0, 0, 1, 1, 2, 2, 2, 3];
      final k = s.removeDuplicates(nums);
      expect(k, equals(4));
      expect(nums.sublist(0, k), equals([0, 1, 2, 3]));
    });
  });
}
