// leetcode/48.rotate_image.dart
// https://leetcode.com/problems/rotate-image/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  List<List<int>> mat = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  s.rotate(mat);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// TS: O(n^2)
  void rotate(List<List<int>> matrix) {
    /// Flip
    for (var i = 0; i < matrix.length ~/ 2; i++) {
      final temp = matrix[i];
      matrix[i] = matrix[matrix.length - 1 - i];
      matrix[matrix.length - 1 - i] = temp;
    }

    /// Transpose
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < i; j++) {
        final temp = matrix[i][j];
        matrix[i][j] = matrix[j][i];
        matrix[j][i] = temp;
      }
    }
  }
}

void runTests() {
  final Solution s = Solution();

  group('Rotate Image (90 Degrees Clockwise)', () {
    // Basic examples from problem statement
    test('Example 1: 3x3 Matrix', () {
      List<List<int>> matrix = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [7, 4, 1],
            [8, 5, 2],
            [9, 6, 3]
          ]));
    });

    test('Example 2: 4x4 Matrix', () {
      List<List<int>> matrix = [
        [5, 1, 9, 11],
        [2, 4, 8, 10],
        [13, 3, 6, 7],
        [15, 14, 12, 16]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [15, 13, 2, 5],
            [14, 3, 4, 1],
            [12, 6, 8, 9],
            [16, 7, 10, 11]
          ]));
    });

    // Edge Cases
    test('1x1 Matrix: [[1]] → [[1]]', () {
      List<List<int>> matrix = [
        [1]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [1]
          ]));
    });

    test('2x2 Smallest Matrix', () {
      List<List<int>> matrix = [
        [1, 2],
        [3, 4]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [3, 1],
            [4, 2]
          ]));
    });

    // Symmetrical and Patterned Matrices
    test('All same values', () {
      List<List<int>> matrix = [
        [0, 0],
        [0, 0]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [0, 0],
            [0, 0]
          ]));
    });

    test('Negative and large values', () {
      List<List<int>> matrix = [
        [-1, -2],
        [100, 200]
      ];
      s.rotate(matrix);
      expect(
          matrix,
          equals([
            [100, -1],
            [200, -2]
          ]));
    });

    // Verification of "In-Place" (though Dart's pass-by-reference handles this)
    test('Check if the same list object is modified', () {
      List<List<int>> matrix = [
        [1, 2],
        [3, 4]
      ];
      final originalReference = matrix;
      s.rotate(matrix);
      expect(identical(matrix, originalReference), isTrue);
    });
  });
}
