// https://leetcode.com/problems/valid-parentheses/description/
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  /// Another Way to solve
  bool isValid(String s) {
    List<String> brackets = [];

    const Map<String, String> map = {
      '{': '}',
      '[': ']',
      '(': ')',
    };

    for (int i = 0; i < s.length; i++) {
      String currentBracket = s[i];
      if (map.keys.contains(currentBracket)) {
        brackets.add(currentBracket);

        /// Make sure that the brackets is not empty
        /// before get the last one
      } else if (brackets.isNotEmpty) {
        String lastAddedBracket = brackets.last;
        bool isCloseRight = map[lastAddedBracket] == currentBracket;

        if (isCloseRight) {
          brackets.removeLast();
        } else {
          return false;
        }
      } else {
        return false;
      }
    }

    return brackets.isEmpty;
  }

  ////! Solved From the first time
  // bool isValid(String s) {
  //   List<int> brackets = [];
  //   int openCurlyBracket = '{'.codeUnits[0];
  //   int openSquareBracket = '['.codeUnits[0];
  //   int openRoundBracket = '('.codeUnits[0];

  //   int closeCurlyBracket = '}'.codeUnits[0];
  //   int closeSquareBracket = ']'.codeUnits[0];
  //   int closeRoundBracket = ')'.codeUnits[0];

  //   for (final currentBracket in s.codeUnits) {
  //     if (currentBracket == openRoundBracket ||
  //         currentBracket == openSquareBracket ||
  //         currentBracket == openCurlyBracket) {
  //       brackets.add(currentBracket);

  //       /// Make sure that the brackets is not empty
  //       /// before get the last one
  //     } else if (brackets.isNotEmpty) {
  //       int lastAddedBracket = brackets.last;
  //       bool isCloseRight = (lastAddedBracket == openCurlyBracket &&
  //               currentBracket == closeCurlyBracket) ||
  //           (lastAddedBracket == openSquareBracket &&
  //               currentBracket == closeSquareBracket) ||
  //           (lastAddedBracket == openRoundBracket &&
  //               currentBracket == closeRoundBracket);

  //       if (isCloseRight) {
  //         brackets.removeLast();
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       return false;
  //     }
  //   }

  //   return brackets.isEmpty;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Valid Parentheses', () {
    // Basic examples from problem statement
    test('Example 1: "()" → true', () {
      expect(s.isValid("()"), isTrue);
    });

    test('Example 2: "()[]{}" → true', () {
      expect(s.isValid("()[]{}"), isTrue);
    });

    test('Example 3: "(]" → false', () {
      expect(s.isValid("(]"), isFalse);
    });

    test('Example 4: "([])" → true', () {
      expect(s.isValid("([])"), isTrue);
    });

    // Edge cases
    test('Empty string: "" → true', () {
      expect(s.isValid(""), isTrue);
    });

    test('Single opening: "(" → false', () {
      expect(s.isValid("("), isFalse);
    });

    test('Single closing: ")" → false', () {
      expect(s.isValid(")"), isFalse);
    });

    // Nested cases
    test('Nested valid: "{[]}" → true', () {
      expect(s.isValid("{[]}"), isTrue);
    });

    test('Nested invalid: "{[}]" → false', () {
      expect(s.isValid("{[}]"), isFalse);
    });

    // Mixed valid cases
    test('Mixed valid: "(){}[]" → true', () {
      expect(s.isValid("(){}[]"), isTrue);
    });

    test('Mixed valid complex: "({[]})" → true', () {
      expect(s.isValid("({[]})"), isTrue);
    });

    // Mixed invalid cases
    test('Mixed invalid: "(}" → false', () {
      expect(s.isValid("(}"), isFalse);
    });

    test('Mixed invalid complex: "({[}])" → false', () {
      expect(s.isValid("({[}])"), isFalse);
    });

    // Large strings
    test('Large valid string', () {
      final str = List.filled(5000, '(').join() + List.filled(5000, ')').join();
      expect(s.isValid(str), isTrue);
    });

    test('Large invalid string', () {
      final str = List.filled(5000, '(').join() + List.filled(4999, ')').join();
      expect(s.isValid(str), isFalse);
    });

    test('Maximum length invalid', () {
      final str = List.generate(10000, (i) => ['(', '[', '{'][i % 3]).join();
      expect(s.isValid(str), isFalse);
    });

    // Random cases
    test('Random valid 1: "[({})]()" → true', () {
      expect(s.isValid("[({})]()"), isTrue);
    });

    test('Random invalid 1: "[(])" → false', () {
      expect(s.isValid("[(])"), isFalse);
    });

    // Special cases
    test('Only opening brackets: "{[(" → false', () {
      expect(s.isValid("{[("), isFalse);
    });

    test('Only closing brackets: ")}]" → false', () {
      expect(s.isValid(")}]"), isFalse);
    });

    test('Interleaved brackets: "([)]" → false', () {
      expect(s.isValid("([)]"), isFalse);
    });
  });
}
