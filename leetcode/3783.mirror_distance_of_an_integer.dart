// leetcode/3783.mirror_distance_of_an_integer.dart
// https://leetcode.com/problems/mirror-distance-of-an-integer/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.mirrorDistance(25);

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int mirrorDistance(int n) {
    List reversed = "$n".split('').reversed.toList();
    final result = n - int.parse(reversed.join());
    return result > 0 ? result : result * -1;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Mirror Distance of an Integer', () {
    // ===== Examples =====
    test('Example 1: 25 -> 27', () {
      expect(s.mirrorDistance(25), equals(27));
    });

    test('Example 2: 10 -> 9', () {
      expect(s.mirrorDistance(10), equals(9));
    });

    test('Example 3: 7 -> 0', () {
      expect(s.mirrorDistance(7), equals(0));
    });

    // ===== Single Digit =====
    test('Single digit 1 -> 0', () {
      expect(s.mirrorDistance(1), equals(0));
    });

    test('Single digit 5 -> 0', () {
      expect(s.mirrorDistance(5), equals(0));
    });

    test('Single digit 9 -> 0', () {
      expect(s.mirrorDistance(9), equals(0));
    });

    // ===== Two Digits =====
    test('12 -> 9', () {
      expect(s.mirrorDistance(12), equals(9)); // |12 - 21| = 9
    });

    test('21 -> 9', () {
      expect(s.mirrorDistance(21), equals(9)); // |21 - 12| = 9
    });

    test('11 -> 0', () {
      expect(s.mirrorDistance(11), equals(0));
    });

    test('90 -> 81', () {
      expect(s.mirrorDistance(90), equals(81)); // reverse = 9
    });

    test('20 -> 18', () {
      expect(s.mirrorDistance(20), equals(18)); // reverse = 2
    });

    // ===== Palindromes =====
    test('121 -> 0', () {
      expect(s.mirrorDistance(121), equals(0));
    });

    test('1331 -> 0', () {
      expect(s.mirrorDistance(1331), equals(0));
    });

    test('9999 -> 0', () {
      expect(s.mirrorDistance(9999), equals(0));
    });

    // ===== Trailing Zeros =====
    test('100 -> 99', () {
      expect(s.mirrorDistance(100), equals(99)); // reverse = 1
    });

    test('120 -> 99', () {
      expect(s.mirrorDistance(120), equals(99)); // reverse = 21
    });

    test('1000 -> 999', () {
      expect(s.mirrorDistance(1000), equals(999)); // reverse = 1
    });

    test('1050 -> 549', () {
      expect(s.mirrorDistance(1050), equals(549)); // reverse = 501
    });

    test('1010 -> 909', () {
      expect(s.mirrorDistance(1010), equals(909)); // reverse = 101
    });

    // ===== General 3 Digits =====
    test('123 -> 198', () {
      expect(s.mirrorDistance(123), equals(198)); // |123 - 321|
    });

    test('321 -> 198', () {
      expect(s.mirrorDistance(321), equals(198)); // |321 - 123|
    });

    test('907 -> 198', () {
      expect(s.mirrorDistance(907), equals(198)); // reverse = 709
    });

    test('340 -> 297', () {
      expect(s.mirrorDistance(340), equals(297)); // reverse = 43
    });

    // ===== General 4 Digits =====
    test('1221 -> 0', () {
      expect(s.mirrorDistance(1221), equals(0));
    });

    test('1234 -> 3087', () {
      expect(s.mirrorDistance(1234), equals(3087)); // |1234 - 4321|
    });

    // ===== Mixed Zeros Inside =====
    test('101 -> 0', () {
      expect(s.mirrorDistance(101), equals(0));
    });

    test('1001 -> 0', () {
      expect(s.mirrorDistance(1001), equals(0));
    });

    test('1020 -> 819', () {
      expect(s.mirrorDistance(1020), equals(819)); // reverse = 201
    });

    // ===== Larger Values =====
    test('12345 -> 41976', () {
      expect(s.mirrorDistance(12345), equals(41976)); // reverse = 54321
    });

    test('54321 -> 41976', () {
      expect(s.mirrorDistance(54321), equals(41976)); // reverse = 12345
    });

    test('100000 -> 99999', () {
      expect(s.mirrorDistance(100000), equals(99999)); // reverse = 1
    });

    test('100001 -> 0', () {
      expect(s.mirrorDistance(100001), equals(0));
    });

    test('123456789 -> 864197532', () {
      expect(s.mirrorDistance(123456789), equals(864197532));
    });

    // ===== Near Constraint =====
    test('999999999 -> 0', () {
      expect(s.mirrorDistance(999999999), equals(0));
    });

    test('1000000000 -> 999999999', () {
      expect(s.mirrorDistance(1000000000), equals(999999999)); // reverse = 1
    });

    test('987654321 -> 864197532', () {
      expect(s.mirrorDistance(987654321),
          equals(864197532)); // reverse = 123456789
    });

    test('1000000001 -> 0', () {
      expect(s.mirrorDistance(1000000001), equals(0));
    });

    // ===== Stability / Sanity =====
    test('Mirror distance is always non-negative', () {
      final result = s.mirrorDistance(1050);
      expect(result >= 0, isTrue);
    });
  });
}
