// leetcode/701.insert_into_a_binary_search_tree.dart
// https://leetcode.com/problems/insert-into-a-binary-search-tree/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.insertIntoBST(buildTree([4, 2, 7, 1, 3]), 5);

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
  /// Insert In BST
  TreeNode? insertIntoBST(TreeNode? root, int val) {
    return dfs(root, val);
  }

  TreeNode? dfs(TreeNode? node, int val) {
    /// Base Case
    if (node == null) return TreeNode(val);

    /// Recursive Case
    if (val > node.val) {
      node.right = dfs(node.right, val);
    } else {
      node.left = dfs(node.left, val);
    }

    return node;
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

List<int> inorderTraversal(TreeNode? root) {
  final result = <int>[];

  void dfs(TreeNode? node) {
    if (node == null) return;
    dfs(node.left);
    result.add(node.val);
    dfs(node.right);
  }

  dfs(root);
  return result;
}

bool containsValue(TreeNode? root, int target) {
  TreeNode? current = root;

  while (current != null) {
    if (current.val == target) return true;
    current = target < current.val ? current.left : current.right;
  }

  return false;
}

bool isValidBST(TreeNode? root, [int? min, int? max]) {
  if (root == null) return true;
  if (min != null && root.val <= min) return false;
  if (max != null && root.val >= max) return false;

  return isValidBST(root.left, min, root.val) &&
      isValidBST(root.right, root.val, max);
}

int countNodes(TreeNode? root) {
  if (root == null) return 0;
  return 1 + countNodes(root.left) + countNodes(root.right);
}

void runTests() {
  final Solution s = Solution();

  group('Insert into a Binary Search Tree', () {
    // ===== Examples =====
    test('Example 1: [4,2,7,1,3], val=5', () {
      final root = buildTree([4, 2, 7, 1, 3]);
      final result = s.insertIntoBST(root, 5);

      expect(treeToList(result), equals([4, 2, 7, 1, 3, 5]));
      expect(isValidBST(result), isTrue);
    });

    test('Example 2: [40,20,60,10,30,50,70], val=25', () {
      final root = buildTree([40, 20, 60, 10, 30, 50, 70]);
      final result = s.insertIntoBST(root, 25);

      expect(treeToList(result),
          equals([40, 20, 60, 10, 30, 50, 70, null, null, 25]));
      expect(isValidBST(result), isTrue);
    });

    test('Example 3: [4,2,7,1,3], val=5', () {
      final root =
          buildTree([4, 2, 7, 1, 3, null, null, null, null, null, null]);
      final result = s.insertIntoBST(root, 5);

      expect(treeToList(result), equals([4, 2, 7, 1, 3, 5]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Edge Cases =====
    test('Empty tree -> new root', () {
      final root = buildTree([]);
      final result = s.insertIntoBST(root, 10);

      expect(treeToList(result), equals([10]));
      expect(isValidBST(result), isTrue);
    });

    test('Single node insert smaller', () {
      final root = buildTree([10]);
      final result = s.insertIntoBST(root, 5);

      expect(treeToList(result), equals([10, 5]));
      expect(isValidBST(result), isTrue);
    });

    test('Single node insert larger', () {
      final root = buildTree([10]);
      final result = s.insertIntoBST(root, 15);

      expect(treeToList(result), equals([10, null, 15]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Small Trees =====
    test('Insert into left subtree', () {
      final root = buildTree([10, 5, 15]);
      final result = s.insertIntoBST(root, 3);

      expect(treeToList(result), equals([10, 5, 15, 3]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert into right subtree', () {
      final root = buildTree([10, 5, 15]);
      final result = s.insertIntoBST(root, 20);

      expect(treeToList(result), equals([10, 5, 15, null, null, null, 20]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert as left child of right subtree', () {
      final root = buildTree([10, 5, 15]);
      final result = s.insertIntoBST(root, 12);

      expect(treeToList(result), equals([10, 5, 15, null, null, 12]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert as right child of left subtree', () {
      final root = buildTree([10, 5, 15]);
      final result = s.insertIntoBST(root, 7);

      expect(treeToList(result), equals([10, 5, 15, null, 7]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Skewed Trees =====
    test('Insert into right-skewed BST at end', () {
      final root = buildTree([1, null, 2, null, 3, null, 4]);
      final result = s.insertIntoBST(root, 5);

      expect(
          treeToList(result), equals([1, null, 2, null, 3, null, 4, null, 5]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert into left-skewed BST at end', () {
      final root = buildTree([5, 4, null, 3, null, 2, null, 1]);
      final result = s.insertIntoBST(root, 0);

      expect(treeToList(result),
          equals([5, 4, null, 3, null, 2, null, 1, null, 0]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert into middle of skewed BST', () {
      final root = buildTree([5, 4, null, 3, null, 2]);
      final result = s.insertIntoBST(root, 1);

      expect(treeToList(result), equals([5, 4, null, 3, null, 2, null, 1]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Negative / Boundary Values =====
    test('Insert negative value', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      final result = s.insertIntoBST(root, -7);

      expect(treeToList(result),
          equals([0, -10, 10, -20, -5, 5, 20, null, null, -7]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert minimum-like value', () {
      final root = buildTree([0, -100, 100]);
      final result = s.insertIntoBST(root, -100000000);

      expect(containsValue(result, -100000000), isTrue);
      expect(isValidBST(result), isTrue);
    });

    test('Insert maximum-like value', () {
      final root = buildTree([0, -100, 100]);
      final result = s.insertIntoBST(root, 100000000);

      expect(containsValue(result, 100000000), isTrue);
      expect(isValidBST(result), isTrue);
    });

    // ===== Larger Valid BSTs =====
    test('Insert into deeper left-right branch', () {
      final root = buildTree([8, 3, 10, 1, 6, null, 14, null, null, 4, 7, 13]);
      final result = s.insertIntoBST(root, 5);

      expect(
          treeToList(result),
          equals(
              [8, 3, 10, 1, 6, null, 14, null, null, 4, 7, 13, null, null, 5]));
      expect(isValidBST(result), isTrue);
    });

    test('Insert into balanced BST', () {
      final root = buildTree([50, 30, 70, 20, 40, 60, 80]);
      final result = s.insertIntoBST(root, 65);

      expect(
          treeToList(result),
          equals(
              [50, 30, 70, 20, 40, 60, 80, null, null, null, null, null, 65]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Inorder Checks =====
    test('Inorder should remain sorted after insertion', () {
      final root = buildTree([4, 2, 7, 1, 3]);
      final result = s.insertIntoBST(root, 5);

      expect(inorderTraversal(result), equals([1, 2, 3, 4, 5, 7]));
      expect(isValidBST(result), isTrue);
    });

    test('Inorder sorted with negative insertion', () {
      final root = buildTree([0, -10, 10, -20, -5, 5, 20]);
      final result = s.insertIntoBST(root, -7);

      expect(
          inorderTraversal(result), equals([-20, -10, -7, -5, 0, 5, 10, 20]));
      expect(isValidBST(result), isTrue);
    });

    // ===== Duplicate Safety via Count/Containment =====
    test('Node count should increase by 1', () {
      final root = buildTree([4, 2, 7, 1, 3]);
      final before = countNodes(root);
      final result = s.insertIntoBST(root, 5);
      final after = countNodes(result);

      expect(after, equals(before + 1));
      expect(containsValue(result, 5), isTrue);
    });

    test('Inserted value must exist exactly as searchable target', () {
      final root = buildTree([40, 20, 60, 10, 30, 50, 70]);
      final result = s.insertIntoBST(root, 25);

      expect(containsValue(result, 25), isTrue);
      expect(isValidBST(result), isTrue);
    });

    // ===== Larger Cases =====
    test('Complete-ish BST with many nodes insert new leaf', () {
      final root =
          buildTree([16, 8, 24, 4, 12, 20, 28, 2, 6, 10, 14, 18, 22, 26, 30]);
      final result = s.insertIntoBST(root, 27);

      expect(containsValue(result, 27), isTrue);
      expect(isValidBST(result), isTrue);
      expect(inorderTraversal(result),
          equals([2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 27, 28, 30]));
    });

    test('Large right-heavy insertion keeps BST valid', () {
      TreeNode? root;
      for (int i = 1; i <= 50; i++) {
        root = s.insertIntoBST(root, i);
      }

      expect(isValidBST(root), isTrue);
      expect(inorderTraversal(root), equals(List.generate(50, (i) => i + 1)));
    });

    test('Large left-heavy insertion keeps BST valid', () {
      TreeNode? root;
      for (int i = 50; i >= 1; i--) {
        root = s.insertIntoBST(root, i);
      }

      expect(isValidBST(root), isTrue);
      expect(inorderTraversal(root), equals(List.generate(50, (i) => i + 1)));
    });

    // ===== Stability =====
    test('Root value should remain unchanged after insertion', () {
      final root = buildTree([10, 5, 15]);
      final result = s.insertIntoBST(root, 12);

      expect(result?.val, equals(10));
      expect(isValidBST(result), isTrue);
    });

    test('All original values should still exist after insertion', () {
      final originalValues = [8, 3, 10, 1, 6, 14, 4, 7, 13];
      final root = buildTree([8, 3, 10, 1, 6, null, 14, null, null, 4, 7, 13]);
      final result = s.insertIntoBST(root, 5);

      final inorder = inorderTraversal(result);
      for (final value in originalValues) {
        expect(inorder.contains(value), isTrue);
      }
      expect(inorder.contains(5), isTrue);
      expect(isValidBST(result), isTrue);
    });
  });
}
