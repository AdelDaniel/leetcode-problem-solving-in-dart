// leetcode/1572.matrix_diagonal_sum.dart
// https://leetcode.com/problems/matrix-diagonal-sum/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.diagonalSum([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int diagonalSum(List<List<int>> mat) {
    int sum = 0;

    for (int i = 0; i < mat.length; i++) {
      for (int j = 0; j < mat.length; j++) {
        if (i == j) {
          sum += mat[i][j];
        } else if (i + j == (mat.length - 1)) {
          sum += mat[i][j];
        }
      }
    }

    return sum;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Matrix Diagonal Sum', () {
    // Basic examples from problem statement
    test('Example 1: 3x3 Odd Matrix → 25', () {
      final mat = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ];
      // (1 + 5 + 9) + (3 + 7) = 25 (5 is middle, only counted once)
      expect(s.diagonalSum(mat), equals(25));
    });

    test('Example 2: 4x4 Even Matrix → 8', () {
      final mat = [
        [1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1],
        [1, 1, 1, 1]
      ];
      // (1+1+1+1) + (1+1+1+1) = 8 (No middle element overlap)
      expect(s.diagonalSum(mat), equals(8));
    });

    test('Example 3: 1x1 Matrix → 5', () {
      final mat = [
        [5]
      ];
      expect(s.diagonalSum(mat), equals(5));
    });

    // Edge Cases
    test('2x2 Smallest Even Matrix', () {
      final mat = [
        [1, 2],
        [3, 4]
      ];
      // Primary: 1, 4. Secondary: 2, 3. Sum: 10
      expect(s.diagonalSum(mat), equals(10));
    });

    test('3x3 with Zeros', () {
      final mat = [
        [1, 0, 1],
        [0, 1, 0],
        [1, 0, 1]
      ];
      expect(s.diagonalSum(mat), equals(5));
    });

    // Large values within constraints (1 to 100)
    test('Large values 2x2', () {
      final mat = [
        [100, 100],
        [100, 100]
      ];
      expect(s.diagonalSum(mat), equals(400));
    });

    // Symmetry test
    test('Symmetric matrix values', () {
      final mat = [
        [5, 1, 5],
        [1, 5, 1],
        [5, 1, 5]
      ];
      // 5+5+5 (primary) + 5+5 (secondary) = 25
      expect(s.diagonalSum(mat), equals(25));
    });

    // Max constraint size (100x100)
    test('100x100 Matrix of 1s', () {
      final mat = List.generate(100, (_) => List.generate(100, (_) => 1));
      // Primary: 100 ones. Secondary: 100 ones.
      // Since 100 is even, there is no center overlap.
      expect(s.diagonalSum(mat), equals(200));
    });
  });
}
