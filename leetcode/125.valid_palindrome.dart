// https://leetcode.com/problems/valid-palindrome/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Solved
  bool isPalindrome(String s) {
    s = s.toLowerCase();
    s = s.replaceAll(RegExp(r'[^a-z0-9]'), '');
    if (s.isEmpty) return true;
    int leftIndex = 0;
    int rightIndex = s.length - 1;

    while (leftIndex < rightIndex) {
      if (s[leftIndex].toLowerCase() == s[rightIndex].toLowerCase()) {
        leftIndex++;
        rightIndex--;
      } else if (s[leftIndex] == ' ') {
        leftIndex++;
      } else if (s[rightIndex] == ' ') {
        rightIndex--;
      } else if (s[leftIndex] != s[rightIndex]) {
        return false;
      }
    }

    return true;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Valid Palindrome', () {
    // Basic examples from problem statement
    test('Example 1: "A man, a plan, a canal: Panama" → true', () {
      expect(s.isPalindrome("A man, a plan, a canal: Panama"), isTrue);
    });

    test('Example 2: "race a car" → false', () {
      expect(s.isPalindrome("race a car"), isFalse);
    });

    test('Example 3: " " → true', () {
      expect(s.isPalindrome(" "), isTrue);
    });

    // Edge cases
    test('Empty string: "" → true', () {
      expect(s.isPalindrome(""), isTrue);
    });

    test('Single character: "a" → true', () {
      expect(s.isPalindrome("a"), isTrue);
    });

    test('Single non-alphanumeric: "," → true', () {
      expect(s.isPalindrome(","), isTrue);
    });

    // Numeric palindromes
    test('Numeric palindrome: "12321" → true', () {
      expect(s.isPalindrome("12321"), isTrue);
    });

    test('Numeric non-palindrome: "12345" → false', () {
      expect(s.isPalindrome("12345"), isFalse);
    });

    // Mixed alphanumeric
    test('Mixed alphanumeric palindrome: "a1b2b1a" → true', () {
      expect(s.isPalindrome("a1b2b1a"), isTrue);
    });

    test('Mixed alphanumeric non-palindrome: "a1b2c3" → false', () {
      expect(s.isPalindrome("a1b2c3"), isFalse);
    });

    // With special characters
    test('With special characters palindrome: "No \'x\' in Nixon!" → true', () {
      expect(s.isPalindrome("No 'x' in Nixon!"), isTrue);
    });

    test('With special characters non-palindrome: "Hello, world!" → false', () {
      expect(s.isPalindrome("Hello, world!"), isFalse);
    });

    // Case sensitivity
    test('Case sensitivity: "Aa" → true', () {
      expect(s.isPalindrome("Aa"), isTrue);
    });

    test('Case sensitivity: "Ab" → false', () {
      expect(s.isPalindrome("Ab"), isFalse);
    });

    test('Large non-palindrome', () {
      final str =
          List.generate(200000, (i) => String.fromCharCode(97 + (i % 26)))
              .join();
      expect(s.isPalindrome(str), isFalse);
    });

    // Maximum constraints
    test('Maximum length palindrome', () {
      final str = List.generate(200000, (i) => 'a').join();
      expect(s.isPalindrome(str), isTrue);
    });

    test('Maximum length non-palindrome', () {
      final str =
          List.generate(200000, (i) => String.fromCharCode(97 + (i % 26)))
              .join();
      expect(s.isPalindrome(str), isFalse);
    });

    // Unicode characters (though constraints say ASCII)
    test('Unicode alphanumeric: "A man, a plan, a cânal: Panama" → false', () {
      expect(s.isPalindrome("A man, a plan, a cânal: Panama"), isFalse);
    });

    // Random cases
    test('Random case 1: "Red rum, sir, is murder" → true', () {
      expect(s.isPalindrome("Red rum, sir, is murder"), isTrue);
    });

    test('Random case 2: "Was it a car or a cat I saw?" → true', () {
      expect(s.isPalindrome("Was it a car or a cat I saw?"), isTrue);
    });

    /// Leet code
    test('Leet Code : "0P" → false', () {
      expect(s.isPalindrome("0P"), isFalse);
    });
  });
}
