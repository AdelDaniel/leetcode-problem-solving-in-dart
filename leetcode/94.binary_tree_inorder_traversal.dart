// leetcode/94.binary_tree_inorder_traversal.dart
// https://leetcode.com/problems/binary-tree-inorder-traversal/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.inorderTraversal(buildTree([1, null, 2, 3]));

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
  List<int> inorderTraversal(TreeNode? root) {
    final List<int> result = [];
    if (root == null) return result;

    final List<TreeNode> stack = [];
    stack.add(root);

    TreeNode? node;
    while (stack.isNotEmpty) {
      node = stack.last;
      while (node?.left != null && stack.isNotEmpty) {
        stack.add(node!.left!);
        node = node.left;
      }

      node = stack.removeLast();
      result.add(node.val);

      while (node?.right == null && stack.isNotEmpty) {
        node = stack.removeLast();
        result.add(node.val);
      }

      if (node?.right != null) stack.add(node!.right!);
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

  group('Binary Tree Inorder Traversal', () {
    // ===== Examples =====
    test('Example 1: [1,null,2,3] -> [1,3,2]', () {
      final root = buildTree([1, null, 2, 3]);
      expect(s.inorderTraversal(root), equals([1, 3, 2]));
    });

    test('Example 2: [1,2,3,4,5,null,8,null,null,6,7,9] -> [4,2,6,5,7,1,3,9,8]',
        () {
      final root = buildTree([1, 2, 3, 4, 5, null, 8, null, null, 6, 7, 9]);
      expect(s.inorderTraversal(root), equals([4, 2, 6, 5, 7, 1, 3, 9, 8]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(s.inorderTraversal(root), equals([]));
    });

    test('Example 4: [1] -> [1]', () {
      final root = buildTree([1]);
      expect(s.inorderTraversal(root), equals([1]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(s.inorderTraversal(root), equals([]));
    });

    test('Single negative node', () {
      final root = buildTree([-5]);
      expect(s.inorderTraversal(root), equals([-5]));
    });

    test('Single zero node', () {
      final root = buildTree([0]);
      expect(s.inorderTraversal(root), equals([0]));
    });

    // ===== Small Trees =====
    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      expect(s.inorderTraversal(root), equals([2, 1]));
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      expect(s.inorderTraversal(root), equals([1, 3]));
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      expect(s.inorderTraversal(root), equals([2, 1, 3]));
    });

    test('Three levels full tree', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.inorderTraversal(root), equals([4, 2, 5, 1, 6, 3, 7]));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(s.inorderTraversal(root), equals([5, 4, 3, 2, 1]));
    });

    test('Right-skewed tree', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(s.inorderTraversal(root), equals([1, 2, 3, 4, 5]));
    });

    // ===== Sparse Trees =====
    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(s.inorderTraversal(root), equals([2, 5, 1, 3, 7]));
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(s.inorderTraversal(root), equals([3, 4, 6, 7, 8, 9, 10, 15, 20]));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.inorderTraversal(root), equals([-4, -2, -5, -1, -6, -3, -7]));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.inorderTraversal(root), equals([-20, -10, -5, 0, 5, 10, 20]));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(s.inorderTraversal(root), equals([-100, -100, 0, 100, 100]));
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.inorderTraversal(root), equals([5, 5, 5, 5, 5, 5, 5]));
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(s.inorderTraversal(root), equals([3, 2, 3, 1, 3, 2, 3]));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(s.inorderTraversal(root), equals([1, 0, 1, 1, 1, 0, 1]));
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(s.inorderTraversal(root), equals([2, 6, 4, 1, 5, 7, 3]));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        s.inorderTraversal(root),
        equals([
          16,
          8,
          17,
          4,
          18,
          9,
          19,
          2,
          20,
          10,
          21,
          5,
          22,
          11,
          23,
          1,
          24,
          12,
          25,
          6,
          26,
          13,
          27,
          3,
          28,
          14,
          29,
          7,
          30,
          15,
          31
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
      final result = s.inorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.first, equals(1));
      expect(result.last, equals(100));
    });

    test('Constraint-style tree with 100 nodes', () {
      final values = List<int?>.generate(100, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.inorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.contains(values[0]), isTrue);
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist in traversal', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      final result = s.inorderTraversal(root)..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Inorder must visit left subtree before root', () {
      final root = buildTree([1, 2, 3]);
      final result = s.inorderTraversal(root);
      expect(result, equals([2, 1, 3]));
    });

    test('Inorder must fully visit left subtree, then root, then right subtree',
        () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.inorderTraversal(root), equals([4, 2, 5, 1, 6, 3, 7]));
    });
  });
}
