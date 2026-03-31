// leetcode/2839.check_if_strings_can_be_made_equal_i.dart.dart
// https://leetcode.com/problems/check-if-strings-can-be-made-equal-with-operations-i/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.canBeEqual("abcd", "cdab");
  // s.canBeEqual("lpsc", "cslp");

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  bool canBeEqual(String s1, String s2) {
    if (s1 == s2) return true;

    List temp = s1.split('');
    int i = 1;
    while (i >= 0) {
      temp[i] = s1[i + 2];
      temp[i + 2] = s1[i];
      if (temp.join() == s2) return true;
      i--;
    }

    temp = s1.split('');
    i = 0;
    while (i <= 1) {
      temp[i] = s1[i + 2];
      temp[i + 2] = s1[i];
      if (temp.join() == s2) return true;
      i++;
    }

    return false;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Check if Strings Can be Made Equal I', () {
    // Basic examples from problem statement
    test('Example 1: "abcd", "cdab" → true', () {
      expect(s.canBeEqual("abcd", "cdab"), isTrue);
    });

    test('Example 2: "abcd", "dacb" → false', () {
      expect(s.canBeEqual("abcd", "dacb"), isFalse);
    });

    // Case: Strings are already equal
    test('Already equal: "aaaa", "aaaa" → true', () {
      expect(s.canBeEqual("aaaa", "aaaa"), isTrue);
    });

    test('Already equal different chars: "abcd", "abcd" → true', () {
      expect(s.canBeEqual("abcd", "abcd"), isTrue);
    });

    // Case: Only even indices need swapping
    test('Swap only 0 and 2: "abcd", "cbad" → true', () {
      expect(s.canBeEqual("abcd", "cbad"), isTrue);
    });

    // Case: Only odd indices need swapping
    test('Swap only 1 and 3: "abcd", "adcb" → true', () {
      expect(s.canBeEqual("abcd", "adcb"), isTrue);
    });

    // Case: Swapping doesn't help because characters don't match sets
    test('Wrong characters in even positions: "abcd", "zbcd" → false', () {
      expect(s.canBeEqual("abcd", "zbcd"), isFalse);
    });

    test('Characters exist but in wrong parity: "abcd", "bacd" → false', () {
      // 'a' is at 0 (even) in s1, but 'a' is at 1 (odd) in s2.
      // Swapping 0-2 or 1-3 can never move 'a' to an odd index.
      expect(s.canBeEqual("abcd", "bacd"), isFalse);
    });

    // Case: Duplicate characters
    test('Duplicates within parity sets: "aabb", "abab" → false', () {
      // s1 even: {a, b}, odd: {a, b}
      // s2 even: {a, a}, odd: {b, b}
      expect(s.canBeEqual("aabb", "abab"), isFalse);
    });

    test('Duplicates that can be made equal: "abab", "baba" → true', () {
      // s1 even: {a, a}, odd: {b, b}
      // s2 even: {b, b}, odd: {a, a}
      // Wait, let's re-check:
      // s1[0]=a, s1[2]=a. s2[0]=b, s2[2]=b. Even sets don't match.
      expect(s.canBeEqual("abab", "baba"), isFalse);
    });

    test('All same characters: "zzzz", "zzzz" → true', () {
      expect(s.canBeEqual("zzzz", "zzzz"), isTrue);
    });

    test('Random: "lpsc", "cslp" → true', () {
      expect(s.canBeEqual("lpsc", "cslp"), isFalse);
    });
  });
}
