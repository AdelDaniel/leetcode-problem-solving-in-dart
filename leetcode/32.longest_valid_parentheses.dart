// Very Hard https://leetcode.com/problems/longest-valid-parentheses/description/

import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  // print(Solution().divide(-17, 5));
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int longestValidParentheses(String s) {
    final List<int> stack = [-1];
    int lengthResult = 0;
    int maxLength = 0;
    final chars = s.split('').toList();
    for (var i = 0; i < s.length; i++) {
      final char = chars[i];

      /// if it is close
      if (char == ')') {
        stack.removeLast();
        if (stack.isNotEmpty) {
          lengthResult = i - stack.last;
          // stack.removeLast();
        } else {
          stack.add(i);
        }
      }

      /// It is open
      else if (char == '(') {
        stack.add(i);
      }

      if (maxLength < lengthResult) {
        maxLength = lengthResult;
      }
    }

    return maxLength;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Longest Valid Parentheses', () {
    // Basic examples from problem statement
    test('Example 1: "(()" → 2', () {
      expect(s.longestValidParentheses("(()"), equals(2));
    });

    test('Example 2: ")()())" → 4', () {
      expect(s.longestValidParentheses(")()())"), equals(4));
    });

    test('Example 3: "" → 0', () {
      expect(s.longestValidParentheses(""), equals(0));
    });

    // Edge cases
    test('Single opening: "(" → 0', () {
      expect(s.longestValidParentheses("("), equals(0));
    });

    test('Single closing: ")" → 0', () {
      expect(s.longestValidParentheses(")"), equals(0));
    });

    // Simple valid cases
    test('Simple valid: "()" → 2', () {
      expect(s.longestValidParentheses("()"), equals(2));
    });

    test('Nested valid: "(()())" → 6', () {
      expect(s.longestValidParentheses("(()())"), equals(6));
    });

    // No valid pairs
    test('No valid pairs: ")))(((" → 0', () {
      expect(s.longestValidParentheses(")))((("), equals(0));
    });

    // Mixed cases
    test('Mixed valid/invalid: "()(()" → 2', () {
      expect(s.longestValidParentheses("()(()"), equals(2));
    });

    test('Complex mixed: ")(()())(" → 6', () {
      expect(s.longestValidParentheses(")(()())("), equals(6));
    });

    // Maximum length cases
    test('Max length all valid: "(((...)))"', () {
      final input = "(" * 15000 + ")" * 15000;
      expect(s.longestValidParentheses(input), equals(30000));
    });

    // Alternating pattern
    test('Alternating pattern: "()()()" → 6', () {
      expect(s.longestValidParentheses("()()()"), equals(6));
    });

    // Complex nested
    test('Complex nested: "((()()()))" → 10', () {
      expect(s.longestValidParentheses("((()()()))"), equals(10));
    });

    // Partial valid at end
    test('Partial valid at end: "(()()))" → 6', () {
      expect(s.longestValidParentheses("(()()))"), equals(6));
    });

    // Random cases
    test('Random case 1: "()(())" → 6', () {
      expect(s.longestValidParentheses("()(())"), equals(6));
    });

    test('Random case 2: "((()))())" → 8', () {
      expect(s.longestValidParentheses("((()))())"), equals(8));
    });
  });
}
