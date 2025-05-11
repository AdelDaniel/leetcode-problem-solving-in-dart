// Easy: https://leetcode.com/problems/three-consecutive-odds/description/?envType=daily-question&envId=2025-05-11
class Solution {
  bool threeConsecutiveOdds(List<int> arr) {
    int oddsNumber = 0;
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] % 2 == 1) {
        ++oddsNumber;
      } else {
        oddsNumber = 0;
      }

      if (oddsNumber == 3) {
        return true;
      }
    }
    return false;
  }
}
