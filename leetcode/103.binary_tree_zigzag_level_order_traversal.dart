// leetcode/103.binary_tree_zigzag_level_order_traversal.dart
// https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.zigzagLevelOrder(buildTree([3, 9, 20, null, null, 15, 7]));

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
  /// Good Solution
  List<List<int>> zigzagLevelOrder(TreeNode? root) {
    final List<List<int>> result = [];
    if (root == null) return result;

    final List<TreeNode> queue = [];

    queue.add(root);
    int currentLevel = 0;

    while (queue.isNotEmpty) {
      int size = queue.length;
      final List<int> newLevel = [];
      while (size > 0) {
        final visitedNode = queue.removeAt(0);
        currentLevel % 2 == 0
            ? newLevel.add(visitedNode.val)
            : newLevel.insert(0, visitedNode.val);
        if (visitedNode.left != null) queue.add(visitedNode.left!);
        if (visitedNode.right != null) queue.add(visitedNode.right!);
        size--;
      }
      result.add(newLevel);
      currentLevel++;
    }

    return result;
  }

  /// Another Solution
  // List<List<int>> zigzagLevelOrder(TreeNode? root) {
  //   final List<List<int>> result = [];
  //   if (root == null) return result;

  //   /// The queue will include all the visited node
  //   final List<TreeNode> queue = [];

  //   queue.add(root);
  //   bool isRTL = true;

  //   while (queue.isNotEmpty) {
  //     int size = queue.length;
  //     final List<int> newLevel = [];
  //     while (size > 0) {
  //       final visitedNode = queue.removeAt(0);
  //       newLevel.add(visitedNode.val);
  //       if (visitedNode.left != null) queue.add(visitedNode.left!);
  //       if (visitedNode.right != null) queue.add(visitedNode.right!);
  //       size--;
  //     }
  //     result.add(isRTL ? newLevel : newLevel.reversed.toList());
  //     isRTL = !isRTL;
  //   }

  //   return result;
  // }
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

  group('Binary Tree Zigzag Level Order Traversal', () {
    // ===== Examples =====
    test('Example 1: [3,9,20,null,null,15,7] -> [[3],[20,9],[15,7]]', () {
      final root = buildTree([3, 9, 20, null, null, 15, 7]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [3],
          [20, 9],
          [15, 7],
        ]),
      );
    });

    test('Example 2: [1] -> [[1]]', () {
      final root = buildTree([1]);
      expect(
          s.zigzagLevelOrder(root),
          equals([
            [1]
          ]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(s.zigzagLevelOrder(root), equals([]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(s.zigzagLevelOrder(root), equals([]));
    });

    test('Single node zero', () {
      final root = buildTree([0]);
      expect(
          s.zigzagLevelOrder(root),
          equals([
            [0]
          ]));
    });

    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [2],
        ]),
      );
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3],
        ]),
      );
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
        ]),
      );
    });

    // ===== Balanced Trees =====
    test('Perfect binary tree height 3', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
          [4, 5, 6, 7],
        ]),
      );
    });

    test('Perfect binary tree height 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
          [4, 5, 6, 7],
          [15, 14, 13, 12, 11, 10, 9, 8],
        ]),
      );
    });

    // ===== Unbalanced / Sparse Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [2],
          [3],
          [4],
          [5],
        ]),
      );
    });

    test('Right-skewed tree', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [2],
          [3],
          [4],
          [5],
        ]),
      );
    });

    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
          [5, 7],
        ]),
      );
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [10],
          [15, 6],
          [3, 8, 20],
          [9, 7, 4],
        ]),
      );
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [-1],
          [-3, -2],
          [-4, -5, -6, -7],
        ]),
      );
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [0],
          [10, -10],
          [-20, -5, 5, 20],
        ]),
      );
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [0],
          [100, -100],
          [-100, 100],
        ]),
      );
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [5],
          [5, 5],
          [5, 5, 5, 5],
        ]),
      );
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [2, 2],
          [3, 3, 3, 3],
        ]),
      );
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [0, 0],
          [1, 1, 1, 1],
        ]),
      );
    });

    test('Zig-zag shaped sparse tree still alternates by level', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
          [4, 5],
          [7, 6],
        ]),
      );
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        s.zigzagLevelOrder(root),
        equals([
          [1],
          [3, 2],
          [4, 5, 6, 7],
          [15, 14, 13, 12, 11, 10, 9, 8],
          [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31],
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
      final result = s.zigzagLevelOrder(root);

      expect(result.length, equals(100));
      expect(result.first, equals([1]));
      expect(result.last, equals([100]));
    });

    test('Constraint-style tree with 2000 nodes', () {
      final values = List<int?>.generate(2000, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.zigzagLevelOrder(root);

      expect(result.isNotEmpty, isTrue);
      expect(result.first.length, equals(1));
      expect(result.expand((level) => level).length, equals(2000));
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist in traversal', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      final result = s.zigzagLevelOrder(root).expand((level) => level).toList()
        ..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Second level must be reversed', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      final result = s.zigzagLevelOrder(root);
      expect(result[1], equals([3, 2]));
    });

    test('Third level must return to left-to-right', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      final result = s.zigzagLevelOrder(root);
      expect(result[2], equals([4, 5, 6, 7]));
    });
  });
}
