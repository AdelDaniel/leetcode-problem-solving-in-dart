// leetcode/1706.where_will_the_ball_fall.dart
// https://leetcode.com/problems/where-will-the-ball-fall/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.findBall([
    [1, 1, 1, -1, -1],
    [1, 1, 1, -1, -1],
    [-1, -1, -1, 1, 1],
    [1, 1, 1, 1, -1],
    [-1, -1, -1, -1, -1]
  ]);

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  List<int> findBall(List<List<int>> grid) {
    final rowsNumber = grid.length;
    final columnsNumber = grid.first.length;
    final List<int> res = [];

    /// Number of balls equals number of columns
    for (var ball = 0; ball < columnsNumber; ball++) {
      int row = 0;
      int column = ball;
      final List<int> path = [];

      while (row < rowsNumber) {
        // The Angel is /
        if (grid[row][column] == -1) {
          /// First Column will hit the Border '/'
          if (column == 0) {
            res.add(-1);
            break;

            /// If the current is / angle. And the previous angle is \
            /// Then will make V shape
          } else if (grid[row][column - 1] == 1) {
            res.add(-1);
            break;

            /// If the current is / angle. And the previous angle is /
            /// Then will make V shape
          } else {
            path.add(grid[row][column]);
            column--;
            row++;
          }
        }

        // The Angel is \
        else if (grid[row][column] == 1) {
          /// Last Column
          if (column == columnsNumber - 1) {
            res.add(-1);
            break;
          }

          /// If the current is \ angle. And the next angle is /
          /// Then will make V shape
          else if (grid[row][column + 1] == -1) {
            res.add(-1);
            break;
          }

          /// If the current is \ angle. And the next angle is \
          /// Then will make V shape
          else if (grid[row][column + 1] == 1) {
            path.add(grid[row][column]);
            column++;
            row++;
          }
        }
      }

      /// Add last column the ball get out from
      if (path.length == rowsNumber) {
        res.add(column);
      }
    }

    return res;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Where Will the Ball Fall', () {
    // Example 1: Complex 5x5 grid
    test('Example 1: Multiple balls getting stuck', () {
      final grid = [
        [1, 1, 1, -1, -1],
        [1, 1, 1, -1, -1],
        [-1, -1, -1, 1, 1],
        [1, 1, 1, 1, -1],
        [-1, -1, -1, -1, -1]
      ];
      expect(s.findBall(grid), equals([1, -1, -1, -1, -1]));
    });

    // Example 2: Single cell stuck against wall
    test('Example 2: Stuck against left wall', () {
      final grid = [
        [-1]
      ];
      expect(s.findBall(grid), equals([-1]));
    });

    // Example 3: Zig-zag success
    test('Example 3: Long zig-zag paths', () {
      final grid = [
        [1, 1, 1, 1, 1, 1],
        [-1, -1, -1, -1, -1, -1],
        [1, 1, 1, 1, 1, 1],
        [-1, -1, -1, -1, -1, -1]
      ];
      expect(s.findBall(grid), equals([0, 1, 2, 3, 4, -1]));
    });

    // Edge Case: Stuck against right wall
    test('Stuck against right wall', () {
      final grid = [
        [1]
      ];
      expect(s.findBall(grid), equals([-1]));
    });

    // Edge Case: "V" shape in middle
    test('V-shape trap: [1, -1]', () {
      final grid = [
        [1, -1]
      ];
      expect(s.findBall(grid), equals([-1, -1]));
    });

    // Edge Case: Inverse "V" (A-shape) success
    test('A-shape (divergent): [-1, 1]', () {
      // Ball 0 moves left out of bounds (-1), Ball 1 moves right out of bounds (-1)
      final grid = [
        [-1, 1]
      ];
      expect(s.findBall(grid), equals([-1, -1]));
    });

    // Straight diagonal success
    test('Parallel diagonal boards (All Right)', () {
      final grid = [
        [1, 1, 1],
        [1, 1, 1]
      ];
      // Ball 0 -> Col 1 -> Col 2
      // Ball 1 -> Col 2 -> Out of bounds
      // Ball 2 -> Out of bounds
      expect(s.findBall(grid), equals([2, -1, -1]));
    });

    // Large constraints (m, n up to 100)
    test('Large grid success path', () {
      // Create a grid where ball 0 falls out at column 0
      final grid = List.generate(100, (i) => i % 2 == 0 ? [1, -1] : [-1, 1]);
      final result = s.findBall(grid);
      expect(result.length, equals(2));
    });
  });
}
