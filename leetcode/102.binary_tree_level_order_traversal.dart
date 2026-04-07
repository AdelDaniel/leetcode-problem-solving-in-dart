// leetcode/102.binary_tree_level_order_traversal.dart
// https://leetcode.com/problems/binary-tree-level-order-traversal/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.levelOrder(buildTree([3, 9, 20, null, null, 15, 7]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode(this.val, [this.left, this.right]);
}

class Solution {
  /// TS: O(N)
  /// SC: O(N)
  /// Understand Solution: https://www.youtube.com/watch?v=HZ5YTanv5QE
  List<List<int>> levelOrder(TreeNode? root) {
    final List<List<int>> result = [];
    if (root == null) return result;

    List<TreeNode> queue = [];
    queue.add(root);
    while (queue.isNotEmpty) {
      int size = queue.length;
      final List<int> newLevel = [];
      while (size > 0) {
        final node = queue.removeAt(0);
        newLevel.add(node.val);
        if (node.left != null) queue.add(node.left!);
        if (node.right != null) queue.add(node.right!);
        size--;
      }
      result.add(newLevel);
    }

    return result;
  }
}

TreeNode? buildTree(List<int?> values) {
  if (values.isEmpty || values[0] == null) return null;

  final root = TreeNode(values[0]!);
  final queue = <TreeNode>[root];
  int i = 1;

  while (i < values.length && queue.isNotEmpty) {
    final current = queue.removeAt(0);

    if (i < values.length && values[i] != null) {
      current.left = TreeNode(values[i]!);
      queue.add(current.left!);
    }
    i++;

    if (i < values.length && values[i] != null) {
      current.right = TreeNode(values[i]!);
      queue.add(current.right!);
    }
    i++;
  }

  return root;
}

void runTests() {
  final Solution s = Solution();

  group('Binary Tree Level Order Traversal', () {
    // ===== Examples =====
    test('Example 1: [3,9,20,null,null,15,7] -> [[3],[9,20],[15,7]]', () {
      final root = buildTree([3, 9, 20, null, null, 15, 7]);
      expect(
        s.levelOrder(root),
        equals([
          [3],
          [9, 20],
          [15, 7]
        ]),
      );
    });

    test('Example 2: [1] -> [[1]]', () {
      final root = buildTree([1]);
      expect(
          s.levelOrder(root),
          equals([
            [1]
          ]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(s.levelOrder(root), equals([]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(s.levelOrder(root), equals([]));
    });

    test('Single node with zero', () {
      final root = buildTree([0]);
      expect(
          s.levelOrder(root),
          equals([
            [0]
          ]));
    });

    test('Single node with negative value', () {
      final root = buildTree([-5]);
      expect(
          s.levelOrder(root),
          equals([
            [-5]
          ]));
    });

    // ===== Two / Three Nodes =====
    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2]
        ]),
      );
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [3]
        ]),
      );
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3]
        ]),
      );
    });

    // ===== Balanced Trees =====
    test('Perfect binary tree height 3', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [4, 5, 6, 7]
        ]),
      );
    });

    test('Perfect binary tree height 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [4, 5, 6, 7],
          [8, 9, 10, 11, 12, 13, 14, 15]
        ]),
      );
    });

    // ===== Unbalanced Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2],
          [3],
          [4],
          [5]
        ]),
      );
    });

    test('Right-skewed tree', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2],
          [3],
          [4],
          [5]
        ]),
      );
    });

    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [5, 7]
        ]),
      );
    });

    test('Uneven tree mixed null positions', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(
        s.levelOrder(root),
        equals([
          [10],
          [6, 15],
          [3, 8, 20],
          [4, 7, 9]
        ]),
      );
    });

    // ===== Negative and Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(
        s.levelOrder(root),
        equals([
          [-1],
          [-2, -3],
          [-4, -5, -6, -7]
        ]),
      );
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(
        s.levelOrder(root),
        equals([
          [0],
          [-10, 10],
          [-20, -5, 5, 20]
        ]),
      );
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -1000, 1000, -1000, null, null, 1000]);
      expect(
        s.levelOrder(root),
        equals([
          [0],
          [-1000, 1000],
          [-1000, 1000]
        ]),
      );
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(
        s.levelOrder(root),
        equals([
          [5],
          [5, 5],
          [5, 5, 5, 5]
        ]),
      );
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 2],
          [3, 3, 3, 3]
        ]),
      );
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [0, 0],
          [1, 1, 1, 1]
        ]),
      );
    });

    test('Zig-zag shaped sparse tree still level-order left to right', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [4, 5],
          [6, 7]
        ]),
      );
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [4, 5, 6, 7],
          [8, 9, 10, 11, 12, 13, 14, 15],
          [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
        ]),
      );
    });

    test('Large skewed tree size 100', () {
      final values = <int?>[1];
      for (int i = 2; i <= 100; i++) {
        values.add(null);
        values.add(i);
      }
      final root = buildTree(values);
      final result = s.levelOrder(root);

      expect(result.length, equals(100));
      expect(result.first, equals([1]));
      expect(result.last, equals([100]));
    });

    test('Constraint-style tree with 2000 nodes', () {
      final values = List<int?>.generate(2000, (i) => i - 1000);
      final root = buildTree(values);
      final result = s.levelOrder(root);

      expect(result.first, equals([-1000]));
      expect(result.length, greaterThan(0));
      expect(result.expand((level) => level).length, equals(2000));
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist in traversal', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      final result = s.levelOrder(root).expand((level) => level).toList()
        ..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Each level should preserve left-to-right order', () {
      final root = buildTree([1, 2, 3, 4, null, 5, 6]);
      expect(
        s.levelOrder(root),
        equals([
          [1],
          [2, 3],
          [4, 5, 6]
        ]),
      );
    });
  });
}
