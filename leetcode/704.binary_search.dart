// https://leetcode.com/problems/binary-search/
void main(List<String> args) {
  print(Solution().search(
    [1, 3, 5, 6, 7, 8, 10, 12, 16, 19, 20, 24, 29, 44, 55, 56],
    11,
  ));
}

class Solution {
  int search(List<int> nums, int target) {
    int left = 0;
    int right = nums.length - 1;

    // May cause overflow
    // int middle = (left + right) ~/ 2;
    int middle = left + (right - left) ~/ 2;

    do {
      if (nums[middle] == target) {
        return middle;
      } else if (nums[middle] > target) {
        right = middle - 1;
      } else if (nums[middle] < target) {
        left = middle + 1;
      }
      middle = left + (right - left) ~/ 2;
    } while (left <= right);
    return -1;
  }
}
