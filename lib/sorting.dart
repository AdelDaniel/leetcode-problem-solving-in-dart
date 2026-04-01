// sorting.dart
import 'dart:developer';

import 'package:test/test.dart';

void main() {
  final List<int> nums = [100, 33, 52, 12, 55, 66, 44];
  final Sorting sorting = Sorting();

  // sorting.selectionSort(nums);
  // sorting.bubbleSort(nums);
  // sorting.mergeSort(nums);
  sorting.quickSort(nums);
  log(nums.toString());

  runTests();
}

class Sorting {
  const Sorting();
  List<int> sortArray(List<int> nums) {
    quickSort(nums);
    return nums;
  }

  /// MARK: Selection Sort
  /// Selection Sort: is a comparison-based sorting algorithm.
  /// TS: O(n^2)
  /// It sorts by repeatedly selecting the smallest (or largest) element from the unsorted portion and swapping it with the first unsorted element.
  /// Find the smallest element and swap it with the first element.
  /// This way we get the smallest element at its correct position.
  /// Then find the smallest among remaining elements (or second smallest) and swap it with the second element.
  /// We keep doing this until we get all elements moved to correct position.
  void selectionSort(List<int> nums) {
    for (int i = 0; i < nums.length - 1; i++) {
      // Assume the current position holds
      // the minimum element
      int mixIndex = i;

      // Iterate through the unsorted portion >> to find the actual minimum
      for (int j = i + 1; j < nums.length; j++) {
        // Update mixIndex if a smaller element is found
        if (nums[mixIndex] > nums[j]) mixIndex = j;
      }

      // Move minimum element to its correct position
      int temp = nums[i];
      nums[i] = nums[mixIndex];
      nums[mixIndex] = temp;
    }
  }

  /// MARK: Bubble Sort
  /// Bubble Sort: is the simplest sorting algorithm that works by repeatedly swapping
  /// TS: O(n^2)
  /// the adjacent elements if they are in the wrong order.
  /// This algorithm is not efficient for large data sets as its average and worst-case time complexity are quite high.
  /// Sorts the array using multiple passes.
  /// After the first pass, the maximum goes to end (its correct position).
  /// Same way, after second pass, the second largest goes to second last position and so on.
  /// In every pass, process only those that have already not moved to correct position.
  /// After k passes, the largest k must have been moved to the last k positions.
  /// In a pass, we consider remaining elements and compare all adjacent and swap if larger element is before a smaller element.
  /// If we keep doing this, we get the largest (among the remaining elements) at its correct position.
  void bubbleSort(List<int> nums) {
    for (int i = nums.length - 1; i > 0; i--) {
      for (int j = 0; j < i; j++) {
        if (nums[j] > nums[j + 1]) {
          int temp = nums[j];
          nums[j] = nums[j + 1];
          nums[j + 1] = temp;
        }
      }
    }
  }

  /// MARK: Merge Sort
  /// TS: O(n log n)
  /// SC: O(n)
  /// Merge sort is a popular sorting algorithm known for its efficiency and stability.
  /// It follows the Divide and Conquer approach.
  /// It works by recursively dividing the input array into two halves,
  /// recursively sorting the two halves
  /// and finally merging them back together to obtain the sorted array.
  ///
  /// Divide: Divide the list or array recursively into two halves until it can no more be divided.
  /// Conquer: Each subarray is sorted individually using the merge sort algorithm.
  /// Merge: The sorted subarrays are merged back together in sorted order.
  /// The process continues until all elements from both subarrays have been merged.
  void mergeSort(List<int> nums) {
    divideList(nums, 0, nums.length - 1);
  }

  void divideList(List<int> nums, int left, int right) {
    if (left < right) {
      /// Get the middle index
      final midIndex = left + ((right - left) / 2).floor();

      /// Sort first and second halves
      divideList(nums, left, midIndex);
      divideList(nums, midIndex + 1, right);

      /// Merge the sorted halves
      mergeList(nums, left, midIndex, right);
    }
  }

  void mergeList(List<int> nums, int left, int mid, int right) {
    final leftList = [];
    final rightList = [];

    /// Copy data to temp Lists
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

    /// Copy remaining elements
    while (i < leftList.length) {
      nums[k++] = leftList[i++];
    }

    /// Copy remaining elements
    while (j < rightList.length) {
      nums[k++] = rightList[j++];
    }
  }

  /// MARK: Quick Sort
  /// QuickSort is a sorting algorithm based on the Divide and Conquer that picks an element as a pivot and partitions the given array around the picked pivot by placing the pivot in its correct position in the sorted array. 
  /// There are mainly three steps in the algorithm:
  /// Choose a Pivot: Select an element from the array as the pivot. The choice of pivot can vary (e.g., first element, last element, random element, or median).
  /// Partition the Array: Re arrange the array around the pivot. After partitioning, all elements smaller than the pivot will be on its left, and all elements greater than the pivot will be on its right.
  /// Recursively Call: Recursively apply the same process to the two partitioned sub-arrays.
  /// Base Case: The recursion stops when there is only one element left in the sub-array, as a single element is already sorted.

  void quickSort(List<int> nums) {
    _pivotSort(nums, 0, nums.length - 1);
  }

  void _pivotSort(List<int> nums, int low, int high) {
    if (low < high) {
      final pivot = _partition(nums, low, high);
      _pivotSort(nums, low, pivot - 1);
      _pivotSort(nums, pivot + 1, high);
    }
  }

  int _partition(List<int> nums, int low, int high) {
    int pivot = high;
    int i = low - 1;
    for (var j = low; j < high; j++) {
      if (nums[j] < nums[pivot]) {
        i++;
        final temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
      }
    }

    i++;
    final temp = nums[i];
    nums[i] = nums[pivot];
    nums[pivot] = temp;
    return i;
  }
}

void runTests() {
  final Sorting s = Sorting();

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
