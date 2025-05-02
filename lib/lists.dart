class Lists {
  void rotate(List<int> nums, int k) {
    if (nums.length <= 1 || k == 0) return;
    k = k % nums.length;
    List<int> range = nums.getRange(0, nums.length - k).toList();
    nums
      ..removeRange(0, nums.length - k)
      ..addAll(range);
  }

  ////! Best Solution than normal rotate
  /// TC: O(3n) == O(n) --- SC: O(1)
  void rotateByReversing(List<int> nums, int k) {
    if (nums.isEmpty || k == 0) return;

    final n = nums.length;
    k %= n;

    /// Reverse All The Array [1,2,3,4] --> [4,3,2,1]
    reverse(nums, 0, n - 1);

    /// Reverse First K Elements
    /// K = 2 --> from 0-2 --> [4,3,2,1] --> [3,4,2,1]
    reverse(nums, 0, k - 1);

    /// Reverse Remaining Elements
    /// K = 2 --> from 2-3 -->[3,4,2,1] --> [3,4,1,2]
    reverse(nums, k, n - 1);
  }

  /// How to reverse an array
  void reverse(List<int> nums, int start, int end) {
    while (start < end) {
      final temp = nums[start];
      nums[start] = nums[end];
      nums[end] = temp;
      start++;
      end--;
    }
  }
}
