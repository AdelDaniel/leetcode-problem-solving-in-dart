// https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/description/

void main() {
  final stopwatch = Stopwatch()..start();

  print(Solution().findDisappearedNumbers([4, 3, 2, 7, 8, 2, 3, 1]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // GOOD: Function Execution Time : 000 micro sec
  // BAD : Function Execution Time : 000 micro sec
}

class Solution {
  ////! TC: O(2n) O(n) :: SC(2N)
  ////! Use HashMap is better than Contain
  List<int> findDisappearedNumbers(List<int> nums) {
    final List<int> list = List.filled(nums.length + 1, 0);
    for (int i = 0; i < nums.length; i++) {
      list[nums[i]] = 1;
    }
    final List<int> result = [];
    for (int i = 1; i < list.length; i++) {
      if (list[i] == 0) {
        result.add(i);
      }
    }
    return result;
  }

  /// (Udemy) Use The same nums list but with the help on negative as a flag
  // List<int> findDisappearedNumbers(List<int> nums) {
  //   int index = 0;
  //   for (int i = 0; i < nums.length; i++) {
  //     index = nums[i].abs() - 1;
  //     if (nums[index] > 0) {
  //       nums[index] = nums[index] * -1;
  //     }
  //   }
  //   final List<int> result = [];
  //   for (int i = 0; i < nums.length; i++) {
  //     if (nums[i] > 0) {
  //       result.add(i + 1);
  //     }
  //   }
  //   return result;
  // }

  ////! My First Solution TC: O(n)
  ////! Time Limit Exceeded --> Contain is the problem
  // List<int> findDisappearedNumbers(List<int> nums) {
  //   final List<int> result = [];
  //   final count = nums.length;
  //   for (int i = 1; i <= count; i++) {
  //     if (!nums.contains(i)) {
  //       result.add(i);
  //     }
  //   }
  //   return result;
  // }
}
