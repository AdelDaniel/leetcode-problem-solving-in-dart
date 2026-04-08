// leetcode/145.binary_tree_postorder_traversal.dart
// https://leetcode.com/problems/binary-tree-postorder-traversal/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.postorderTraversal(buildTree([1, null, 2, 3]));

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
  /// Performs a Post-order traversal (Left -> Right -> Root)
  /// using an iterative approach with a stack.
  List<int> postorderTraversal(TreeNode? root) {
    // 1. Handle empty tree case
    if (root == null) return [];

    // This list will store nodes in 'Reverse Post-order' (Root -> Right -> Left)
    List<int> traversalOrder = [];

    // The stack helps us keep track of nodes to visit next
    List<TreeNode> stack = [root];

    while (stack.isNotEmpty) {
      // 2. Pop the last node added to the stack
      TreeNode current = stack.removeLast();

      // 3. Process the current node (Add to our temporary list)
      traversalOrder.add(current.val);

      /* 
     * STRATEGY: To get Left -> Right -> Root, we first build 
     * the sequence: Root -> Right -> Left.
     * 
     * To ensure 'Right' is processed before 'Left', 
     * we push 'Left' into the stack first, then 'Right'.
     */

      // Push Left child first (will be at the bottom of the stack)
      if (current.left != null) stack.add(current.left!);

      // Push Right child second (will be popped and processed first)
      if (current.right != null) stack.add(current.right!);
    }

    /* 
   * 4. FINAL STEP:
   * Our 'traversalOrder' is currently: [Root, Right, Left]
   * By reversing it, we get: [Left, Right, Root]
   * This is exactly what Post-order requires.
   */
    return traversalOrder.reversed.toList();
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

  group('Binary Tree Postorder Traversal', () {
    // ===== Examples =====
    test('Example 1: [1,null,2,3] -> [3,2,1]', () {
      final root = buildTree([1, null, 2, 3]);
      expect(s.postorderTraversal(root), equals([3, 2, 1]));
    });

    test('Example 2: [1,2,3,4,5,null,8,null,null,6,7,9] -> [4,6,7,5,2,9,8,3,1]',
        () {
      final root = buildTree([1, 2, 3, 4, 5, null, 8, null, null, 6, 7, 9]);
      expect(s.postorderTraversal(root), equals([4, 6, 7, 5, 2, 9, 8, 3, 1]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(s.postorderTraversal(root), equals([]));
    });

    test('Example 4: [1] -> [1]', () {
      final root = buildTree([1]);
      expect(s.postorderTraversal(root), equals([1]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(s.postorderTraversal(root), equals([]));
    });

    test('Single negative node', () {
      final root = buildTree([-5]);
      expect(s.postorderTraversal(root), equals([-5]));
    });

    test('Single zero node', () {
      final root = buildTree([0]);
      expect(s.postorderTraversal(root), equals([0]));
    });

    // ===== Small Trees =====
    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      expect(s.postorderTraversal(root), equals([2, 1]));
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      expect(s.postorderTraversal(root), equals([3, 1]));
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      expect(s.postorderTraversal(root), equals([2, 3, 1]));
    });

    test('Three levels full tree', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.postorderTraversal(root), equals([4, 5, 2, 6, 7, 3, 1]));
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(s.postorderTraversal(root), equals([5, 4, 3, 2, 1]));
    });

    test('Right-skewed tree', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(s.postorderTraversal(root), equals([5, 4, 3, 2, 1]));
    });

    // ===== Sparse Trees =====
    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(s.postorderTraversal(root), equals([5, 2, 7, 3, 1]));
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(
          s.postorderTraversal(root), equals([4, 3, 7, 9, 8, 6, 20, 15, 10]));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(s.postorderTraversal(root), equals([-4, -5, -2, -6, -7, -3, -1]));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(s.postorderTraversal(root), equals([-20, -5, -10, 5, 20, 10, 0]));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(s.postorderTraversal(root), equals([-100, -100, 100, 100, 0]));
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.postorderTraversal(root), equals([5, 5, 5, 5, 5, 5, 5]));
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(s.postorderTraversal(root), equals([3, 3, 2, 3, 3, 2, 1]));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(s.postorderTraversal(root), equals([1, 1, 0, 1, 1, 0, 1]));
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(s.postorderTraversal(root), equals([6, 4, 2, 7, 5, 3, 1]));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        s.postorderTraversal(root),
        equals([
          16,
          17,
          8,
          18,
          19,
          9,
          4,
          20,
          21,
          10,
          22,
          23,
          11,
          5,
          2,
          24,
          25,
          12,
          26,
          27,
          13,
          6,
          28,
          29,
          14,
          30,
          31,
          15,
          7,
          3,
          1
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
      final result = s.postorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.first, equals(100));
      expect(result.last, equals(1));
    });

    test('Constraint-style tree with 100 nodes', () {
      final values = List<int?>.generate(100, (i) => (i % 201) - 100);
      final root = buildTree(values);
      final result = s.postorderTraversal(root);

      expect(result.length, equals(100));
      expect(result.contains(values[0]), isTrue);
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist in traversal', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      final result = s.postorderTraversal(root)..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Postorder must visit children before root', () {
      final root = buildTree([1, 2, 3]);
      final result = s.postorderTraversal(root);
      expect(result.last, equals(1));
    });

    test(
        'Postorder must fully visit left subtree, then right subtree, then root',
        () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.postorderTraversal(root), equals([4, 5, 2, 6, 7, 3, 1]));
    });
  });
}
