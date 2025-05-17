// https://leetcode.com/problems/is-subsequence/description/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {

  ////! Done from first time TC: O(n)  
  bool isSubsequence(String s, String t) {
    if (s.isEmpty) return true;
    if (s.isEmpty) return false;

    int sIndex = 0;
    for (var i = 0; i < t.length; i++) {
      if (s[sIndex] == t[i]) {
        sIndex++;
        if (sIndex >= s.length) return true;
      }
    }

    return false;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Is Subsequence', () {
    // Basic examples from problem statement
    test('Example 1: s="abc", t="ahbgdc" → true', () {
      expect(s.isSubsequence("abc", "ahbgdc"), isTrue);
    });

    test('Example 2: s="axc", t="ahbgdc" → false', () {
      expect(s.isSubsequence("axc", "ahbgdc"), isFalse);
    });

    // Edge cases
    test('Empty s: s="", t="ahbgdc" → true', () {
      expect(s.isSubsequence("", "ahbgdc"), isTrue);
    });

    test('Empty t: s="abc", t="" → false', () {
      expect(s.isSubsequence("abc", ""), isFalse);
    });

    test('Both empty: s="", t="" → true', () {
      expect(s.isSubsequence("", ""), isTrue);
    });

    // Single character cases
    test('Single char match: s="a", t="abc" → true', () {
      expect(s.isSubsequence("a", "abc"), isTrue);
    });

    test('Single char no match: s="d", t="abc" → false', () {
      expect(s.isSubsequence("d", "abc"), isFalse);
    });

    // Exact match
    test('Exact match: s="abc", t="abc" → true', () {
      expect(s.isSubsequence("abc", "abc"), isTrue);
    });

    // Non-consecutive matches
    test('Non-consecutive match: s="ace", t="abcde" → true', () {
      expect(s.isSubsequence("ace", "abcde"), isTrue);
    });

    test('Non-consecutive no match: s="aec", t="abcde" → false', () {
      expect(s.isSubsequence("aec", "abcde"), isFalse);
    });

    // Repeated characters
    test('Repeated chars match: s="aabb", t="aaabbb" → true', () {
      expect(s.isSubsequence("aabb", "aaabbb"), isTrue);
    });

    test('Repeated chars no match: s="aabb", t="ababab" → false', () {
      expect(s.isSubsequence("aabb", "ababab"), isTrue);
    });

    // Large strings
    test('Large t string with match', () {
      final t = '${List.generate(10000, (i) => 'a').join()}b';
      expect(s.isSubsequence("ab", t), isTrue);
    });

    test('Large t string without match', () {
      final t = List.generate(10000, (i) => 'a').join();
      expect(s.isSubsequence("b", t), isFalse);
    });

    // s longer than t
    test('s longer than t: s="abcd", t="abc" → false', () {
      expect(s.isSubsequence("abcd", "abc"), isFalse);
    });

    // Maximum constraints
    test('Maximum length t with early match', () {
      final t = 'z${List.generate(9999, (i) => 'a').join()}';
      expect(s.isSubsequence("za", t), isTrue);
    });

    // Special cases
    test('All same characters: s="aaa", t="aaab" → true', () {
      expect(s.isSubsequence("aaa", "aaab"), isTrue);
    });

    test('All same characters no match: s="aaaa", t="aaa" → false', () {
      expect(s.isSubsequence("aaaa", "aaa"), isFalse);
    });

    // Random cases
    test('Random case 1: s="hello", t="hheelllloo" → true', () {
      expect(s.isSubsequence("hello", "hheelllloo"), isTrue);
    });

    test('Random case 2: s="world", t="wrrroldd" → false', () {
      expect(s.isSubsequence("world", "wrrroldd"), isFalse);
    });
  });
}
