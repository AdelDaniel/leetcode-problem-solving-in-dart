// leetcode/226.invert_binary_tree.dart
// https://leetcode.com/problems/invert-binary-tree/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.invertTree(buildTree([4, 2, 7, 1, 3, 6, 9]));

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
  TreeNode? invertTree(TreeNode? root) {
    return dfs(root);
  }

  TreeNode? dfs(TreeNode? root) {
    if (root == null) return null;
    dfs(root.right);
    dfs(root.left);
    final temp = root.right;
    root.right = root.left;
    root.left = temp;

    return root;
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

List<int?> treeToList(TreeNode? root) {
  if (root == null) return [];

  final result = <int?>[];
  final queue = <TreeNode?>[root];

  while (queue.isNotEmpty) {
    final node = queue.removeAt(0);

    if (node == null) {
      result.add(null);
      continue;
    }

    result.add(node.val);
    queue.add(node.left);
    queue.add(node.right);
  }

  while (result.isNotEmpty && result.last == null) {
    result.removeLast();
  }

  return result;
}

void runTests() {
  final Solution s = Solution();

  group('Invert Binary Tree', () {
    // ===== Examples =====
    test('Example 1: [4,2,7,1,3,6,9] -> [4,7,2,9,6,3,1]', () {
      final root = buildTree([4, 2, 7, 1, 3, 6, 9]);
      expect(treeToList(s.invertTree(root)), equals([4, 7, 2, 9, 6, 3, 1]));
    });

    test('Example 2: [2,1,3] -> [2,3,1]', () {
      final root = buildTree([2, 1, 3]);
      expect(treeToList(s.invertTree(root)), equals([2, 3, 1]));
    });

    test('Example 3: [] -> []', () {
      final root = buildTree([]);
      expect(treeToList(s.invertTree(root)), equals([]));
    });

    // ===== Edge Cases =====
    test('Null root using [null] -> []', () {
      final root = buildTree([null]);
      expect(treeToList(s.invertTree(root)), equals([]));
    });

    test('Single node', () {
      final root = buildTree([1]);
      expect(treeToList(s.invertTree(root)), equals([1]));
    });

    test('Single negative node', () {
      final root = buildTree([-5]);
      expect(treeToList(s.invertTree(root)), equals([-5]));
    });

    test('Single zero node', () {
      final root = buildTree([0]);
      expect(treeToList(s.invertTree(root)), equals([0]));
    });

    // ===== Small Trees =====
    test('Root with only left child -> becomes right child', () {
      final root = buildTree([1, 2]);
      expect(treeToList(s.invertTree(root)), equals([1, null, 2]));
    });

    test('Root with only right child -> becomes left child', () {
      final root = buildTree([1, null, 3]);
      expect(treeToList(s.invertTree(root)), equals([1, 3]));
    });

    test('Three nodes full tree', () {
      final root = buildTree([1, 2, 3]);
      expect(treeToList(s.invertTree(root)), equals([1, 3, 2]));
    });

    test('Four nodes left-heavy', () {
      final root = buildTree([1, 2, null, 3]);
      expect(treeToList(s.invertTree(root)), equals([1, null, 2, null, 3]));
    });

    test('Four nodes right-heavy', () {
      final root = buildTree([1, null, 2, null, 3]);
      expect(treeToList(s.invertTree(root)), equals([1, 2, null, 3]));
    });

    // ===== Balanced Trees =====
    test('Perfect binary tree height 3', () {
      final root = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(treeToList(s.invertTree(root)), equals([1, 3, 2, 7, 6, 5, 4]));
    });

    test('Perfect binary tree height 4', () {
      final root =
          buildTree([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
      expect(
        treeToList(s.invertTree(root)),
        equals([1, 3, 2, 7, 6, 5, 4, 15, 14, 13, 12, 11, 10, 9, 8]),
      );
    });

    // ===== Skewed Trees =====
    test('Left-skewed tree becomes right-skewed', () {
      final root = buildTree([1, 2, null, 3, null, 4, null, 5]);
      expect(treeToList(s.invertTree(root)),
          equals([1, null, 2, null, 3, null, 4, null, 5]));
    });

    test('Right-skewed tree becomes left-skewed', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(treeToList(s.invertTree(root)),
          equals([1, 2, null, 3, null, 4, null, 5]));
    });

    // ===== Sparse Trees =====
    test('Sparse tree with gaps', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null]);
      expect(treeToList(s.invertTree(root)), equals([1, 3, 2, null, 5, 4]));
    });

    test('Uneven sparse tree', () {
      final root = buildTree([10, 6, 15, 3, 8, null, 20, null, 4, 7, 9]);
      expect(
        treeToList(s.invertTree(root)),
        equals([10, 15, 6, 20, null, 8, 3, null, null, 9, 7, 4]),
      );
    });

    test('Mixed null positions', () {
      final root = buildTree([5, 1, 2, 3, null, 6, 4]);
      expect(treeToList(s.invertTree(root)), equals([5, 2, 1, 4, 6, null, 3]));
    });

    // ===== Negative / Boundary Values =====
    test('All negative values', () {
      final root = buildTree([-1, -2, -3, -4, -5, -6, -7]);
      expect(
          treeToList(s.invertTree(root)), equals([-1, -3, -2, -7, -6, -5, -4]));
    });

    test('Mixed negative and positive values', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      expect(
          treeToList(s.invertTree(root)), equals([0, 10, -10, 20, 5, -5, -20]));
    });

    test('Min and max constraint values', () {
      final root = buildTree([0, -100, 100, -100, null, null, 100]);
      expect(treeToList(s.invertTree(root)),
          equals([0, 100, -100, 100, null, null, -100]));
    });

    // ===== Duplicate Values =====
    test('All duplicate values', () {
      final root = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(treeToList(s.invertTree(root)), equals([5, 5, 5, 5, 5, 5, 5]));
    });

    test('Mixed duplicates', () {
      final root = buildTree([1, 2, 2, 3, 3, 3, 3]);
      expect(treeToList(s.invertTree(root)), equals([1, 2, 2, 3, 3, 3, 3]));
    });

    // ===== Patterned Trees =====
    test('Alternating values by level', () {
      final root = buildTree([1, 0, 0, 1, 1, 1, 1]);
      expect(treeToList(s.invertTree(root)), equals([1, 0, 0, 1, 1, 1, 1]));
    });

    test('Zig-zag shaped sparse tree', () {
      final root = buildTree([1, 2, 3, null, 4, 5, null, 6, null, null, 7]);
      expect(treeToList(s.invertTree(root)),
          equals([1, 3, 2, null, 5, 4, null, 7, null, null, 6]));
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final root = buildTree(values);
      expect(
        treeToList(s.invertTree(root)),
        equals([
          1,
          3,
          2,
          7,
          6,
          5,
          4,
          15,
          14,
          13,
          12,
          11,
          10,
          9,
          8,
          31,
          30,
          29,
          28,
          27,
          26,
          25,
          24,
          23,
          22,
          21,
          20,
          19,
          18,
          17,
          16
        ]),
      );
    });

    // ===== Stability / Structure Checks =====
    test('Double inversion should restore original tree', () {
      final values = [4, 2, 7, 1, 3, 6, 9];
      final root = buildTree(values);

      final once = s.invertTree(root);
      final twice = s.invertTree(once);

      expect(treeToList(twice), equals(values));
    });

    test('All original values should still exist after inversion', () {
      final values = [4, 2, 7, 1, 3, 6, 9];
      final root = buildTree(values);
      final result = treeToList(s.invertTree(root))
        ..sort((a, b) => (a ?? 0).compareTo(b ?? 0));
      final expected = [...values]..sort();

      expect(result.whereType<int>().toList(), equals(expected));
    });
  });
}
