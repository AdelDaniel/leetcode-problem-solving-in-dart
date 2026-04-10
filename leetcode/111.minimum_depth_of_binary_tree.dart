// leetcode/111.minimum_depth_of_binary_tree.dart
// https://leetcode.com/problems/minimum-depth-of-binary-tree/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.minDepth(buildTree([3, 9, 20, null, null, 15, 7]));

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
  int minDepth(TreeNode? root) {
    if (root == null) return 0;

    List<TreeNode> queue = [root];
    TreeNode? currentNode;
    int levelCounter = 1;

    while (queue.isNotEmpty) {
      final size = queue.length;
      for (var i = 0; i < size; i++) {
        currentNode = queue.removeAt(0);
        if (currentNode.left == null && currentNode.right == null) {
          return levelCounter;
        } else {
          if (currentNode.left != null) queue.add(currentNode.left!);
          if (currentNode.right != null) queue.add(currentNode.right!);
        }
      }
      levelCounter++;
    }
    return levelCounter;
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

void runTests() {
  final Solution s = Solution();

  group('Minimum Depth of Binary Tree', () {
    // ===== Examples =====
    test('Example 1: [3,9,20,null,null,15,7] -> 2', () {
      final root = buildTree([3, 9, 20, null, null, 15, 7]);
      expect(s.minDepth(root), equals(2));
    });

    test('Example 2: [2,null,3,null,4,null,5,null,6] -> 5', () {
      final root = buildTree([2, null, 3, null, 4, null, 5, null, 6]);
      expect(s.minDepth(root), equals(5));
    });

    // ===== Edge Cases =====
    test('Empty tree -> 0', () {
      final root = buildTree([]);
      expect(s.minDepth(root), equals(0));
    });

    test('Null root using [null] -> 0', () {
      final root = buildTree([null]);
      expect(s.minDepth(root), equals(0));
    });

    test('Single node -> 1', () {
      final root = buildTree([1]);
      expect(s.minDepth(root), equals(1));
    });

    test('Single negative node -> 1', () {
      final root = buildTree([-5]);
      expect(s.minDepth(root), equals(1));
    });

    // ===== Small Trees =====
    test('Root with only left child -> 2', () {
      final root = buildTree([1, 2]);
      expect(s.minDepth(root), equals(2));
    });

    test('Root with only right child -> 2', () {
      final root = buildTree([1, null, 3]);
      expect(s.minDepth(root), equals(2));
    });

    test('Root with two children -> 2', () {
      final root = buildTree([1, 2, 3]);
      expect(s.minDepth(root), equals(2));
    });

    test('Three levels perfect tree -> 3', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.minDepth(root), equals(3));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree depth 5 -> 5', () {
      final root = buildLeftSkewedTree(5);
      expect(s.minDepth(root), equals(5));
    });

    test('Right-skewed tree depth 5 -> 5', () {
      final root = buildRightSkewedTree(5);
      expect(s.minDepth(root), equals(5));
    });

    test('Long left-skewed tree depth 20 -> 20', () {
      final root = buildLeftSkewedTree(20);
      expect(s.minDepth(root), equals(20));
    });

    test('Long right-skewed tree depth 20 -> 20', () {
      final root = buildRightSkewedTree(20);
      expect(s.minDepth(root), equals(20));
    });

    // ===== Important correctness cases =====
    test('Should not treat missing child as leaf: [1,2,null,3] -> 3', () {
      final root = buildTree([1, 2, null, 3]);
      expect(s.minDepth(root), equals(3));
    });

    test('Should not treat missing child as leaf: [1,null,2,null,3] -> 3', () {
      final root = buildTree([1, null, 2, null, 3]);
      expect(s.minDepth(root), equals(3));
    });

    test('Shallow leaf on right side -> 2', () {
      final root = buildTree([1, 2, 3, 4, 5]);
      expect(s.minDepth(root), equals(2));
    });

    test('Shallow leaf on left side -> 2', () {
      final root = buildTree([1, 2, 3, null, null, 6, 7, 8]);
      expect(s.minDepth(root), equals(2));
    });

    test('Sparse tree with nearest leaf deep in left subtree -> 4', () {
      final root = buildTree([1, 2, null, 3, null, 4]);
      expect(s.minDepth(root), equals(4));
    });

    test('Sparse tree with nearest leaf in right subtree -> 3', () {
      final root = buildTree([1, 2, 3, 4, null, null, null]);
      expect(s.minDepth(root), equals(2));
    });

    // ===== Balanced / Unbalanced Mix =====
    test('Balanced tree with different leaf depths -> choose smaller', () {
      final root = buildTree([1, 2, 3, 4, null, null, null, 5]);
      expect(s.minDepth(root), equals(2));
    });

    test('Unbalanced tree where left is deeper but right leaf is closer -> 2',
        () {
      final root = buildTree([1, 2, 3, 4, null, null, null, 5, null]);
      expect(s.minDepth(root), equals(2));
    });

    test('Unbalanced tree where both sides continue -> 4', () {
      final root = buildTree([1, 2, 3, 4, null, 5, null, 6]);
      expect(s.minDepth(root), equals(3));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.minDepth(root), equals(3));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.minDepth(root), equals(3));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -1000, 1000, -1000, null, null, 1000]);
      expect(s.minDepth(root), equals(3));
    });

    // ===== Duplicate Values =====
    test('All duplicate values full tree', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.minDepth(root), equals(3));
    });

    test('All duplicate values skewed tree', () {
      final root = buildTree([7, 7, null, 7, null, 7]);
      expect(s.minDepth(root), equals(4));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes -> 5', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(s.minDepth(root), equals(5));
    });

    test('Large right-skewed tree size 100 -> 100', () {
      final root = buildRightSkewedTree(100);
      expect(s.minDepth(root), equals(100));
    });

    test('Large left-skewed tree size 100 -> 100', () {
      final root = buildLeftSkewedTree(100);
      expect(s.minDepth(root), equals(100));
    });

    test('Constraint-style tree with 2000 nodes should return positive depth',
        () {
      final values = List<int?>.generate(2000, (i) => i - 1000);
      final root = buildTree(values);
      final result = s.minDepth(root);

      expect(result, greaterThan(0));
      expect(result, lessThanOrEqualTo(2000));
    });

    // ===== Stability / Structure Checks =====
    test('Minimum depth should never exceed total node count', () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8];
      final root = buildTree(values);
      final result = s.minDepth(root);
      expect(result <= values.length, isTrue);
    });

    test('Complete tree depth 4 -> 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(s.minDepth(root), equals(4));
    });
  });
}
