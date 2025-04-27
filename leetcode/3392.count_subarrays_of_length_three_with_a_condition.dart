// https://leetcode.com/problems/count-subarrays-of-length-three-with-a-condition/description/?envType=daily-question&envId=2025-04-27
void main() {
  print(Solution().countSubarrays([1, 2, 1, 1, 4, 1]));
  print(Solution().countSubarrays([1, 1, 1]));
}

class Solution {
  int countSubarrays(List<int> nums) {
    int subArraysNumber = 0;
    for (int i = 0; i < nums.length - 2; i++) {
      if ((nums[i] + nums[i + 2]) * 2 == nums[i + 1]) {
        subArraysNumber++;
      }
    }
    return subArraysNumber;
  }
}
