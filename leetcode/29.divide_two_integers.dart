// https://leetcode.com/problems/divide-two-integers/description/
// Not solved it contains an error
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  // print(Solution().divide(-17, 5));
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int divide(int dividend, int divisor) {
    if (divisor == 1) return dividend;
    if (dividend == 0) return 0;
    if (divisor == 1) return dividend * -1;

    return dividend ~/ divisor;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Divide Two Integers', () {
    // Basic examples from problem statement
    test('Example 1: 10 / 3 = 3', () {
      expect(s.divide(10, 3), equals(3));
    });

    test('Example 2: 7 / -3 = -2', () {
      expect(s.divide(7, -3), equals(-2));
    });

    // Edge cases
    test('Divide by 1: 15 / 1 = 15', () {
      expect(s.divide(15, 1), equals(15));
    });

    test('Divide by -1: 15 / -1 = -15', () {
      expect(s.divide(15, -1), equals(-15));
    });

    test('Divide by self: 20 / 20 = 1', () {
      expect(s.divide(20, 20), equals(1));
    });

    test('Divide by negative self: 20 / -20 = -1', () {
      expect(s.divide(20, -20), equals(-1));
    });

    // Large numbers
    test('Large dividend: 2147483647 / 1 = 2147483647', () {
      expect(s.divide(2147483647, 1), equals(2147483647));
    });

    test('Large negative dividend: -2147483648 / 1 = -2147483648', () {
      expect(s.divide(-2147483648, 1), equals(-2147483648));
    });

    // Overflow cases
    test('Overflow positive: -2147483648 / -1 = 2147483648', () {
      expect(s.divide(-2147483648, -1), equals(2147483648));
    });

    test('Overflow negative: -2147483648 / 1 = -2147483648', () {
      expect(s.divide(-2147483648, 1), equals(-2147483648));
    });

    // Zero cases
    test('Zero dividend: 0 / 5 = 0', () {
      expect(s.divide(0, 5), equals(0));
    });

    test('Zero dividend negative divisor: 0 / -5 = 0', () {
      expect(s.divide(0, -5), equals(0));
    });

    // Power of two divisions
    test('Power of two division: 16 / 4 = 4', () {
      expect(s.divide(16, 4), equals(4));
    });

    test('Negative power of two: -32 / 8 = -4', () {
      expect(s.divide(-32, 8), equals(-4));
    });

    // Large divisor
    test('Large divisor: 2147483647 / 2147483647 = 1', () {
      expect(s.divide(2147483647, 2147483647), equals(1));
    });

    test('Large negative divisor: -2147483648 / -2147483648 = 1', () {
      expect(s.divide(-2147483648, -2147483648), equals(1));
    });

    // Complex cases
    test('Complex case 1: 123456 / 789 = 156', () {
      expect(s.divide(123456, 789), equals(156));
    });

    test('Complex case 2: -123456 / 789 = -156', () {
      expect(s.divide(-123456, 789), equals(-156));
    });

    // Minimum constraints
    test('Minimum dividend: -2147483648 / 2 = -1073741824', () {
      expect(s.divide(-2147483648, 2), equals(-1073741824));
    });

    test('Minimum divisor: 2147483647 / -2147483648 = 0', () {
      expect(s.divide(2147483647, -2147483648), equals(0));
    });

    // Special cases
    test('Odd division: 17 / 5 = 3', () {
      expect(s.divide(17, 5), equals(3));
    });

    test('Negative odd division: -17 / 5 = -3', () {
      expect(s.divide(-17, 5), equals(-3));
    });

    test('Negative odd division: -2147483648 / -1 = 2147483648', () {
      expect(s.divide(-2147483648, -1), equals(2147483648));
    });
  });
}
