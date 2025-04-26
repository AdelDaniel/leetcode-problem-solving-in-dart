void main(List<String> args) {
  final BinarySearch binarySearch = BinarySearch();
  print(binarySearch.search(
    [1, 3, 5, 6, 7, 8, 10, 12, 16, 19, 20, 24, 29, 44, 55, 56],
    11,
  ));

  print(binarySearch.findMin(
    [12, 16, 19, 20, 24, 29, 44, 55, 56, 1, 3, 5, 6, 7, 8, 10, 11],
  ));
}

class BinarySearch {
  /// Sorted Array
  int search(List<int> list, int n) {
    int left = 0;
    int right = list.length - 1;

    // May cause overflow
    // int middle = (left + right) ~/ 2;
    int middle = left + (right - left) ~/ 2;

    do {
      print(
        'left: $left, middle: $middle, right: $right ,list[middle]: ${list[middle]}',
      );
      if (list[middle] == n) {
        return middle;
      } else if (list[middle] > n) {
        right = middle - 1;
      } else if (list[middle] < n) {
        left = middle + 1;
      }

      middle = left + (right - left) ~/ 2;
    } while (left <= right);
    print(
      'left: $left, middle: $middle, right: $right ,list[middle]: ${list[middle]}',
    );
    return -1;
  }

  /// Rotated Sorted Array
  int findMin(List<int> nums) {
    int left = 0;
    int right = nums.length - 1;
    int middle = left + (right - left) ~/ 2;

    do {
      /// Must start from the right side (Check the right is Important)
      /// if (nums[middle] > nums[right])
      /// May both sides are sorted (Then the minimum number is on the most left side)
      ///
      /// if the most right side is less than the middle
      /// Then this part is not sorted and the minimum is on that side
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
