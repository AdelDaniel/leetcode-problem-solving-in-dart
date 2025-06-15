// https://leetcode.com/problems/decode-string/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.decodeString("1[1[1[1[1[a]]]]]");

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // Function Execution Time : 365384 micro s
  // Function Execution Time : 394717 micro s
}

class Solution {
  ////! Accepted from the first time
  ////! Try to find another solution
  String decodeString(String s) {
    final StringBuffer sbResult = StringBuffer();
    String subString = "";
    final List<String> stack = [];
    for (var i = 0; i < s.length; i++) {
      final char = s[i];
      if (char == ']') {
        String lastChar = stack.removeLast();

        /// Get the substring needed to be repeated
        /// Add all the chars in the [] in the substring to repeat
        while (lastChar != '[') {
          subString = lastChar + subString;
          lastChar = stack.removeLast();
        }
        lastChar = stack.last;
        int number = 0;
        int tens = 1;

        /// Get the repeat number
        while (lastChar.startsWith(RegExp(r'[0-9]'))) {
          stack.removeLast();
          number += int.parse(lastChar) * tens;
          tens *= 10;
          if (stack.isNotEmpty) {
            lastChar = stack.last;
          } else {
            break;
          }
        }

        /// Check if the stack is empty:
        /// Then I will add the substring to the result
        /// Else Then I need to repeat this again and add this to the stack
        if (stack.isNotEmpty) {
          stack.add(subString * number);
        } else {
          sbResult.write(subString * number);
        }
        subString = "";
        number = 0;
        tens = 1;
      } else if (char == '[') {
        stack.add(char);
      } else if (char.startsWith(RegExp(r'[0-9]'))) {
        stack.add(char);
      } else {
        /// If the string not in the [] then add it to the string result without repeat
        if (stack.isEmpty) {
          sbResult.write(char);
        } else {
          stack.add(char);
        }
      }
    }

    return sbResult.toString();
  }
}

void runTests() {
  final Solution s = Solution();

  group('Decode String', () {
    // Basic examples from problem statement
    test('Example 1: "3[a]2[bc]" → "aaabcbc"', () {
      expect(s.decodeString("3[a]2[bc]"), equals("aaabcbc"));
    });

    test('Example 2: "3[a2[c]]" → "accaccacc"', () {
      expect(s.decodeString("3[a2[c]]"), equals("accaccacc"));
    });

    test('Example 3: "2[abc]3[cd]ef" → "abcabccdcdcdef"', () {
      expect(s.decodeString("2[abc]3[cd]ef"), equals("abcabccdcdcdef"));
    });

    // Edge cases
    test('Single character: "a" → "a"', () {
      expect(s.decodeString("a"), equals("a"));
    });

    test('Single repetition: "1[a]" → "a"', () {
      expect(s.decodeString("1[a]"), equals("a"));
    });

    test('Multiple digits for k: "10[a]" → "aaaaaaaaaa"', () {
      expect(s.decodeString("10[a]"), equals("aaaaaaaaaa"));
    });

    // Nested cases
    test('Double nesting: "2[3[a]b]" → "aaabaaab"', () {
      expect(s.decodeString("2[3[a]b]"), equals("aaabaaab"));
    });

    test('Triple nesting: "2[a3[b2[c]]]" → "abccbccbccabccbccbcc"', () {
      expect(s.decodeString("2[a3[b2[c]]]"), equals("abccbccbccabccbccbcc"));
    });

    // Multiple segments
    test('Multiple segments: "2[a]3[b]4[c]" → "aabbbcccc"', () {
      expect(s.decodeString("2[a]3[b]4[c]"), equals("aabbbcccc"));
    });

    test('Mixed segments: "a2[b3[c]d]e" → "abcccdbcccde"', () {
      expect(s.decodeString("a2[b3[c]d]e"), equals("abcccdbcccde"));
    });

    // Maximum constraints
    test('Maximum k value: "300[a]" → 300 a\'s', () {
      expect(s.decodeString("300[a]"), equals("a" * 300));
    });

    test('Maximum nesting depth', () {
      expect(s.decodeString("1[1[1[1[1[a]]]]]"), equals("a"));
    });

    // No encoding cases
    test('No encoding: "abc" → "abc"', () {
      expect(s.decodeString("abc"), equals("abc"));
    });

    test('Empty brackets: "3[]" → ""', () {
      expect(s.decodeString("3[]"), equals(""));
    });

    // Complex cases
    test('Complex case 1: "3[z]2[2[y]pq4[2[jk]e1[f]]]ef"', () {
      expect(
          s.decodeString("3[z]2[2[y]pq4[2[jk]e1[f]]]ef"),
          equals(
              "zzzyypqjkjkefjkjkefjkjkefjkjkefyypqjkjkefjkjkefjkjkefjkjkefef"));
    });

    test('Complex case 2: "2[2[y]a3[b2[c]d]]"', () {
      expect(s.decodeString("2[2[y]a3[b2[c]d]]"),
          equals("yyabccdbccdbccdyyabccdbccdbccd"));
    });

    // Random cases
    test('Random case 1: "2[a3[b]]" → "abbbabbb"', () {
      expect(s.decodeString("2[a3[b]]"), equals("abbbabbb"));
    });

    test('Random case 2: "a2[bc3[d]]e" → "abcdddbcddde"', () {
      expect(s.decodeString("a2[bc3[d]]e"), equals("abcdddbcddde"));
    });
  });
}
