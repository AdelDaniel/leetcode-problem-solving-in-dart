// leetcode/114.flatten_binary_tree_to_linked_list.dart
// https://leetcode.com/problems/flatten-binary-tree-to-linked-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  final root = buildTree([1, 2, 5, 3, 4, null, 6]);
  s.flatten(root);

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
  /// Solved
  /// TC: O(N)
  /// SC: O(N)
  void flatten(TreeNode? root) {
    if (root == null) return;
    final stack = [root];
    TreeNode? currentNode;

    while (stack.isNotEmpty) {
      currentNode = stack.removeLast();
      if (currentNode.right != null) stack.add(currentNode.right!);
      if (currentNode.left != null) stack.add(currentNode.left!);

      currentNode.left = null;
      if (stack.isNotEmpty) {
        currentNode.right = stack.last;
      }
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

List<int> flattenedRightChain(TreeNode? root) {
  final result = <int>[];
  TreeNode? current = root;

  while (current != null) {
    result.add(current.val);
    current = current.right;
  }

  return result;
}

bool allLeftPointersAreNull(TreeNode? root) {
  TreeNode? current = root;

  while (current != null) {
    if (current.left != null) return false;
    current = current.right;
  }

  return true;
}

void runTests() {
  final Solution s = Solution();

  group('Flatten Binary Tree to Linked List', () {
    // ===== Examples =====
    test('Example 1: [1,2,5,3,4,null,6] -> [1,2,3,4,5,6]', () {
      final root = buildTree([1, 2, 5, 3, 4, null, 6]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 3, 4, 5, 6]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Example 2: [] -> []', () {
      final root = buildTree([]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Example 3: [0] -> [0]', () {
      final root = buildTree([0]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([0]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Single negative node', () {
      final root = buildTree([-5]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([-5]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Single node 100', () {
      final root = buildTree([100]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([100]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Small Trees =====
    test('Root with only left child', () {
      final root = buildTree([1, 2]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Root with only right child', () {
      final root = buildTree([1, null, 3]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 3]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Root with two children', () {
      final root = buildTree([1, 2, 3]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 3]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Three levels full tree', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 4, 5, 3, 6, 7]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 3, 4, 5]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Right-skewed tree already flattened', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 3, 4, 5]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Sparse Trees =====
    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 5, null, 7]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 5, 3, 7]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      s.flatten(root);

      expect(
        flattenedRightChain(root),
        equals([10, 6, 3, 4, 8, 7, 9, 15, 20]),
      );
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      s.flatten(root);

      expect(
        flattenedRightChain(root),
        equals([-1, -2, -4, -5, -3, -6, -7]),
      );
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      s.flatten(root);

      expect(
        flattenedRightChain(root),
        equals([0, -10, -20, -5, 10, 5, 20]),
      );
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      s.flatten(root);

      expect(
        flattenedRightChain(root),
        equals([0, -100, -100, 100, 100]),
      );
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([5, 5, 5, 5, 5, 5, 5]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 3, 3, 2, 3, 3]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 0, 1, 1, 0, 1, 1]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 4, 6, 3, 5, 7]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      s.flatten(root);

      expect(
        flattenedRightChain(root),
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
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Large right-skewed tree size 100', () {
      final values = <int?>[1];
      for (int i = 2; i <= 100; i++) {
        values.add(null);
        values.add(i);
      }
      final root = buildTree(values);
      s.flatten(root);

      final result = flattenedRightChain(root);
      expect(result.length, equals(100));
      expect(result.first, equals(1));
      expect(result.last, equals(100));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Constraint-style tree with 2000 nodes', () {
      final values = List<int?>.generate(2000, (i) => (i % 201) - 100);
      final root = buildTree(values);
      s.flatten(root);

      final result = flattenedRightChain(root);
      expect(result.length, equals(2000));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    // ===== Stability / Structure Checks =====
    test('All values should still exist after flattening', () {
      final values = [7, 3, 9, 1, 5, 8, 10];
      final root = buildTree(values);
      s.flatten(root);

      final result = flattenedRightChain(root)..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Flattened tree should follow preorder order', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      s.flatten(root);

      expect(flattenedRightChain(root), equals([1, 2, 4, 5, 3, 6, 7]));
      expect(allLeftPointersAreNull(root), isTrue);
    });

    test('Flattened tree should have no left pointers anywhere', () {
      final root = buildTree([1, 2, 5, 3, 4, null, 6]);
      s.flatten(root);

      expect(allLeftPointersAreNull(root), isTrue);
    });
  });
}
