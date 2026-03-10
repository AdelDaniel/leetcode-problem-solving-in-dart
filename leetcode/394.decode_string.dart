// leetcode/394.decode_string.dart
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
  /// Good an AI answer, I think it is the best solution for this problem.
  String decodeString(String s) {
    List<int> numStack = [];
    List<String> strStack = [];
    StringBuffer sb = StringBuffer();
    int len = s.length;
    int i = 0;

    while (i < len) {
      String ch = s[i];
      if (RegExp(r'\d').hasMatch(ch)) {
        // Build the full number (could be multi-digit)
        int num = int.parse(ch);
        while (i + 1 < len && RegExp(r'\d').hasMatch(s[i + 1])) {
          num = num * 10 + int.parse(s[i + 1]);
          i++;
        }
        numStack.add(num);
      } else if (ch == '[') {
        // Save current string and start a new one for the content inside brackets
        strStack.add(sb.toString());
        sb.clear();
      } else if (ch == ']') {
        // Pop the last number and previous string, then repeat the current sb content
        int k = numStack.removeLast();
        StringBuffer tmp = StringBuffer(strStack.removeLast());
        for (int j = 0; j < k; j++) {
          tmp.write(sb.toString());
        }
        sb = tmp;
      } else {
        // Regular character, just append
        sb.write(ch);
      }
      i++;
    }
    return sb.toString();
  }

  // /// Slower than the previous solution But I think it is easier.
  // String decodeString(String s) {
  //   final StringBuffer sbResult = StringBuffer();
  //   final List<String> subStringStack = [];
  //   final StringBuffer sbRepeatNumber = StringBuffer();
  //   final List<String> stack = [];

  //   for (var i = 0; i < s.length; i++) {
  //     if (s[i] != ']') {
  //       stack.add(s[i]);
  //       continue;
  //     }

  //     /// Get the subString
  //     do {
  //       final last = stack.removeLast();
  //       subStringStack.add(last);
  //     } while (stack.last != '[');
  //     stack.removeLast();
  //     final String subString = subStringStack.join();

  //     /// Get the repeat number
  //     do {
  //       sbRepeatNumber.write(stack.removeLast());
  //     } while (stack.isNotEmpty && RegExp(r'\d').hasMatch(stack.last));
  //     final int repeatNumber =
  //         int.parse(sbRepeatNumber.toString().split('').reversed.join());

  //     subStringStack.clear();
  //     sbRepeatNumber.clear();

  //     stack.add(subString * repeatNumber);
  //   }

  //   do {
  //     sbResult.write(stack.removeLast());
  //   } while (stack.isNotEmpty);

  //   return sbResult.toString().toString().split('').reversed.join();
  // }

  ////! Accepted from the first time
  ////! Try to find another solution
//   String decodeString(String s) {
//     final StringBuffer sbResult = StringBuffer();
//     String subString = "";
//     final List<String> stack = [];
//     for (var i = 0; i < s.length; i++) {
//       final char = s[i];
//       if (char == ']') {
//         String lastChar = stack.removeLast();

//         /// Get the substring needed to be repeated
//         /// Add all the chars in the [] in the substring to repeat
//         while (lastChar != '[') {
//           subString = lastChar + subString;
//           lastChar = stack.removeLast();
//         }
//         lastChar = stack.last;
//         int number = 0;
//         int tens = 1;

//         /// Get the repeat number
//         while (lastChar.startsWith(RegExp(r'[0-9]'))) {
//           stack.removeLast();
//           number += int.parse(lastChar) * tens;
//           tens *= 10;
//           if (stack.isNotEmpty) {
//             lastChar = stack.last;
//           } else {
//             break;
//           }
//         }

//         /// Check if the stack is empty:
//         /// Then I will add the substring to the result
//         /// Else Then I need to repeat this again and add this to the stack
//         if (stack.isNotEmpty) {
//           stack.add(subString * number);
//         } else {
//           sbResult.write(subString * number);
//         }
//         subString = "";
//         number = 0;
//         tens = 1;
//       } else if (char == '[') {
//         stack.add(char);
//       } else if (char.startsWith(RegExp(r'[0-9]'))) {
//         stack.add(char);
//       } else {
//         /// If the string not in the [] then add it to the string result without repeat
//         if (stack.isEmpty) {
//           sbResult.write(char);
//         } else {
//           stack.add(char);
//         }
//       }
//     }

//     return sbResult.toString();
//   }
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
