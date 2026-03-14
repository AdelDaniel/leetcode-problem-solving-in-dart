// leetcode/50.pow_x_n.dart
// https://leetcode.com/problems/powx-n/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  // s.myPow(2.0, 10);
  s.myPow(2.0, -2);

  /// Run All tests
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Fast Solution with Exponentiation by Squaring
  /// TC: O(Log(n)) SC: O(1)
  double myPow(double x, int n) {
    if (n == 1) return x;
    if (n == 0) return 1;
    if (n < 0) {
      x = 1 / x;
      n = -1 * n;
    }
    double result = 1;
    int exp = n;
    while (exp > 0) {
      if (exp % 2 == 1) result *= x;
      x *= x;
      exp ~/= 2;
    }
    return result;
  }
  ////! Good but you will not learn anything from this solution
  // double myPow(double x, int n) {
  //   return pow(x, n).toDouble();
  // }

  /// stuped Solution --> Stack Overflow
  // double myPow(double x, int n) {
  //   if (n == 1) return x;
  //   if (n == 0) return 1;
  //   if (n < 0) {
  //     x = 1 / x;
  //     n = -1 * n;
  //   }
  //   return n == 1 ? 1 : myPow(x, n - 1) * x;
  // }

  /// stuped Solution --> Time Limit Exceeded
  // double myPow(double x, int n) {
  //   if (n == 1) return x;
  //   if (n == 0) return 1;
  //   if (n < 0) {
  //     x = 1 / x;
  //     n = -1 * n;
  //   }
  //   double result = x;
  //   for (int i = 1; i < n; i++) {
  //     result = result * x;
  //   }
  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Pow(x, n)', () {
    // Basic examples from problem statement
    test('Example 1: 2.00000^10 → 1024.00000', () {
      expect(s.myPow(2.0, 10), closeTo(1024.0, 1e-9));
    });

    test('Example 2: 2.10000^3 → 9.26100', () {
      expect(s.myPow(2.1, 3), closeTo(9.261, 1e-9));
    });

    test('Example 3: 2.00000^-2 → 0.25000', () {
      expect(s.myPow(2.0, -2), closeTo(0.25, 1e-9));
    });

    // Edge cases - exponent zero
    test('Any non-zero number to power 0: 5.0^0 → 1.0', () {
      expect(s.myPow(5.0, 0), closeTo(1.0, 1e-9));
    });

    test('Negative base to power 0: -3.5^0 → 1.0', () {
      expect(s.myPow(-3.5, 0), closeTo(1.0, 1e-9));
    });

    test('Fractional base to power 0: 0.25^0 → 1.0', () {
      expect(s.myPow(0.25, 0), closeTo(1.0, 1e-9));
    });

    // Edge cases - exponent one
    test('Power one: 7.0^1 → 7.0', () {
      expect(s.myPow(7.0, 1), closeTo(7.0, 1e-9));
    });

    test('Negative base power one: -7.0^1 → -7.0', () {
      expect(s.myPow(-7.0, 1), closeTo(-7.0, 1e-9));
    });

    test('Fractional base power one: 0.5^1 → 0.5', () {
      expect(s.myPow(0.5, 1), closeTo(0.5, 1e-9));
    });

    // Positive exponents
    test('Small positive exponent: 3.0^4 → 81.0', () {
      expect(s.myPow(3.0, 4), closeTo(81.0, 1e-9));
    });

    test('Larger positive exponent: 2.0^20 → 1048576.0', () {
      expect(s.myPow(2.0, 20), closeTo(1048576.0, 1e-9));
    });

    test('Odd exponent: 2.0^5 → 32.0', () {
      expect(s.myPow(2.0, 5), closeTo(32.0, 1e-9));
    });

    test('Even exponent: 2.0^6 → 64.0', () {
      expect(s.myPow(2.0, 6), closeTo(64.0, 1e-9));
    });

    // Negative exponents
    test('Negative exponent simple: 2.0^-3 → 0.125', () {
      expect(s.myPow(2.0, -3), closeTo(0.125, 1e-9));
    });

    test('Negative exponent with odd power: 3.0^-3 → 1/27', () {
      expect(s.myPow(3.0, -3), closeTo(1 / 27, 1e-9));
    });

    test('Negative exponent with even power: 4.0^-2 → 1/16', () {
      expect(s.myPow(4.0, -2), closeTo(1 / 16, 1e-9));
    });

    // Base one and minus one
    test('Base one: 1.0^100000 → 1.0', () {
      expect(s.myPow(1.0, 100000), closeTo(1.0, 1e-9));
    });

    test('Base one with negative exponent: 1.0^-100000 → 1.0', () {
      expect(s.myPow(1.0, -100000), closeTo(1.0, 1e-9));
    });

    test('Base minus one with even exponent: (-1.0)^10 → 1.0', () {
      expect(s.myPow(-1.0, 10), closeTo(1.0, 1e-9));
    });

    test('Base minus one with odd exponent: (-1.0)^11 → -1.0', () {
      expect(s.myPow(-1.0, 11), closeTo(-1.0, 1e-9));
    });

    test('Base minus one with negative even exponent: (-1.0)^-8 → 1.0', () {
      expect(s.myPow(-1.0, -8), closeTo(1.0, 1e-9));
    });

    test('Base minus one with negative odd exponent: (-1.0)^-9 → -1.0', () {
      expect(s.myPow(-1.0, -9), closeTo(-1.0, 1e-9));
    });

    // Negative bases
    test('Negative base, even exponent: (-2.0)^4 → 16.0', () {
      expect(s.myPow(-2.0, 4), closeTo(16.0, 1e-9));
    });

    test('Negative base, odd exponent: (-2.0)^5 → -32.0', () {
      expect(s.myPow(-2.0, 5), closeTo(-32.0, 1e-9));
    });

    test('Negative base, negative even exponent: (-2.0)^-4 → 0.0625', () {
      expect(s.myPow(-2.0, -4), closeTo(0.0625, 1e-9));
    });

    test('Negative base, negative odd exponent: (-2.0)^-3 → -0.125', () {
      expect(s.myPow(-2.0, -3), closeTo(-0.125, 1e-9));
    });

    // Fractional bases
    test('Fractional base less than 1: 0.5^3 → 0.125', () {
      expect(s.myPow(0.5, 3), closeTo(0.125, 1e-9));
    });

    test('Fractional base with negative exponent: 0.5^-3 → 8.0', () {
      expect(s.myPow(0.5, -3), closeTo(8.0, 1e-9));
    });

    test('Fractional base greater than 1: 1.5^3 → 3.375', () {
      expect(s.myPow(1.5, 3), closeTo(3.375, 1e-9));
    });

    test('Fractional base with larger exponent: 1.1^5 → 1.61051', () {
      expect(s.myPow(1.1, 5), closeTo(1.61051, 1e-9));
    });

    // Zero base cases
    test('Zero base positive exponent: 0.0^5 → 0.0', () {
      expect(s.myPow(0.0, 5), closeTo(0.0, 1e-9));
    });

    test('Zero base exponent one: 0.0^1 → 0.0', () {
      expect(s.myPow(0.0, 1), closeTo(0.0, 1e-9));
    });

    // Large exponent cases
    test('Large exponent power of two: 2.0^30 → 1073741824.0', () {
      expect(s.myPow(2.0, 30), closeTo(1073741824.0, 1e-6));
    });

    test('Large negative exponent power of two: 2.0^-30 → small positive', () {
      expect(s.myPow(2.0, -30), closeTo(1 / 1073741824.0, 1e-15));
    });

    test('Large odd exponent: 3.0^15 → 14348907.0', () {
      expect(s.myPow(3.0, 15), closeTo(14348907.0, 1e-3));
    });

    // Cases specifically useful for exponentiation by squaring
    test('Exponentiation by squaring - even exponent: 5.0^8 → 390625.0', () {
      expect(s.myPow(5.0, 8), closeTo(390625.0, 1e-6));
    });

    test('Exponentiation by squaring - odd exponent: 5.0^9 → 1953125.0', () {
      expect(s.myPow(5.0, 9), closeTo(1953125.0, 1e-6));
    });

    test('Exponentiation by squaring - negative odd exponent: 5.0^-3 → 0.008',
        () {
      expect(s.myPow(5.0, -3), closeTo(0.008, 1e-9));
    });

    // Precision-focused cases
    test('Precision case: 2.5^3 → 15.625', () {
      expect(s.myPow(2.5, 3), closeTo(15.625, 1e-9));
    });

    test('Precision case: 0.1^3 → 0.001', () {
      expect(s.myPow(0.1, 3), closeTo(0.001, 1e-9));
    });

    test('Precision case: 10.0^-4 → 0.0001', () {
      expect(s.myPow(10.0, -4), closeTo(0.0001, 1e-12));
    });

    // Boundary-like cases within constraints
    test('Near boundary positive base: 99.999^1 → 99.999', () {
      expect(s.myPow(99.999, 1), closeTo(99.999, 1e-9));
    });

    test('Near boundary negative base: -99.999^1 → -99.999', () {
      expect(s.myPow(-99.999, 1), closeTo(-99.999, 1e-9));
    });

    test('Very small positive base: 0.0001^2 → 0.00000001', () {
      expect(s.myPow(0.0001, 2), closeTo(0.00000001, 1e-15));
    });

    // Cases with repeated squaring behavior
    test('Power of power behavior: 4.0^5 → 1024.0', () {
      expect(s.myPow(4.0, 5), closeTo(1024.0, 1e-9));
    });

    test('Power reducing with negative exponent: 4.0^-5 → 1/1024', () {
      expect(s.myPow(4.0, -5), closeTo(1 / 1024, 1e-12));
    });

    // Small random cases
    test('Random case 1: 7.0^2 → 49.0', () {
      expect(s.myPow(7.0, 2), closeTo(49.0, 1e-9));
    });

    test('Random case 2: -3.0^3 → -27.0', () {
      expect(s.myPow(-3.0, 3), closeTo(-27.0, 1e-9));
    });

    test('Random case 3: 8.0^-2 → 0.015625', () {
      expect(s.myPow(8.0, -2), closeTo(0.015625, 1e-9));
    });

    test('Random case 4: 1.25^4 → 2.44140625', () {
      expect(s.myPow(1.25, 4), closeTo(2.44140625, 1e-9));
    });

    test('Random case 5: -1.5^2 → 2.25', () {
      expect(s.myPow(-1.5, 2), closeTo(2.25, 1e-9));
    });

    // Performance-style tests
    test('Large exponent with base 1 should stay fast: 1.0^2147483647 → 1.0',
        () {
      expect(s.myPow(1.0, 2147483647), closeTo(1.0, 1e-9));
    });

    test(
        'Large exponent with base -1 should stay fast: (-1.0)^2147483647 → -1.0',
        () {
      expect(s.myPow(-1.0, 2147483647), closeTo(-1.0, 1e-9));
    });

    test(
        'Large negative exponent with base 1 should stay fast: 1.0^-2147483648 → 1.0',
        () {
      expect(s.myPow(1.0, -2147483648), closeTo(1.0, 1e-9));
    });

    // Extreme int exponent edge case
    test('Min int exponent with safe base: (-1.0)^-2147483648 → 1.0', () {
      expect(s.myPow(-1.0, -2147483648), closeTo(1.0, 1e-9));
    });

    // Verification against a trusted small-case computation
    test(
        'Verification against simple repeated multiplication for small exponent',
        () {
      const double x = 2.0;
      const int n = 7;

      double bruteForce = 1.0;
      for (int i = 0; i < n; i++) {
        bruteForce *= x;
      }

      expect(s.myPow(x, n), closeTo(bruteForce, 1e-9));
    });

    test(
        'Verification against simple repeated multiplication for small negative exponent',
        () {
      const double x = 2.0;
      const int n = -5;

      double bruteForce = 1.0;
      for (int i = 0; i < -n; i++) {
        bruteForce *= x;
      }
      bruteForce = 1 / bruteForce;

      expect(s.myPow(x, n), closeTo(bruteForce, 1e-9));
    });
  });
}
