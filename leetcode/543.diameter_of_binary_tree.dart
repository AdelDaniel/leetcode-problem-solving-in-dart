// leetcode/543.diameter_of_binary_tree.dart
// https://leetcode.com/problems/diameter-of-binary-tree/
import 'dart:math';

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.diameterOfBinaryTree(buildTree([1, 2, 3, 4, 5]));

  runTests();
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
  /// Not the best solution
  int diameterOfBinaryTree(TreeNode? root) {
    if (root == null) return 0;
    dfs(root);

    final List<TreeNode> stack = [root];
    int max = root.val;
    TreeNode? current;
    while (stack.isNotEmpty) {
      current = stack.removeLast();
      if (current.val > max) max = current.val;
      if (current.val == 0) continue;
      if (current.right != null) stack.add(current.right!);
      if (current.left != null) stack.add(current.left!);
    }

    return max;
  }

  /// Depth First Search
  int? dfs(TreeNode? node) {
    if (node == null) {
      return null;
    } else if (node.right == null && node.left == null) {
      node.val = 0;
      return 1;
    } else {
      final right = dfs(node.right);
      final left = dfs(node.left);

      if (left != null && right != null) {
        node.val = left + right;
        return 1 + max(left, right);
      } else if (left != null && right == null) {
        node.val = left;
        return 1 + left;
      } else if (left == null && right != null) {
        node.val = right;
        return 1 + right;
      }

      return null;
    }
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

TreeNode? buildLeftSkewedTree(int n) {
  if (n <= 0) return null;
  final root = TreeNode(1);
  TreeNode current = root;

  for (int i = 2; i <= n; i++) {
    current.left = TreeNode(i);
    current = current.left!;
  }

  return root;
}

TreeNode? buildRightSkewedTree(int n) {
  if (n <= 0) return null;
  final root = TreeNode(1);
  TreeNode current = root;

  for (int i = 2; i <= n; i++) {
    current.right = TreeNode(i);
    current = current.right!;
  }

  return root;
}

void runTests() {
  final Solution s = Solution();

  group('Diameter of Binary Tree', () {
    // ===== Examples =====
    test('Example 1: [1,2,3,4,5] -> 3', () {
      final root = buildTree([1, 2, 3, 4, 5]);
      expect(s.diameterOfBinaryTree(root), equals(3));
    });

    test('Example 2: [1,2] -> 1', () {
      final root = buildTree([1, 2]);
      expect(s.diameterOfBinaryTree(root), equals(1));
    });

    // ===== Edge Cases =====
    test('Single node -> 0', () {
      final root = buildTree([1]);
      expect(s.diameterOfBinaryTree(root), equals(0));
    });

    test('Single negative node -> 0', () {
      final root = buildTree([-5]);
      expect(s.diameterOfBinaryTree(root), equals(0));
    });

    test('Two nodes with right child -> 1', () {
      final root = buildTree([1, null, 2]);
      expect(s.diameterOfBinaryTree(root), equals(1));
    });

    // ===== Small Trees =====
    test('Three nodes full tree -> 2', () {
      final root = buildTree([1, 2, 3]);
      expect(s.diameterOfBinaryTree(root), equals(2));
    });

    test('Three nodes left chain -> 2', () {
      final root = buildTree([1, 2, null, 3]);
      expect(s.diameterOfBinaryTree(root), equals(2));
    });

    test('Three nodes right chain -> 2', () {
      final root = buildTree([1, null, 2, null, 3]);
      expect(s.diameterOfBinaryTree(root), equals(2));
    });

    test('Four nodes left-heavy -> 3', () {
      final root = buildTree([1, 2, null, 3, null, 4]);
      expect(s.diameterOfBinaryTree(root), equals(3));
    });

    test('Four nodes balanced-ish -> 3', () {
      final root = buildTree([1, 2, 3, 4]);
      expect(s.diameterOfBinaryTree(root), equals(3));
    });

    // ===== Balanced Trees =====
    test('Perfect binary tree height 3 -> 4', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Perfect binary tree height 4 -> 6', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(s.diameterOfBinaryTree(root), equals(6));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree size 5 -> 4', () {
      final root = buildLeftSkewedTree(5);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Right-skewed tree size 5 -> 4', () {
      final root = buildRightSkewedTree(5);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Left-skewed tree size 10 -> 9', () {
      final root = buildLeftSkewedTree(10);
      expect(s.diameterOfBinaryTree(root), equals(9));
    });

    test('Right-skewed tree size 10 -> 9', () {
      final root = buildRightSkewedTree(10);
      expect(s.diameterOfBinaryTree(root), equals(9));
    });

    // ===== Sparse / Mixed Trees =====
    test('Sparse tree: [1,2,3,4,null,null,5] -> 4', () {
      final root = buildTree([1, 2, 3, 4, null, null, 5]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Uneven sparse tree -> 5', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(s.diameterOfBinaryTree(root), equals(5));
    });

    test('Longest path does not pass through root -> 3', () {
      final root = buildTree([1, 2, null, 3, 4, 5, 6]);
      expect(s.diameterOfBinaryTree(root), equals(3));
    });

    test('Another non-root diameter case -> 4', () {
      final root = buildTree([1, 2, null, 3, 4, 5, 6, 7]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Shallow right subtree but deep left subtree -> 4', () {
      final root = buildTree([1, 2, 3, 4, null, null, null, 5]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values full tree -> 4', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Mixed negative and positive values -> 4', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Min and max constraint values -> 4', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    // ===== Duplicate Values =====
    test('All duplicate values full tree -> 4', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('All duplicate values skewed -> 3', () {
      final root = buildTree([7, 7, null, 7, null, 7]);
      expect(s.diameterOfBinaryTree(root), equals(3));
    });

    test('Mixed duplicates -> 4', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level -> 4', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(s.diameterOfBinaryTree(root), equals(4));
    });

    test('Zig-zag shaped sparse tree -> 6', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(s.diameterOfBinaryTree(root), equals(6));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes -> 8', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(s.diameterOfBinaryTree(root), equals(8));
    });

    test('Large right-skewed tree size 100 -> 99', () {
      final root = buildRightSkewedTree(100);
      expect(s.diameterOfBinaryTree(root), equals(99));
    });

    test('Large left-skewed tree size 100 -> 99', () {
      final root = buildLeftSkewedTree(100);
      expect(s.diameterOfBinaryTree(root), equals(99));
    });

    test('Constraint-style tree with 2000 nodes should return valid diameter',
        () {
      final values = List<int?>.generate(2000, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.diameterOfBinaryTree(root);

      expect(result, greaterThanOrEqualTo(0));
      expect(result, lessThan(2000));
    });

    // ===== Stability / Structure Checks =====
    test('Diameter should be <= node count - 1', () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8];
      final root = buildTree(values);
      final result = s.diameterOfBinaryTree(root);
      expect(result <= values.length - 1, isTrue);
    });

    test('Single path tree should have diameter = depth - 1', () {
      final root = buildRightSkewedTree(8);
      expect(s.diameterOfBinaryTree(root), equals(7));
    });

    test('Complete tree depth 4 should have diameter 6', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(s.diameterOfBinaryTree(root), equals(6));
    });
  });
}
