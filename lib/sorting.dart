// sorting.dart
import 'dart:developer';

void main() {
  final List<int> nums = [100, 33, 52, 12, 55, 66, 44];
  final Sorting sorting = Sorting();

  // sorting.selectionSort(nums);
  sorting.bubbleSort(nums);
  log(nums.toString());
}

class Sorting {
  const Sorting();

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

  /// Merge Sort
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
}
