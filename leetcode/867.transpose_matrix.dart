// leetcode/867.transpose_matrix.dart
// https://leetcode.com/problems/transpose-matrix/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.transpose([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// TS: O(n*m) SC: O(n*m)
  List<List<int>> transpose(List<List<int>> matrix) {
    final int rows = matrix.length;
    final int columns = matrix.first.length;

    final List<List<int>> result = List.generate(columns, (_) => []);

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        result[c].insert(r, matrix[r][c]);
      }
    }

    return result;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Transpose Matrix', () {
    // Basic examples from problem statement
    test('Example 1: 3x3 Square Matrix → Transposed', () {
      final input = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ];
      final expected = [
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9]
      ];
      expect(s.transpose(input), equals(expected));
    });

    test('Example 2: 2x3 Rectangular Matrix → 3x2 Matrix', () {
      final input = [
        [1, 2, 3],
        [4, 5, 6]
      ];
      final expected = [
        [1, 4],
        [2, 5],
        [3, 6]
      ];
      expect(s.transpose(input), equals(expected));
    });

    // Edge Cases
    test('1x1 Matrix: [[5]] → [[5]]', () {
      expect(
          s.transpose([
            [5]
          ]),
          equals([
            [5]
          ]));
    });

    test('1x3 Row Vector → 3x1 Column Vector', () {
      final input = [
        [1, 2, 3]
      ];
      final expected = [
        [1],
        [2],
        [3]
      ];
      expect(s.transpose(input), equals(expected));
    });

    test('3x1 Column Vector → 1x3 Row Vector', () {
      final input = [
        [1],
        [2],
        [3]
      ];
      final expected = [
        [1, 2, 3]
      ];
      expect(s.transpose(input), equals(expected));
    });

    // Identity-like tests
    test('Symmetric Matrix: stays the same', () {
      final input = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1]
      ];
      expect(s.transpose(input), equals(input));
    });

    // Negative and large values
    test('Negative values and large range', () {
      final input = [
        [-10, 20],
        [30, -40]
      ];
      final expected = [
        [-10, 30],
        [20, -40]
      ];
      expect(s.transpose(input), equals(expected));
    });
// Constraint limits (Max 1000x1 or 1x1000)
    test('Large thin matrix performance', () {
      final input = List.generate(1000, (i) => [i]);
      final result = s.transpose(input);
      expect(result.length, equals(1));
      expect(result[0].length, equals(1000));
      expect(result[0][999], equals(999));
    });
  });
}
