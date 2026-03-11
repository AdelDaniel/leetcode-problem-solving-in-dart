// leetcode/13.roman_to_integer.dart
// https://leetcode.com/problems/roman-to-integer/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.romanToInt("MCMXCIV");

  ///
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int romanToInt(String s) {
    int sum = 0;
    for (int i = 0; i < s.length; i++) {
      if (s[i] == 'I') {
        if (i == s.length - 1) {
          sum++;
        } else if (s[i + 1] == 'V') {
          sum += 4;
          i++;
        } else if (s[i + 1] == 'X') {
          sum += 9;
          i++;
        } else {
          sum++;
        }
      } else if (s[i] == 'V') {
        sum += 5;
      } else if (s[i] == 'X') {
        if (i == s.length - 1) {
          sum += 10;
        } else if (s[i + 1] == 'L') {
          sum += 40;
          i++;
        } else if (s[i + 1] == 'C') {
          sum += 90;
          i++;
        } else {
          sum += 10;
        }
      } else if (s[i] == 'L') {
        sum += 50;
      } else if (s[i] == 'C') {
        if (i == s.length - 1) {
          sum += 100;
        } else if (s[i + 1] == 'D') {
          sum += 400;
          i++;
        } else if (s[i + 1] == 'M') {
          sum += 900;
          i++;
        } else {
          sum += 100;
        }
      } else if (s[i] == 'D') {
        sum += 500;
      } else if (s[i] == 'M') {
        sum += 1000;
      }
    }
    return sum;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Roman to Integer', () {
    // Basic examples from problem statement
    test('Example 1: "III" → 3', () {
      expect(s.romanToInt("III"), equals(3));
    });

    test('Example 2: "LVIII" → 58', () {
      expect(s.romanToInt("LVIII"), equals(58));
    });

    test('Example 3: "MCMXCIV" → 1994', () {
      expect(s.romanToInt("MCMXCIV"), equals(1994));
    });

    // Single symbol cases
    test('Single symbol I: "I" → 1', () {
      expect(s.romanToInt("I"), equals(1));
    });

    test('Single symbol V: "V" → 5', () {
      expect(s.romanToInt("V"), equals(5));
    });

    test('Single symbol X: "X" → 10', () {
      expect(s.romanToInt("X"), equals(10));
    });

    test('Single symbol L: "L" → 50', () {
      expect(s.romanToInt("L"), equals(50));
    });

    test('Single symbol C: "C" → 100', () {
      expect(s.romanToInt("C"), equals(100));
    });

    test('Single symbol D: "D" → 500', () {
      expect(s.romanToInt("D"), equals(500));
    });

    test('Single symbol M: "M" → 1000', () {
      expect(s.romanToInt("M"), equals(1000));
    });

    // Simple additive cases (largest to smallest)
    test('Simple addition: "II" → 2', () {
      expect(s.romanToInt("II"), equals(2));
    });

    test('Simple addition: "III" → 3', () {
      expect(s.romanToInt("III"), equals(3));
    });

    test('Simple addition: "VI" → 6', () {
      expect(s.romanToInt("VI"), equals(6));
    });

    test('Simple addition: "VII" → 7', () {
      expect(s.romanToInt("VII"), equals(7));
    });

    test('Simple addition: "VIII" → 8', () {
      expect(s.romanToInt("VIII"), equals(8));
    });

    test('Simple addition: "XI" → 11', () {
      expect(s.romanToInt("XI"), equals(11));
    });

    test('Simple addition: "XV" → 15', () {
      expect(s.romanToInt("XV"), equals(15));
    });

    test('Simple addition: "XX" → 20', () {
      expect(s.romanToInt("XX"), equals(20));
    });

    test('Simple addition: "XXX" → 30', () {
      expect(s.romanToInt("XXX"), equals(30));
    });

    test('Simple addition: "LXXX" → 80', () {
      expect(s.romanToInt("LXXX"), equals(80));
    });

    test('Simple addition: "CLX" → 160', () {
      expect(s.romanToInt("CLX"), equals(160));
    });

    test('Simple addition: "MDCLXVI" → 1666', () {
      expect(s.romanToInt("MDCLXVI"), equals(1666));
    });

    // Subtraction cases (IV, IX, XL, XC, CD, CM)
    test('Subtraction IV: "IV" → 4', () {
      expect(s.romanToInt("IV"), equals(4));
    });

    test('Subtraction IX: "IX" → 9', () {
      expect(s.romanToInt("IX"), equals(9));
    });

    test('Subtraction XL: "XL" → 40', () {
      expect(s.romanToInt("XL"), equals(40));
    });

    test('Subtraction XC: "XC" → 90', () {
      expect(s.romanToInt("XC"), equals(90));
    });

    test('Subtraction CD: "CD" → 400', () {
      expect(s.romanToInt("CD"), equals(400));
    });

    test('Subtraction CM: "CM" → 900', () {
      expect(s.romanToInt("CM"), equals(900));
    });

    // Mixed with subtraction in different positions
    test('Mixed: "XIV" → 14', () {
      expect(s.romanToInt("XIV"), equals(14));
    });

    test('Mixed: "XIX" → 19', () {
      expect(s.romanToInt("XIX"), equals(19));
    });

    test('Mixed: "XXIV" → 24', () {
      expect(s.romanToInt("XXIV"), equals(24));
    });

    test('Mixed: "XXIX" → 29', () {
      expect(s.romanToInt("XXIX"), equals(29));
    });

    test('Mixed: "XLIV" → 44', () {
      expect(s.romanToInt("XLIV"), equals(44));
    });

    test('Mixed: "XLIX" → 49', () {
      expect(s.romanToInt("XLIX"), equals(49));
    });

    test('Mixed: "XLV" → 45', () {
      expect(s.romanToInt("XLV"), equals(45));
    });

    test('Mixed: "LIV" → 54', () {
      expect(s.romanToInt("LIV"), equals(54));
    });

    test('Mixed: "LXIV" → 64', () {
      expect(s.romanToInt("LXIV"), equals(64));
    });

    test('Mixed: "LXXIV" → 74', () {
      expect(s.romanToInt("LXXIV"), equals(74));
    });

    test('Mixed: "LXXXIV" → 84', () {
      expect(s.romanToInt("LXXXIV"), equals(84));
    });

    test('Mixed: "XCIV" → 94', () {
      expect(s.romanToInt("XCIV"), equals(94));
    });

    test('Mixed: "XCV" → 95', () {
      expect(s.romanToInt("XCV"), equals(95));
    });

    test('Mixed: "XCIX" → 99', () {
      expect(s.romanToInt("XCIX"), equals(99));
    });

    test('Mixed: "CIV" → 104', () {
      expect(s.romanToInt("CIV"), equals(104));
    });

    test('Mixed: "CXL" → 140', () {
      expect(s.romanToInt("CXL"), equals(140));
    });

    test('Mixed: "CXC" → 190', () {
      expect(s.romanToInt("CXC"), equals(190));
    });

    test('Mixed: "CDXLIV" → 444', () {
      expect(s.romanToInt("CDXLIV"), equals(444));
    });

    test('Mixed: "CDXCIX" → 499', () {
      expect(s.romanToInt("CDXCIX"), equals(499));
    });

    test('Mixed: "DCCC" → 800', () {
      expect(s.romanToInt("DCCC"), equals(800));
    });

    test('Mixed: "CMXCVIII" → 998', () {
      expect(s.romanToInt("CMXCVIII"), equals(998));
    });

    // Complex cases with multiple subtractions
    test('Complex: "MCMXLV" → 1945', () {
      expect(s.romanToInt("MCMXLV"), equals(1945));
    });

    test('Complex: "MCMLIV" → 1954', () {
      expect(s.romanToInt("MCMLIV"), equals(1954));
    });

    test('Complex: "MCMLXX" → 1970', () {
      expect(s.romanToInt("MCMLXX"), equals(1970));
    });

    test('Complex: "MCMXCV" → 1995', () {
      expect(s.romanToInt("MCMXCV"), equals(1995));
    });

    test('Complex: "MCMXCIX" → 1999', () {
      expect(s.romanToInt("MCMXCIX"), equals(1999));
    });

    test('Complex: "MM" → 2000', () {
      expect(s.romanToInt("MM"), equals(2000));
    });

    test('Complex: "MMD" → 2500', () {
      expect(s.romanToInt("MMD"), equals(2500));
    });

    test('Complex: "MMDCCCLXXXVIII" → 2888', () {
      expect(s.romanToInt("MMDCCCLXXXVIII"), equals(2888));
    });

    test('Complex: "MMCM" → 2900', () {
      expect(s.romanToInt("MMCM"), equals(2900));
    });

    test('Complex: "MMCMXCIX" → 2999', () {
      expect(s.romanToInt("MMCMXCIX"), equals(2999));
    });

    test('Complex: "MMM" → 3000', () {
      expect(s.romanToInt("MMM"), equals(3000));
    });

    test('Complex: "MMMCMXCIX" → 3999', () {
      expect(s.romanToInt("MMMCMXCIX"), equals(3999));
    });

    // Edge cases - maximum and minimum
    test('Minimum valid (1): "I" → 1', () {
      expect(s.romanToInt("I"), equals(1));
    });

    test('Maximum valid (3999): "MMMCMXCIX" → 3999', () {
      expect(s.romanToInt("MMMCMXCIX"), equals(3999));
    });

    // Cases with repeated subtraction patterns
    test(
        'Repeated pattern: "IXIX" is invalid (but if valid, what would it be?)',
        () {
      // Note: "IXIX" is not a valid Roman numeral, but if we're just testing
      // the algorithm's behavior, it might be handled by the left-to-right logic
      // Valid Roman numerals don't repeat subtraction pairs
    });

    // Random cases
    test('Random case 1: "DLXXI" → 571', () {
      expect(s.romanToInt("DLXXI"), equals(571));
    });

    test('Random case 2: "CCCXXXIII" → 333', () {
      expect(s.romanToInt("CCCXXXIII"), equals(333));
    });

    test('Random case 3: "DCLXVI" → 666', () {
      expect(s.romanToInt("DCLXVI"), equals(666));
    });

    test('Random case 4: "DCCLXXVII" → 777', () {
      expect(s.romanToInt("DCCLXXVII"), equals(777));
    });

    test('Random case 5: "DCCCLXXXVIII" → 888', () {
      expect(s.romanToInt("DCCCLXXXVIII"), equals(888));
    });

    test('Random case 6: "CMLXXXIX" → 989', () {
      expect(s.romanToInt("CMLXXXIX"), equals(989));
    });

    test('Random case 7: "MCDXLIV" → 1444', () {
      expect(s.romanToInt("MCDXLIV"), equals(1444));
    });

    test('Random case 8: "MDCLXVI" → 1666', () {
      expect(s.romanToInt("MDCLXVI"), equals(1666));
    });

    test('Random case 9: "MDCCCLXXXVIII" → 1888', () {
      expect(s.romanToInt("MDCCCLXXXVIII"), equals(1888));
    });

    test('Random case 10: "MCMXLVIII" → 1948', () {
      expect(s.romanToInt("MCMXLVIII"), equals(1948));
    });

    // Test all possible subtraction patterns in one number
    test('All subtraction patterns: "CDXLIV" → 444', () {
      expect(s.romanToInt("CDXLIV"), equals(444));
    });

    // Test numbers with same symbol repeated
    test('Repeated I: "III" → 3', () {
      expect(s.romanToInt("III"), equals(3));
    });

    test('Repeated X: "XXX" → 30', () {
      expect(s.romanToInt("XXX"), equals(30));
    });

    test('Repeated C: "CCC" → 300', () {
      expect(s.romanToInt("CCC"), equals(300));
    });

    test('Repeated M: "MMM" → 3000', () {
      expect(s.romanToInt("MMM"), equals(3000));
    });

    // Test combinations that might be tricky for left-to-right parsing
    test('Tricky: "IV" vs "VI"', () {
      expect(s.romanToInt("IV"), equals(4));
      expect(s.romanToInt("VI"), equals(6));
    });

    test('Tricky: "IX" vs "XI"', () {
      expect(s.romanToInt("IX"), equals(9));
      expect(s.romanToInt("XI"), equals(11));
    });

    test('Tricky: "XL" vs "LX"', () {
      expect(s.romanToInt("XL"), equals(40));
      expect(s.romanToInt("LX"), equals(60));
    });

    test('Tricky: "XC" vs "CX"', () {
      expect(s.romanToInt("XC"), equals(90));
      expect(s.romanToInt("CX"), equals(110));
    });

    test('Tricky: "CD" vs "DC"', () {
      expect(s.romanToInt("CD"), equals(400));
      expect(s.romanToInt("DC"), equals(600));
    });

    test('Tricky: "CM" vs "MC"', () {
      expect(s.romanToInt("CM"), equals(900));
      expect(s.romanToInt("MC"), equals(1100));
    });

    // Test cases where subtraction appears in the middle
    test('Subtraction in middle: "XIV" → 14', () {
      expect(s.romanToInt("XIV"), equals(14));
    });

    test('Subtraction in middle: "XXIX" → 29', () {
      expect(s.romanToInt("XXIX"), equals(29));
    });

    test('Subtraction in middle: "CXC" → 190', () {
      expect(s.romanToInt("CXC"), equals(190));
    });

    test('Subtraction in middle: "MCM" → 1900', () {
      expect(s.romanToInt("MCM"), equals(1900));
    });

    // Test cases with multiple subtraction patterns
    test('Multiple subtraction: "MCMXC" → 1990', () {
      expect(s.romanToInt("MCMXC"), equals(1990));
    });

    test('Multiple subtraction: "MCMXCV" → 1995', () {
      expect(s.romanToInt("MCMXCV"), equals(1995));
    });

    // Test case with maximum length (15 chars)
    test(
        'Maximum length: "MMMCMXCIX" length 9, but let\'s create longer valid one',
        () {
      // The longest valid Roman numeral under 4000 is "MMMCMXCIX" (9 chars)
      // But we can test with a valid longer one by repeating subtractive pairs?
      // Actually, valid Roman numerals can't have more than 3 of the same symbol
      expect(s.romanToInt("MMMCMXCIX"), equals(3999));
    });

    // Performance test for maximum length
    test('Performance: Longest valid numeral', () {
      final start = DateTime.now().microsecondsSinceEpoch;
      s.romanToInt("MMMCMXCIX");
      final end = DateTime.now().microsecondsSinceEpoch;
      expect(end - start, lessThan(1000)); // Should be very fast (<1ms)
    });
  });
}
