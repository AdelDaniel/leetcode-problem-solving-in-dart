// leetcode/100.same_tree.dart
// https://leetcode.com/problems/same-tree/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.isSameTree(buildTree([1, 2, 3]), buildTree([1, 2, 3]));

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
  bool isSameTree(TreeNode? p, TreeNode? q) {
    if (p == null && q == null) return true;
    if (p == null && q != null) return false;
    if (p != null && q == null) return false;

    final List<TreeNode> pStack = [p!];
    final List<TreeNode> qStack = [q!];

    while (pStack.isNotEmpty && qStack.isNotEmpty) {
      TreeNode currentP = pStack.removeLast();
      TreeNode currentQ = qStack.removeLast();

      if (currentP.val != currentQ.val) return false;
      if (currentP.left != null && currentQ.left == null) return false;
      if (currentP.left == null && currentQ.left != null) return false;
      if (currentP.right != null && currentQ.right == null) return false;
      if (currentP.right == null && currentQ.right != null) return false;

      if (currentP.left != null) pStack.add(currentP.left!);
      if (currentP.right != null) pStack.add(currentP.right!);
      if (currentQ.left != null) qStack.add(currentQ.left!);
      if (currentQ.right != null) qStack.add(currentQ.right!);
    }
    if (pStack.isEmpty && qStack.isEmpty) return true;
    return false;
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

  group('Same Tree', () {
    // ===== Examples =====
    test('Example 1: [1,2,3] vs [1,2,3] -> true', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([1, 2, 3]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Example 2: [1,2] vs [1,null,2] -> false', () {
      final p = buildTree([1, 2]);
      final q = buildTree([1, null, 2]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Example 3: [1,2,1] vs [1,1,2] -> false', () {
      final p = buildTree([1, 2, 1]);
      final q = buildTree([1, 1, 2]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Edge Cases =====
    test('Both trees empty -> true', () {
      final p = buildTree([]);
      final q = buildTree([]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Both trees [null] -> true', () {
      final p = buildTree([null]);
      final q = buildTree([null]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('One empty, one non-empty -> false', () {
      final p = buildTree([]);
      final q = buildTree([1]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('One null-root, one non-empty -> false', () {
      final p = buildTree([null]);
      final q = buildTree([1]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Single node equal -> true', () {
      final p = buildTree([5]);
      final q = buildTree([5]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Single node different -> false', () {
      final p = buildTree([5]);
      final q = buildTree([6]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Small Trees =====
    test('Same two-node left child trees -> true', () {
      final p = buildTree([1, 2]);
      final q = buildTree([1, 2]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Same two-node right child trees -> true', () {
      final p = buildTree([1, null, 3]);
      final q = buildTree([1, null, 3]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Different structure with same values -> false', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([1, 2, null, 3]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Different value at root -> false', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([9, 2, 3]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Different value at left child -> false', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([1, 9, 3]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Different value at right child -> false', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([1, 2, 9]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Balanced Trees =====
    test('Perfect binary trees same -> true', () {
      final p = buildTree([1, 2, 3, 4, 5, 6, 7]);
      final q = buildTree([1, 2, 3, 4, 5, 6, 7]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Perfect binary trees one leaf different -> false', () {
      final p = buildTree([1, 2, 3, 4, 5, 6, 7]);
      final q = buildTree([1, 2, 3, 4, 5, 6, 8]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Perfect binary trees one missing leaf -> false', () {
      final p = buildTree([1, 2, 3, 4, 5, 6, 7]);
      final q = buildTree([1, 2, 3, 4, 5, 6, null]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Skewed Trees =====
    test('Same left-skewed trees -> true', () {
      final p = buildTree([1, 2, null, 3, null, 4]);
      final q = buildTree([1, 2, null, 3, null, 4]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Left-skewed vs right-skewed -> false', () {
      final p = buildTree([1, 2, null, 3, null, 4]);
      final q = buildTree([1, null, 2, null, 3, null, 4]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Same right-skewed trees -> true', () {
      final p = buildTree([1, null, 2, null, 3, null, 4]);
      final q = buildTree([1, null, 2, null, 3, null, 4]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Right-skewed trees one value different -> false', () {
      final p = buildTree([1, null, 2, null, 3, null, 4]);
      final q = buildTree([1, null, 2, null, 3, null, 9]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Sparse Trees =====
    test('Sparse identical trees -> true', () {
      final p = buildTree([1, 2, 3, null, 5, null, 7]);
      final q = buildTree([1, 2, 3, null, 5, null, 7]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Sparse trees structural mismatch -> false', () {
      final p = buildTree([1, 2, 3, null, 5, null, 7]);
      final q = buildTree([1, 2, 3, 5, null, null, 7]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Sparse trees value mismatch -> false', () {
      final p = buildTree([1, 2, 3, null, 5, null, 7]);
      final q = buildTree([1, 2, 3, null, 9, null, 7]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Negative / Boundary Values =====
    test('Negative values same -> true', () {
      final p = buildTree([-1, -2, -3, -4, -5]);
      final q = buildTree([-1, -2, -3, -4, -5]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Negative values different -> false', () {
      final p = buildTree([-1, -2, -3, -4, -5]);
      final q = buildTree([-1, -2, -3, -4, -9]);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Min and max constraints same -> true', () {
      final p = buildTree([0, -10000, 10000]);
      final q = buildTree([0, -10000, 10000]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Min and max constraints different -> false', () {
      final p = buildTree([0, -10000, 10000]);
      final q = buildTree([0, -10000, 9999]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Duplicate Values =====
    test('All duplicate values same -> true', () {
      final p = buildTree([5, 5, 5, 5, 5, 5, 5]);
      final q = buildTree([5, 5, 5, 5, 5, 5, 5]);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('All duplicate values but structure different -> false', () {
      final p = buildTree([5, 5, 5, 5, 5, 5, 5]);
      final q = buildTree([5, 5, 5, 5, null, 5, 5]);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Larger Cases =====
    test('Complete tree with 31 nodes same -> true', () {
      final values = List<int?>.generate(31, (i) => i + 1);
      final p = buildTree(values);
      final q = buildTree(values);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Complete tree with 31 nodes one value changed -> false', () {
      final pValues = List<int?>.generate(31, (i) => i + 1);
      final qValues = List<int?>.generate(31, (i) => i + 1);
      qValues[30] = 999;

      final p = buildTree(pValues);
      final q = buildTree(qValues);
      expect(s.isSameTree(p, q), isFalse);
    });

    test('Large skewed trees size 100 same -> true', () {
      final pValues = <int?>[1];
      final qValues = <int?>[1];
      for (int i = 2; i <= 100; i++) {
        pValues.add(null);
        pValues.add(i);

        qValues.add(null);
        qValues.add(i);
      }

      final p = buildTree(pValues);
      final q = buildTree(qValues);
      expect(s.isSameTree(p, q), isTrue);
    });

    test('Large skewed trees size 100 one value different -> false', () {
      final pValues = <int?>[1];
      final qValues = <int?>[1];
      for (int i = 2; i <= 100; i++) {
        pValues.add(null);
        pValues.add(i);

        qValues.add(null);
        qValues.add(i);
      }
      qValues[qValues.length - 1] = 9999;

      final p = buildTree(pValues);
      final q = buildTree(qValues);
      expect(s.isSameTree(p, q), isFalse);
    });

    // ===== Stability =====
    test('Tree compared with itself should be true', () {
      final p = buildTree([1, 2, 3, 4, 5]);
      expect(s.isSameTree(p, p), isTrue);
    });

    test('Symmetry of comparison: isSameTree(p, q) == isSameTree(q, p)', () {
      final p = buildTree([1, 2, 3, 4, 5]);
      final q = buildTree([1, 2, 3, 4, 5]);

      expect(s.isSameTree(p, q), equals(s.isSameTree(q, p)));
    });

    test('Different node counts should be false', () {
      final p = buildTree([1, 2, 3]);
      final q = buildTree([1, 2, 3, 4]);
      expect(s.isSameTree(p, q), isFalse);
    });
  });
}
