// leetcode/73.set_matrix_zeroes.dart
// https://leetcode.com/problems/set-matrix-zeroes/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  List<List<int>> mat = [
    [0, 1, 2, 0],
    [3, 4, 5, 2],
    [1, 3, 1, 5]
  ];
  s.setZeroes(mat);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Not best Space Complexity  Solution
  /// SC: O(N+M)
  /// TC: O(n*m)
  /// Easier Than the commented one,
  /// But the commented one is with less space complexity
  void setZeroes(List<List<int>> matrix) {
    Set<int> rowsIndex = {};
    Set<int> columnsIndex = {};
    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix.first.length; j++) {
        if (matrix[i][j] == 0) {
          rowsIndex.add(i);
          columnsIndex.add(j);
        }
      }
    }

    for (var i = 0; i < matrix.length; i++) {
      for (var j = 0; j < matrix.first.length; j++) {
        if (rowsIndex.contains(i) || columnsIndex.contains(j)) {
          matrix[i][j] = 0;
        }
      }
    }
  }

  //// ! Better Space Complexity
  /// SC: O(1);
  // void setZeroes(List<List<int>> matrix) {
  //   bool isFirstRowHasZero = false;
  //   bool isFirstColumnHasZero = false;
  //   for (var i = 0; i < matrix.length; i++) {
  //     for (var j = 0; j < matrix.first.length; j++) {
  //       if (matrix[i][j] == 0) {
  //         if (i == 0) isFirstRowHasZero = true;
  //         if (j == 0) isFirstColumnHasZero = true;
  //         matrix[0][j] = 0;
  //         matrix[i][0] = 0;
  //       }
  //     }
  //   }

  //   for (var i = 1; i < matrix.length; i++) {
  //     for (var j = 1; j < matrix.first.length; j++) {
  //       /// Replace Rows
  //       if (matrix[i][0] == 0) matrix[i][j] = 0;

  //       /// Replace Columns
  //       if (matrix[0][j] == 0) matrix[i][j] = 0;
  //     }
  //   }

  //   if (isFirstRowHasZero) {
  //     /// Iterate all Columns with Row i = 0;
  //     for (var i = 0; i < matrix.first.length; i++) {
  //       matrix[0][i] = 0;
  //     }
  //   }

  //   if (isFirstColumnHasZero) {
  //     /// Iterate all rows with Column c = 0;
  //     for (var c = 0; c < matrix.length; c++) {
  //       matrix[c][0] = 0;
  //     }
  //   }
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Set Matrix Zeroes', () {
    // Basic examples from problem statement
    test('Example 1: Middle element is zero', () {
      List<List<int>> matrix = [
        [1, 1, 1],
        [1, 0, 1],
        [1, 1, 1]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [1, 0, 1],
            [0, 0, 0],
            [1, 0, 1]
          ]));
    });

    test('Example 2: Multiple zeroes including boundaries', () {
      List<List<int>> matrix = [
        [0, 1, 2, 0],
        [3, 4, 5, 2],
        [1, 3, 1, 5]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [0, 0, 0, 0],
            [0, 4, 5, 0],
            [0, 3, 1, 0]
          ]));
    });

    // Edge Cases
    test('Matrix with no zeroes', () {
      List<List<int>> matrix = [
        [1, 2, 3],
        [4, 5, 6]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [1, 2, 3],
            [4, 5, 6]
          ]));
    });

    test('All zeroes', () {
      List<List<int>> matrix = [
        [0, 0],
        [0, 0]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [0, 0],
            [0, 0]
          ]));
    });

    test('Single row with zero', () {
      List<List<int>> matrix = [
        [1, 0, 1]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [0, 0, 0]
          ]));
    });

    test('Single column with zero', () {
      List<List<int>> matrix = [
        [1],
        [0],
        [1]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [0],
            [0],
            [0]
          ]));
    });

    // Overlapping markers test
    test('Zero at [0,0] only', () {
      List<List<int>> matrix = [
        [0, 1],
        [1, 1]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [0, 0],
            [0, 1]
          ]));
    });

    // Large values and constraints
    test('Handles large integers', () {
      List<List<int>> matrix = [
        [2147483647, 1],
        [1, 0]
      ];
      s.setZeroes(matrix);
      expect(
          matrix,
          equals([
            [2147483647, 0],
            [0, 0]
          ]));
    });
  });

  test(
      'Multi-zero complex case: [[1,2,3,4],[5,0,7,8],[0,10,11,12],[13,14,15,0]]',
      () {
    List<List<int>> matrix = [
      [1, 2, 3, 4],
      [5, 0, 7, 8],
      [0, 10, 11, 12],
      [13, 14, 15, 0]
    ];
    s.setZeroes(matrix);
    expect(
        matrix,
        equals([
          [0, 0, 3, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ]));
  });
}
