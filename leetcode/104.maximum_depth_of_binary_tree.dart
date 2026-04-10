// leetcode/104.maximum_depth_of_binary_tree.dart
// https://leetcode.com/problems/maximum-depth-of-binary-tree/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.maxDepth(buildTree([3, 9, 20, null, null, 15, 7]));

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
  /// Accepted But too slow
  int maxDepth(TreeNode? root) {
    if (root == null) return 0;

    List<TreeNode> queue = [root];
    TreeNode? currentNode;
    int levelCounter = 0;

    while (queue.isNotEmpty) {
      final size = queue.length;
      for (var i = 0; i < size; i++) {
        currentNode = queue.removeAt(0);
        if (currentNode.left != null) queue.add(currentNode.left!);
        if (currentNode.right != null) queue.add(currentNode.right!);
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

  group('Maximum Depth of Binary Tree', () {
    // ===== Examples =====
    test('Example 1: [3,9,20,null,null,15,7] -> 3', () {
      final root = buildTree([3, 9, 20, null, null, 15, 7]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Example 2: [1,null,2] -> 2', () {
      final root = buildTree([1, null, 2]);
      expect(s.maxDepth(root), equals(2));
    });

    // ===== Edge Cases =====
    test('Empty tree -> 0', () {
      final root = buildTree([]);
      expect(s.maxDepth(root), equals(0));
    });

    test('Null root using [null] -> 0', () {
      final root = buildTree([null]);
      expect(s.maxDepth(root), equals(0));
    });

    test('Single node -> 1', () {
      final root = buildTree([1]);
      expect(s.maxDepth(root), equals(1));
    });

    test('Single negative node -> 1', () {
      final root = buildTree([-5]);
      expect(s.maxDepth(root), equals(1));
    });

    test('Single zero node -> 1', () {
      final root = buildTree([0]);
      expect(s.maxDepth(root), equals(1));
    });

    // ===== Small Trees =====
    test('Root with only left child -> 2', () {
      final root = buildTree([1, 2]);
      expect(s.maxDepth(root), equals(2));
    });

    test('Root with only right child -> 2', () {
      final root = buildTree([1, null, 3]);
      expect(s.maxDepth(root), equals(2));
    });

    test('Root with two children -> 2', () {
      final root = buildTree([1, 2, 3]);
      expect(s.maxDepth(root), equals(2));
    });

    test('Three levels perfect tree -> 3', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Four levels perfect tree -> 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(s.maxDepth(root), equals(4));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree depth 5 -> 5', () {
      final root = buildLeftSkewedTree(5);
      expect(s.maxDepth(root), equals(5));
    });

    test('Right-skewed tree depth 5 -> 5', () {
      final root = buildRightSkewedTree(5);
      expect(s.maxDepth(root), equals(5));
    });

    test('Long left-skewed tree depth 20 -> 20', () {
      final root = buildLeftSkewedTree(20);
      expect(s.maxDepth(root), equals(20));
    });

    test('Long right-skewed tree depth 20 -> 20', () {
      final root = buildRightSkewedTree(20);
      expect(s.maxDepth(root), equals(20));
    });

    // ===== Sparse / Unbalanced Trees =====
    test('Sparse tree with gaps -> 3', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Uneven sparse tree -> 4', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(s.maxDepth(root), equals(4));
    });

    test('Deep chain on left side -> 4', () {
      final root = buildTree([1, 2, 3, 4, null, null, null]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Deep chain on right side -> 4', () {
      final root = buildTree([1, 2, 3, null, null, null, 4]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Mixed depths should choose the longer path', () {
      final root = buildTree([1, 2, 3, 4, null, null, null, 5]);
      expect(s.maxDepth(root), equals(4));
    });

    test('Another mixed tree should choose the longer path', () {
      final root = buildTree([1, 2, 3, null, 4, null, null, 5]);
      expect(s.maxDepth(root), equals(4));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(s.maxDepth(root), equals(3));
    });

    // ===== Duplicate Values =====
    test('All duplicate values full tree', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.maxDepth(root), equals(3));
    });

    test('All duplicate values skewed tree', () {
      final root = buildTree([7, 7, null, 7, null, 7]);
      expect(s.maxDepth(root), equals(4));
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(s.maxDepth(root), equals(3));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(s.maxDepth(root), equals(3));
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(s.maxDepth(root), equals(4));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes -> 5', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(s.maxDepth(root), equals(5));
    });

    test('Large right-skewed tree size 100 -> 100', () {
      final root = buildRightSkewedTree(100);
      expect(s.maxDepth(root), equals(100));
    });

    test('Large left-skewed tree size 100 -> 100', () {
      final root = buildLeftSkewedTree(100);
      expect(s.maxDepth(root), equals(100));
    });

    test('Large right-skewed tree size 1000 -> 1000', () {
      final root = buildRightSkewedTree(1000);
      expect(s.maxDepth(root), equals(1000));
    });

    test('Constraint-style tree with 2000 nodes should return positive depth',
        () {
      final values = List<int?>.generate(2000, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.maxDepth(root);

      expect(result, greaterThan(0));
      expect(result, lessThanOrEqualTo(2000));
    });

    // ===== Stability / Structure Checks =====
    test('Maximum depth should be >= minimum possible when tree is not empty',
        () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8];
      final root = buildTree(values);
      final result = s.maxDepth(root);
      expect(result >= 1, isTrue);
    });

    test('Maximum depth should never exceed total node count', () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8];
      final root = buildTree(values);
      final result = s.maxDepth(root);
      expect(result <= values.length, isTrue);
    });

    test('Complete tree depth 4 -> 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(s.maxDepth(root), equals(4));
    });
  });
}
