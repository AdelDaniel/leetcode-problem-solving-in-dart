// https://leetcode.com/problems/sequential-digits/description/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  print(Solution().sequentialDigits(100, 300));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // GOOD: Function Execution Time : 000 micro sec
  // BAD : Function Execution Time : 000 micro sec
}

class Solution {
  /// Good Solution from AI.
  // List<int> sequentialDigits(int low, int high) {
  //   final List<int> result = [];

  //   for (int digitsNumber = 2; digitsNumber <= 9; digitsNumber++) {
  //     for (int start = 1; start <= 9 - digitsNumber + 1; start++) {
  //       int sequentialNumber = 0;
  //       for (int j = start; j < digitsNumber + start; j++) {
  //         sequentialNumber = 10 * sequentialNumber + j;
  //       }

  //       if (sequentialNumber >= low && sequentialNumber <= high) {
  //         result.add(sequentialNumber);
  //       }
  //     }
  //   }

  //   return result;
  // }

  /// Internet Solution (Udemy)
  List<int> sequentialDigits(int low, int high) {
    String str = "123456789";
    List<int> list = [];
    for (int i = 2; i <= 9; i++) {
      for (int j = 0; i + j <= 9; j++) {
        String tmp = str.substring(j, j + i);
        int val = int.parse(tmp);
        if (val >= low && val <= high) {
          list.add(val);
        }
      }
    }
    return list;
  }

  /// My Solution
  // List<int> sequentialDigits(int low, int high) {
  //   int digitsNumber = 2;
  //   const String fullSequentialNumber = "123456789";
  //   int sequentialNumber = 0;
  //   int firstIndex = 0;

  //   final List<int> result = [];

  //   while (sequentialNumber <= high) {
  //     sequentialNumber = int.parse(fullSequentialNumber.substring(
  //       firstIndex,
  //       firstIndex + digitsNumber,
  //     ));
  //     if (digitsNumber + firstIndex < fullSequentialNumber.length) {
  //       ++firstIndex;
  //     } else {
  //       firstIndex = 0;
  //       digitsNumber++;
  //     }
  //     if (sequentialNumber >= low && sequentialNumber <= high) {
  //       result.add(sequentialNumber);
  //     }

  //     if (digitsNumber + firstIndex > fullSequentialNumber.length) break;
  //   }
  //   return result;
  // }

  /// My Fist Fucking Solution
  /// This Solution works with me from the first time
  // List<int> sequentialDigits(int low, int high) {
  //   int digitsNumber = 2;
  //   int firstSequentialNumberInDigits = 12;
  //   int sequentialNumber = 12;
  //   final List<int> result = [];

  //   while (sequentialNumber <= high) {
  //     if (sequentialNumber >= low) {
  //       result.add(sequentialNumber);
  //     }

  //     int mod = sequentialNumber % 10;

  //     /// Check are we going with same number of digits or we are going to add another digit
  //     if (mod != 9) {
  //       int newSequentialNumber = 0;

  //       /// Get the next sequentialNumber form the before --> will be reversed 321
  //       /// current sequential 123 -> 432
  //       while (sequentialNumber != 0) {
  //         mod = sequentialNumber % 10;
  //         sequentialNumber ~/= 10;
  //         newSequentialNumber = newSequentialNumber * 10 + mod + 1;
  //       }
  //       sequentialNumber = newSequentialNumber;
  //       newSequentialNumber = 0;

  //       /// Reverse the number from 321 to 123
  //       while (sequentialNumber != 0) {
  //         mod = sequentialNumber % 10;
  //         sequentialNumber ~/= 10;
  //         newSequentialNumber = newSequentialNumber * 10 + mod;
  //       }
  //       sequentialNumber = newSequentialNumber;
  //     } else {
  //       int mod = firstSequentialNumberInDigits % 10;
  //       firstSequentialNumberInDigits =
  //           firstSequentialNumberInDigits * 10 + mod + 1;
  //       sequentialNumber = firstSequentialNumberInDigits;
  //       digitsNumber++;
  //       if (digitsNumber > 9) {
  //         break;
  //       }
  //     }
  //   }

  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Sequential Digits', () {
    // Basic examples from problem statement
    test('Example 1: low=100, high=300 → [123,234]', () {
      expect(s.sequentialDigits(100, 300), equals([123, 234]));
    });

    test(
        'Example 2: low=1000, high=13000 → [1234,2345,3456,4567,5678,6789,12345]',
        () {
      expect(s.sequentialDigits(1000, 13000),
          equals([1234, 2345, 3456, 4567, 5678, 6789, 12345]));
    });

    // Edge cases
    test('Single digit range: low=1, high=9 → []', () {
      expect(s.sequentialDigits(1, 9), equals([]));
    });

    test('Range with no sequential digits: low=100, high=110 → []', () {
      expect(s.sequentialDigits(100, 110), equals([]));
    });

    test('Range equals single sequential digit: low=123, high=123 → [123]', () {
      expect(s.sequentialDigits(123, 123), equals([123]));
    });

    // Small ranges
    test('Small range with one result: low=10, high=50 → [12,23,34,45]', () {
      expect(s.sequentialDigits(10, 50), equals([12, 23, 34, 45]));
    });

    test(
        'Small range with multiple results: low=100, high=500 → [123,234,345,456]',
        () {
      expect(s.sequentialDigits(100, 500), equals([123, 234, 345, 456]));
    });

    // Large ranges
    test(
        'Large range: low=10, high=1000000000 → [12,23,34,45,56,67,78,89,123,...789,1234,...6789,...123456789]',
        () {
      final result = s.sequentialDigits(10, 1000000000);
      expect(result.length, equals(36));
      expect(result.first, equals(12));
      expect(result.last, equals(123456789));
    });

    // Boundary cases
    test('Minimum constraints: low=10, high=10 → []', () {
      expect(s.sequentialDigits(10, 10), equals([]));
    });

    test('Maximum constraints: low=10, high=1000000000 → full sequence', () {
      expect(s.sequentialDigits(10, 1000000000).length, equals(36));
    });

    // Special cases
    test(
        'Range starting with sequential digit: low=123, high=500 → [123,234,345,456]',
        () {
      expect(s.sequentialDigits(123, 500), equals([123, 234, 345, 456]));
    });

    test(
        'Range ending with sequential digit: low=100, high=678 → [123,234,345,456,567,678]',
        () {
      expect(
          s.sequentialDigits(100, 678), equals([123, 234, 345, 456, 567, 678]));
    });

    // All possible lengths
    test(
        'All 2-digit sequential numbers: low=10, high=100 → [12,23,34,45,56,67,78,89]',
        () {
      expect(s.sequentialDigits(10, 100),
          equals([12, 23, 34, 45, 56, 67, 78, 89]));
    });

    test(
        'All 3-digit sequential numbers: low=100, high=1000 → [123,234,345,456,567,678,789]',
        () {
      expect(s.sequentialDigits(100, 1000),
          equals([123, 234, 345, 456, 567, 678, 789]));
    });
  });
}
