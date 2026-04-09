// leetcode/144.binary_tree_preorder_traversal.dart
// https://leetcode.com/problems/binary-tree-preorder-traversal/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.preorderTraversal(buildTree([1, null, 2, 3]));

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
  ////! Morris Traversal (Pre Order Traversal)
  /// TS: O(N) && SC: O(1)
  /// The node we visit at the end should its right point again to the most first node of the tree or subtree
  // List<int> preorderTraversal(TreeNode? root) {
  //   final List<int> result = [];
  //   if (root == null) return result;

  //   TreeNode? currentNode = root;
  //   while (currentNode != null) {
  //     if (currentNode.left == null) {
  //       result.add(currentNode.val);
  //       currentNode = currentNode.right;
  //     } else {
  //       TreeNode? mostRightNode = currentNode.left;
  //       while (mostRightNode?.right != null &&
  //           mostRightNode?.right != currentNode) {
  //         mostRightNode = mostRightNode?.right;
  //       }

  //       if (mostRightNode?.right == null) {
  //         result.add(currentNode.val);
  //         mostRightNode?.right = currentNode;
  //         currentNode = currentNode.left;
  //       } else {
  //         mostRightNode?.right = null;
  //         currentNode = currentNode.right;
  //       }
  //     }
  //   }

  //   return result;
  // }

  ////! Popular Solution
  ////! Solved the issue without recursion Easier Solution
  ////! Understand it: https://www.youtube.com/watch?v=1WxLM2hwL-U
  List<int> preorderTraversal(TreeNode? root) {
    final List<int> result = [];
    if (root == null) return result;

    final List<TreeNode> stack = [];
    stack.add(root);

    TreeNode? visitedNode;
    while (stack.isNotEmpty) {
      visitedNode = stack.removeLast();
      result.add(visitedNode.val);
      if (visitedNode.right != null) stack.add(visitedNode.right!);
      if (visitedNode.left != null) stack.add(visitedNode.left!);
    }

    return result;
  }

  ////! First solution not efficient
  // /// Solved the Problem without recursion
  // List<int> preorderTraversal(TreeNode? root) {
  //   final List<int> result = [];
  //   if (root == null) return result;

  //   TreeNode? node = root;

  //   final List<TreeNode> stack = [];
  //   stack.add(node);
  //   result.add(node.val);

  //   while (stack.isNotEmpty) {
  //     /// Check all the left sides first.
  //     while (node?.left != null) {
  //       node = node?.left;
  //       result.add(node!.val);
  //       stack.add(node);
  //     }
  //     node = stack.removeLast();

  //     /// Search for the all rights
  //     while (node?.right == null && stack.isNotEmpty) {
  //       node = stack.removeLast();
  //     }
  //     node = node?.right;

  //     /// if there is right add it to the stack and search for its left again
  //     if (node != null) {
  //       result.add(node.val);
  //       stack.add(node);
  //     }
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

  group('Binary Tree Preorder Traversal', () {
    // ===== Examples =====
    test('Example 1: [1,null,2,3] -> [1,2,3]', () {
      final root = buildTree([1, null, 2, 3]);
      expect(s.preorderTraversal(root), equals([1, 2, 3]));
    });

    test('Example 2: [1,2,3,4,5,null,8,null,null,6,7,9] -> [1,2,4,5,6,7,3,8,9]',
        () {
      final root = buildTree([1, 2, 3, 4, 5, null, 8, null, null, 6, 7, 9]);
      expect(s.preorderTraversal(root), equals([1, 2, 4, 5, 6, 7, 3, 8, 9]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(s.preorderTraversal(root), equals([]));
    });

    test('Example 4: [1] -> [1]', () {
      final root = buildTree([1]);
      expect(s.preorderTraversal(root), equals([1]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(s.preorderTraversal(root), equals([]));
    });

    test('Single negative node', () {
      final root = buildTree([-5]);
      expect(s.preorderTraversal(root), equals([-5]));
    });

    test('Single zero node', () {
      final root = buildTree([0]);
      expect(s.preorderTraversal(root), equals([0]));
    });

    // ===== Small Trees =====
    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      expect(s.preorderTraversal(root), equals([1, 2]));
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      expect(s.preorderTraversal(root), equals([1, 3]));
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      expect(s.preorderTraversal(root), equals([1, 2, 3]));
    });

    test('Three levels full tree', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.preorderTraversal(root), equals([1, 2, 4, 5, 3, 6, 7]));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(s.preorderTraversal(root), equals([1, 2, 3, 4, 5]));
    });

    test('Right-skewed tree', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(s.preorderTraversal(root), equals([1, 2, 3, 4, 5]));
    });

    // ===== Sparse Trees =====
    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(s.preorderTraversal(root), equals([1, 2, 5, 3, 7]));
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(s.preorderTraversal(root), equals([10, 6, 3, 4, 8, 7, 9, 15, 20]));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.preorderTraversal(root), equals([-1, -2, -4, -5, -3, -6, -7]));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.preorderTraversal(root), equals([0, -10, -20, -5, 10, 5, 20]));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(s.preorderTraversal(root), equals([0, -100, -100, 100, 100]));
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.preorderTraversal(root), equals([5, 5, 5, 5, 5, 5, 5]));
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(s.preorderTraversal(root), equals([1, 2, 3, 3, 2, 3, 3]));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(s.preorderTraversal(root), equals([1, 0, 1, 1, 0, 1, 1]));
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(s.preorderTraversal(root), equals([1, 2, 4, 6, 3, 5, 7]));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        s.preorderTraversal(root),
        equals([
          1,
          2,
          4,
          8,
          16,
          17,
          9,
          18,
          19,
          5,
          10,
          20,
          21,
          11,
          22,
          23,
          3,
          6,
          12,
          24,
          25,
          13,
          26,
          27,
          7,
          14,
          28,
          29,
          15,
          30,
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
      final result = s.preorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.first, equals(1));
      expect(result.last, equals(100));
    });

    test('Constraint-style tree with 100 nodes', () {
      final values = List<int?>.generate(100, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.preorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.first, equals(values[0]));
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist in traversal', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      final result = s.preorderTraversal(root)..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Preorder must visit root before children', () {
      final root = buildTree([1, 2, 3, 4, 5]);
      final result = s.preorderTraversal(root);
      expect(result.first, equals(1));
    });

    test('Preorder must fully visit left subtree before right subtree', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.preorderTraversal(root), equals([1, 2, 4, 5, 3, 6, 7]));
    });
  });
}
