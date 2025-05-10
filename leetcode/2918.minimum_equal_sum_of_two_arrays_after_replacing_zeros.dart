// https://leetcode.com/problems/minimum-equal-sum-of-two-arrays-after-replacing-zeros/description/?envType=daily-question&envId=2025-05-10

void main(List<String> args) {
  print(Solution().minSum([3, 2, 0, 1, 0], [6, 5, 0]));
  print(Solution().minSum([2, 0, 2, 0], [1, 4]));
}

class Solution {
  ////! Solved from the first Submission
  int minSum(List<int> nums1, List<int> nums2) {
    int nums1Total = 0;
    int nums2Total = 0;
    int nums1Zeros = 0;
    int nums2Zeros = 0;
    for (var i = 0; i < nums1.length; i++) {
      if (nums1[i] == 0) {
        nums1Zeros++;
      } else {
        nums1Total += nums1[i];
      }
    }

    for (var i = 0; i < nums2.length; i++) {
      if (nums2[i] == 0) {
        nums2Zeros++;
      } else {
        nums2Total += nums2[i];
      }
    }

    int total1 = nums1Zeros * 1 + nums1Total;
    int total2 = nums2Zeros * 1 + nums2Total;

    if (nums1Zeros == 0 &&
        nums2Zeros == 0 &&
        nums1Total > 0 &&
        nums2Total > 0 &&
        nums1Total != nums2Total) {
      return -1;
    } else if (nums1Zeros == 0 && nums1Total < total2 ||
        nums2Zeros == 0 && nums2Total < total1) {
      return -1;
    }

    return total1 > total2 ? total1 : total2;
  }
}
