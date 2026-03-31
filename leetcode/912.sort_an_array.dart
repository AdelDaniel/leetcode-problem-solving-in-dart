// leetcode/912.sort_an_array.dart
// https://leetcode.com/problems/sort-an-array/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.sortArray([5, 2, 3, 1]);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  List<int> sortArray(List<int> nums) {
    mergeSort(nums, 0, nums.length - 1);
    return nums;
  }

  void mergeSort(List<int> nums, int left, int right) {
    if (left < right) {
      final midIndex = left + ((right - left) / 2).floor();
      mergeSort(nums, left, midIndex);
      mergeSort(nums, midIndex + 1, right);
      mergeList(nums, left, midIndex, right);
    }
  }

  void mergeList(List<int> nums, int left, int mid, int right) {
    final leftList = [];
    final rightList = [];

    for (var i = left; i <= mid; i++) {
      leftList.add(nums[i]);
    }

    for (var i = mid + 1; i <= right; i++) {
      rightList.add(nums[i]);
    }

    int i = 0;
    int j = 0;
    int k = left;
    while (i < leftList.length && j < rightList.length) {
      if (leftList[i] < rightList[j]) {
        nums[k++] = leftList[i++];
      } else {
        nums[k++] = rightList[j++];
      }
    }
    while (i < leftList.length) {
      nums[k++] = leftList[i++];
    }
    while (j < rightList.length) {
      nums[k++] = rightList[j++];
    }
  }
}

void runTests() {
  final Solution s = Solution();

  group('Sort An Array', () {
    // Basic examples from problem statement
    test('Example 1: [5,2,3,1] → [1,2,3,5]', () {
      expect(s.sortArray([5, 2, 3, 1]), equals([1, 2, 3, 5]));
    });

    test('Example 2: [5,1,1,2,0,0] → [0,0,1,1,2,5]', () {
      expect(s.sortArray([5, 1, 1, 2, 0, 0]), equals([0, 0, 1, 1, 2, 5]));
    });

    // Edge Cases
    test('Single element: [1] → [1]', () {
      expect(s.sortArray([1]), equals([1]));
    });

    test('Already sorted: [1,2,3,4,5] → [1,2,3,4,5]', () {
      expect(s.sortArray([1, 2, 3, 4, 5]), equals([1, 2, 3, 4, 5]));
    });

    test('Reverse sorted: [5,4,3,2,1] → [1,2,3,4,5]', () {
      expect(s.sortArray([5, 4, 3, 2, 1]), equals([1, 2, 3, 4, 5]));
    });

    test('All elements same: [2,2,2,2] → [2,2,2,2]', () {
      expect(s.sortArray([2, 2, 2, 2]), equals([2, 2, 2, 2]));
    });

    // Negative Values
    test('Mixed positive and negative: [-5, 2, -1, 0, 3] → [-5, -1, 0, 2, 3]',
        () {
      expect(s.sortArray([-5, 2, -1, 0, 3]), equals([-5, -1, 0, 2, 3]));
    });

    test('All negative: [-10, -1, -5, -2] → [-10, -5, -2, -1]', () {
      expect(s.sortArray([-10, -1, -5, -2]), equals([-10, -5, -2, -1]));
    });

    // Larger Data and Ranges
    test(
        'Large numbers within constraints: [-50000, 50000, 0] → [-50000, 0, 50000]',
        () {
      expect(s.sortArray([-50000, 50000, 0]), equals([-50000, 0, 50000]));
    });

    test('Large random array performance check', () {
      final input = List.generate(10000, (i) => 10000 - i);
      final expected = List.generate(10000, (i) => i + 1);
      expect(s.sortArray(input), equals(expected));
    });

    // Duplicate handling
    test('Heavy duplicates: [1,2,1,2,1,2] → [1,1,1,2,2,2]', () {
      expect(s.sortArray([1, 2, 1, 2, 1, 2]), equals([1, 1, 1, 2, 2, 2]));
    });
  });
}
