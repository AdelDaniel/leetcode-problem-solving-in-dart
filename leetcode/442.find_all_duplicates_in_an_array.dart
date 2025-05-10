// https://leetcode.com/problems/find-all-duplicates-in-an-array/

void main() {
  final stopwatch = Stopwatch()..start();

  print(Solution().findDuplicates([4, 3, 2, 7, 8, 2, 3, 1]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! TC: O(2n) O(n) :: SC(2N)
  ////! First Time solution
  ////! Use HashMap is better than Contain
  // List<int> findDuplicates(List<int> nums) {
  //   final List<int> list = List.filled(nums.length + 1, 0);
  //   for (int i = 0; i < nums.length; i++) {
  //     int index = nums[i];
  //     list[index] = list[index] + 1;
  //   }
  //   final List<int> result = [];
  //   for (int i = 1; i < list.length; i++) {
  //     if (list[i] == 2) {
  //       result.add(i);
  //     }
  //   }
  //   return result;
  // }

  /// This solution is better only available
  /// Udemy
  /// Hash Table Solution
  List<int> findDuplicates(List<int> nums) {
    final List<int> result = [];
    int index = 0;
    for (int i = 0; i < nums.length; i++) {
      index = nums[i].abs() - 1;
      if (nums[index] < 0) {
        result.add(index + 1);
      } else {
        nums[index] = nums[index] * -1;
      }
    }
    return result;
  }
}
