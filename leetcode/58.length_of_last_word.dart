// https://leetcode.com/problems/length-of-last-word/submissions/1623821076/

class Solution {
  int lengthOfLastWord(String s) {
    return s.trim().split(' ').last.length;
  }
}
