// leetcode/215.kth_largest_element_in_an_array.dart
// https://leetcode.com/problems/kth-largest-element-in-an-array/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.findKthLargest([3, 2, 1, 5, 6, 4], 2);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Solved with Merge Sort
  /// Divide and conquer
  int findKthLargest(List<int> nums, int k) {
    mergeSort(nums, 0, nums.length - 1);
    return nums[nums.length - k];
  }

  void mergeSort(List<int> nums, int left, int right) {
    if (left < right) {
      final mid = left + (right - left) ~/ 2;
      mergeSort(nums, left, mid);
      mergeSort(nums, mid + 1, right);
      sortList(nums, left, mid, right);
    }
  }

  void sortList(List<int> nums, int left, int mid, int right) {
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

  /// ! Dangerous --> Stack over flow
  /// Solved with Quick Sort
  /// Divide and conquer
  /// TC: O(n)
  /// SC: O(Log(n))
  // int findKthLargest(List<int> nums, int k) {
  //   return quickSort(nums, 0, nums.length - 1, nums.length - k);
  // }

  // int quickSort(List<int> nums, int low, int high, int k) {
  //   final int pivotIndex = _partition(nums, low, high);
  //   if (pivotIndex == k) return nums[pivotIndex];
  //   if (k > pivotIndex) {
  //     return quickSort(nums, pivotIndex + 1, high, k);
  //   } else {
  //     return quickSort(nums, low, pivotIndex - 1, k);
  //   }
  // }

  // int _partition(List<int> nums, int low, int high) {
  //   int i = low - 1;
  //   int pivotIndex = high;
  //   int pivot = nums[pivotIndex];

  //   for (var j = low; j <= high; j++) {
  //     if (nums[j] <= pivot) {
  //       i++;
  //       final temp = nums[i];
  //       nums[i] = nums[j];
  //       nums[j] = temp;
  //     }
  //   }
  //   return i;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Kth Largest Element in an Array', () {
    // Basic examples from problem statement
    test('Example 1: [3,2,1,5,6,4], k=2 → 5', () {
      expect(s.findKthLargest([3, 2, 1, 5, 6, 4], 2), equals(5));
    });

    test('Example 2: [3,2,3,1,2,4,5,5,6], k=4 → 4', () {
      expect(s.findKthLargest([3, 2, 3, 1, 2, 4, 5, 5, 6], 4), equals(4));
    });

    // Edge Cases - k boundaries
    test('k is 1 (largest element): [1,2,3] → 3', () {
      expect(s.findKthLargest([1, 2, 3], 1), equals(3));
    });

    test('k is nums.length (smallest element): [1,2,3] → 1', () {
      expect(s.findKthLargest([1, 2, 3], 3), equals(1));
    });

    // Single element
    test('Single element array: [10], k=1 → 10', () {
      expect(s.findKthLargest([10], 1), equals(10));
    });

    // All elements are the same
    test('All elements same: [5,5,5,5], k=2 → 5', () {
      expect(s.findKthLargest([5, 5, 5, 5], 2), equals(5));
    });

    // Negative values
    test('Negative values: [-1,-2,-3,-4], k=2 → -2', () {
      expect(s.findKthLargest([-1, -2, -3, -4], 2), equals(-2));
    });

    test('Mixed values: [-1, 2, 0], k=1 → 2', () {
      expect(s.findKthLargest([-1, 2, 0], 1), equals(2));
    });

    // Large data (stress test for O(n) / O(n log k))
    test('Large array: 1 to 10000, k=100 → 9901', () {
      final nums = List.generate(10000, (i) => i + 1);
      // kth largest of 1..10000 where k=100 is 9901
      expect(s.findKthLargest(nums, 100), equals(9901));
    });

    // Descending and Ascending
    test('Already sorted descending: [6,5,4,3,2,1], k=3 → 4', () {
      expect(s.findKthLargest([6, 5, 4, 3, 2, 1], 3), equals(4));
    });

    test('Already sorted ascending: [1,2,3,4,5,6], k=3 → 4', () {
      expect(s.findKthLargest([1, 2, 3, 4, 5, 6], 3), equals(4));
    });
  });
}
