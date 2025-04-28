// https://leetcode.com/problems/palindrome-number/description/
import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  /// TC: O(log) -- SC: O(1)
  /// This converted to a String
  /// ? This Solution is Faster
  bool isPalindrome(int x) {
    int number = x;

    /// Negative numbers can't be palindrome -121 != 121-
    if (number < 0) {
      return false;

      /// Number ends wight zero can't be palindrome -121 != 121-
    } else if (number != 0 && number % 10 == 0) {
      return false;
    } else {
      int reverseNumber = 0;
      int lastDigit = 0;

      /// Move the most left digit in the original Number
      /// To the most right in the reverse Number
      while (x > reverseNumber) {
        lastDigit = number % 10;
        number ~/= 10;
        reverseNumber = reverseNumber * 10 + lastDigit;
      }

      return reverseNumber == x;
    }
  }

  //! TC: O(n) -- SC: O(1)
  //! This converted to a String
  // bool isPalindrome(int x) {
  //   final String string = x.toString();

  //   /// Negative numbers can't be palindrome -121 != 121-
  //   if (string.startsWith('-')) {
  //     return false;
  //   } else {
  //     final int stringLength = string.length;
  //     final int iterateLength = stringLength ~/ 2;
  //     for (int i = 0; i < iterateLength; i++) {
  //       if (string[i] != string[stringLength - i - 1]) {
  //         return false;
  //       }
  //     }
  //     return true;
  //   }
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Palindrome Number', () {
    // Basic positive palindromes
    test('Single digit (always palindrome)', () {
      expect(s.isPalindrome(0), isTrue);
      expect(s.isPalindrome(1), isTrue);
      expect(s.isPalindrome(9), isTrue);
    });

    test('Example 1: 121', () {
      expect(s.isPalindrome(121), isTrue);
    });

    test('Even length palindrome: 1221', () {
      expect(s.isPalindrome(1221), isTrue);
    });

    test('Odd length palindrome: 12321', () {
      expect(s.isPalindrome(12321), isTrue);
    });

    // Negative numbers
    test('Example 2: -121', () {
      expect(s.isPalindrome(-121), isFalse);
    });

    test('Negative single digit: -5', () {
      expect(s.isPalindrome(-5), isFalse);
    });

    // Non-palindrome numbers
    test('Example 3: 10', () {
      expect(s.isPalindrome(10), isFalse);
    });

    test('Even length non-palindrome: 1234', () {
      expect(s.isPalindrome(1234), isFalse);
    });

    test('Odd length non-palindrome: 12345', () {
      expect(s.isPalindrome(12345), isFalse);
    });

    // Edge cases with trailing zeros
    test('Number ending with 0: 120', () {
      expect(s.isPalindrome(120), isFalse);
    });

    test('Number ending with multiple 0s: 1001001', () {
      expect(s.isPalindrome(1001001), isTrue);
    });

    // Large numbers
    test('Large palindrome: 1234554321', () {
      expect(s.isPalindrome(1234554321), isTrue);
    });

    test('Large non-palindrome: 1234567890', () {
      expect(s.isPalindrome(1234567890), isFalse);
    });

    // Boundary cases
    test('Maximum 32-bit integer (not palindrome)', () {
      expect(s.isPalindrome(2147483647), isFalse);
    });

    test('Minimum 32-bit integer (not palindrome)', () {
      expect(s.isPalindrome(-2147483648), isFalse);
    });

    test('Palindrome near maximum: 2147447412', () {
      expect(s.isPalindrome(2147447412), isTrue);
    });

    // Special cases
    test('All digits same: 9999999', () {
      expect(s.isPalindrome(9999999), isTrue);
    });

    test('Palindrome with middle 0: 12021', () {
      expect(s.isPalindrome(12021), isTrue);
    });

    test('Non-palindrome with middle 0: 120210', () {
      expect(s.isPalindrome(120210), isFalse);
    });

    // Random test cases
    test('Random 6-digit palindrome', () {
      expect(s.isPalindrome(123321), isTrue);
    });

    test('Random 7-digit non-palindrome', () {
      expect(s.isPalindrome(1234567), isFalse);
    });
  });
}
