// leetcode/98.validate_binary_search_tree.dart
// https://leetcode.com/problems/validate-binary-search-tree/
import 'package:test/test.dart';

/// For every node, you do not just compare it with its direct parent.
/// You keep an **allowed range**:

/// * `low` = the smallest value this node is allowed to have
/// * `high` = the largest value this node is allowed to have

/// Then:

/// * when you go **left**, the node must be **smaller than the parent**

///   * `low` stays the same
///   * `high = parent.val`

/// * when you go **right**, the node must be **greater than the parent**

///   * `low = parent.val`
///   * `high` stays the same

/// So that means:

/// ```text
/// Moving left:
/// allowed range = (parent.low, parent.val)

/// Moving right:
/// allowed range = (parent.val, parent.high)
/// ```

/// Example:

/// ```text
///         8
///        / \
///       5   10
///      / \
///     1   7
/// ```

/// At root `8`:

/// * allowed range = `(-∞, +∞)`

/// Go left to `5`:

/// * allowed range = `(-∞, 8)`

/// Go left again to `1`:

/// * allowed range = `(-∞, 5)`

/// Go right from `5` to `7`:

/// * allowed range = `(5, 8)`

/// That is the key idea:
/// the child does not only inherit the parent’s value, it also inherits the parent’s whole valid range.

/// This is why this invalid BST is caught:

/// ```text
///         5
///        / \
///       4   6
///          / \
///         3   7
/// ```

/// Node `3` is in the **right subtree of 5**, so it must be greater than `5`.
/// But when you go right from `5`, the range becomes `(5, +∞)`.
/// Then when you go left from `6`, the range becomes `(5, 6)`.
/// So `3` is invalid because `3` is not inside `(5, 6)`.

/// So the basically teaching:

/// **Left child narrows the upper bound. Right child narrows the lower bound.**

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();

  /// This is important
  s.isValidBST(buildTree([5, 4, 6, null, null, 3, 7]));
  // s.isValidBST(buildTree([2, 1, 3]));
  // s.isValidBST(buildTree([-5]));

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
  bool isValidBST(TreeNode? root) {
    return dfs(root, null, null);
  }

  /// SC and TC are: O(N)
  bool dfs(TreeNode? root, int? low, int? high) {
    if (root == null) return true;
    final currentValue = root.val;
    if (low != null && currentValue <= low) {
      return false;
    } else if (high != null && currentValue >= high) {
      return false;
    }

    return dfs(root.left, low, currentValue) &&
        dfs(root.right, currentValue, high);
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

  group('Validate Binary Search Tree', () {
    // ===== Examples =====
    test('Example 1: [2,1,3] -> true', () {
      final root = buildTree([2, 1, 3]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Example 2: [5,1,4,null,null,3,6] -> false', () {
      final root = buildTree([5, 1, 4, null, null, 3, 6]);
      expect(s.isValidBST(root), isFalse);
    });

    // ===== Edge Cases =====
    test('Empty tree -> true', () {
      final root = buildTree([]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Null root using [null] -> true', () {
      final root = buildTree([null]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Single node -> true', () {
      final root = buildTree([1]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Single negative node -> true', () {
      final root = buildTree([-5]);
      expect(s.isValidBST(root), isTrue);
    });

    // ===== Small Valid Trees =====
    test('Two nodes valid left child', () {
      final root = buildTree([2, 1]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Two nodes valid right child', () {
      final root = buildTree([2, null, 3]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Three nodes valid BST', () {
      final root = buildTree([10, 5, 15]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Perfect BST height 3', () {
      final root = buildTree([4, 2, 6, 1, 3, 5, 7]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Larger balanced valid BST', () {
      final root = buildTree([8, 3, 10, 1, 6, null, 14, null, null, 4, 7, 13]);
      expect(s.isValidBST(root), isTrue);
    });

    // ===== Direct Invalid Cases =====
    test('Immediate left child greater than root -> false', () {
      final root = buildTree([2, 3, 4]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Immediate right child smaller than root -> false', () {
      final root = buildTree([5, 1, 4]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Duplicate on left -> false', () {
      final root = buildTree([2, 2, 3]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Duplicate on right -> false', () {
      final root = buildTree([2, 1, 2]);
      expect(s.isValidBST(root), isFalse);
    });

    test('All duplicate values -> false', () {
      final root = buildTree([5, 5, 5]);
      expect(s.isValidBST(root), isFalse);
    });

    // ===== Deep Subtree Violations =====
    test('Right subtree contains value smaller than root -> false', () {
      final root = buildTree([10, 5, 15, null, null, 6, 20]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Left subtree contains value greater than root -> false', () {
      final root = buildTree([10, 5, 15, 2, 12]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Classic deep violation [5,4,6,null,null,3,7] -> false', () {
      final root = buildTree([5, 4, 6, null, null, 3, 7]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Violation deep in left-right branch -> false', () {
      final root = buildTree([20, 10, 30, 5, 25]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Violation deep in right-left branch -> false', () {
      final root = buildTree([20, 10, 30, null, null, 15, 40]);
      expect(s.isValidBST(root), isFalse);
    });

    // ===== Skewed Trees =====
    test('Left-skewed decreasing tree -> true', () {
      final root = buildTree([5, 4, null, 3, null, 2, null, 1]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Right-skewed increasing tree -> true', () {
      final root = buildTree([1, null, 2, null, 3, null, 4, null, 5]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Left-skewed but invalid order -> false', () {
      final root = buildTree([5, 6, null, 4]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Right-skewed but invalid order -> false', () {
      final root = buildTree([1, null, 0]);
      expect(s.isValidBST(root), isFalse);
    });

    // ===== Negative / Mixed Values =====
    test('Valid BST with negative values', () {
      final root = buildTree([0, -3, 9, -10, null, 5]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Invalid BST with negative values', () {
      final root = buildTree([0, -3, 9, -10, null, -1, 12]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Mixed negative and positive valid', () {
      final root = buildTree([3, -2, 8, -5, 0, 6, 10]);
      expect(s.isValidBST(root), isTrue);
    });

    // ===== Boundary-Style Cases =====
    test('Large magnitude valid BST', () {
      final root = buildTree([0, -2147483648, 2147483647]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Large magnitude invalid due duplicate boundary -> false', () {
      final root = buildTree([2147483647, 2147483647]);
      expect(s.isValidBST(root), isFalse);
    });

    // ===== Sparse Trees =====
    test('Sparse valid BST', () {
      final root = buildTree([10, 5, 15, null, null, 12, 20]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Sparse invalid BST', () {
      final root = buildTree([10, 5, 15, null, null, 6, 20]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Another sparse valid BST', () {
      final root = buildTree([7, 3, 9, 2, 5, 8, 10, null, null, 4, 6]);
      expect(s.isValidBST(root), isTrue);
    });

    // ===== Larger Cases =====
    test('Complete valid BST with 15 nodes', () {
      final root =
          buildTree([8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Complete tree with one wrong value deep inside -> false', () {
      final root =
          buildTree([8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 9, 9, 11, 13, 15]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Large right chain valid', () {
      final values = <int?>[1];
      for (int i = 2; i <= 100; i++) {
        values.add(null);
        values.add(i);
      }
      final root = buildTree(values);
      expect(s.isValidBST(root), isTrue);
    });

    test('Large left chain valid', () {
      final values = <int?>[100];
      for (int i = 99; i >= 1; i--) {
        values.add(i);
        values.add(null);
      }
      final root = buildTree(values);
      expect(s.isValidBST(root), isTrue);
    });

    // ===== Stability / Logic Traps =====
    test('Local checks pass but global BST rule fails -> false', () {
      final root = buildTree([32, 26, 47, 19, null, null, 56, null, 27]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Valid tree with null gaps should still pass', () {
      final root = buildTree([50, 30, 70, 20, 40, 60, 80, null, null, 35, 45]);
      expect(s.isValidBST(root), isTrue);
    });

    test('Node equal to ancestor on right subtree -> false', () {
      final root = buildTree([10, 5, 15, null, null, 10, 20]);
      expect(s.isValidBST(root), isFalse);
    });

    test('Node equal to ancestor on left subtree -> false', () {
      final root = buildTree([10, 5, 15, 2, 10]);
      expect(s.isValidBST(root), isFalse);
    });

    /// Leet Code Example
    test('Example: [5,4,6,null,null,3,7] -> false', () {
      final root = buildTree([5, 4, 6, null, null, 3, 7]);
      expect(s.isValidBST(root), isFalse);
    });
  });
}
