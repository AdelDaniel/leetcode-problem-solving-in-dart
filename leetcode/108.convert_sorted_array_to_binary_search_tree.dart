// leetcode/108.convert_sorted_array_to_binary_search_tree.dart
// https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/
import 'dart:math' as math;
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  // s.sortedArrayToBST([-10, -3, 0, 5, 9]);
  s.sortedArrayToBST([0, 1, 2, 3, 4, 5]);

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
  /// TC: O(N) SC:(N)
  TreeNode? sortedArrayToBST(List<int> nums) {
    return bs(nums, 0, nums.length - 1);
  }

  /// better solution without generating sub-lists
  TreeNode? bs(List<int> nums, int low, int high) {
    if (low > high) return null;

    final int mid = low + (high - low) ~/ 2;
    final node = TreeNode(nums[mid]);
    node.left = bs(nums, low, mid - 1);
    node.right = bs(nums, mid + 1, high);

    return node;
  }

  /// TC: O(N) SC:(N)
  // TreeNode? sortedArrayToBST(List<int> nums) {
  //   if (nums.isEmpty) return null;

  //   final int centerIndex = nums.length ~/ 2;
  //   final root = TreeNode(nums[centerIndex]);
  //   root.left = sortedArrayToBST(nums.sublist(0, centerIndex));
  //   root.right = sortedArrayToBST(nums.sublist(centerIndex + 1));

  //   return root;
  // }
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

bool isValidBST(TreeNode? root, [int? min, int? max]) {
  if (root == null) return true;
  if (min != null && root.val <= min) return false;
  if (max != null && root.val >= max) return false;

  return isValidBST(root.left, min, root.val) &&
      isValidBST(root.right, root.val, max);
}

int height(TreeNode? root) {
  if (root == null) return 0;
  return 1 + math.max(height(root.left), height(root.right));
}

bool isBalanced(TreeNode? root) {
  int check(TreeNode? node) {
    if (node == null) return 0;

    final left = check(node.left);
    if (left == -1) return -1;

    final right = check(node.right);
    if (right == -1) return -1;

    if ((left - right).abs() > 1) return -1;
    return 1 + math.max(left, right);
  }

  return check(root) != -1;
}

int countNodes(TreeNode? root) {
  if (root == null) return 0;
  return 1 + countNodes(root.left) + countNodes(root.right);
}

void runTests() {
  final Solution s = Solution();

  group('Convert Sorted Array to Binary Search Tree', () {
    // ===== Examples =====
    test('Example 1: [-10,-3,0,5,9]', () {
      final nums = [-10, -3, 0, 5, 9];
      final root = s.sortedArrayToBST(nums);

      expect(root, isNotNull);
      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(nums.length));
    });

    test('Example 2: [1,3]', () {
      final nums = [1, 3];
      final root = s.sortedArrayToBST(nums);

      expect(root, isNotNull);
      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(nums.length));
      expect(treeToList(root), anyOf(equals([1, null, 3]), equals([3, 1])));
    });

    // ===== Edge Cases =====
    test('Single element', () {
      final nums = [5];
      final root = s.sortedArrayToBST(nums);

      expect(treeToList(root), equals([5]));
      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    test('Two elements', () {
      final nums = [1, 2];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(2));
    });

    test('Three elements', () {
      final nums = [1, 2, 3];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(treeToList(root), anyOf(equals([2, 1, 3]), equals([2, 1, 3])));
    });

    // ===== Small Arrays =====
    test('Four elements', () {
      final nums = [1, 2, 3, 4];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(4));
    });

    test('Five elements', () {
      final nums = [1, 2, 3, 4, 5];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(5));
      expect(root?.val, equals(3));
    });

    test('Six elements', () {
      final nums = [1, 2, 3, 4, 5, 6];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(6));
    });

    // ===== Negative Values =====
    test('All negative values', () {
      final nums = [-9, -7, -5, -3, -1];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    test('Mixed negative and positive values', () {
      final nums = [-10, -3, 0, 5, 9, 12];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    test('Includes zero centered', () {
      final nums = [-2, -1, 0, 1, 2];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(root?.val, equals(0));
    });

    // ===== Boundary Values =====
    test('Min and max constraint style values', () {
      final nums = [-10000, -5000, 0, 5000, 10000];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    test('Large magnitude values', () {
      final nums = [-100000000, -1, 0, 1, 100000000];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    // ===== Increasing Ranges =====
    test('Consecutive numbers 1..7', () {
      final nums = [1, 2, 3, 4, 5, 6, 7];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(7));
    });

    test('Consecutive numbers 10..20', () {
      final nums = List.generate(11, (i) => i + 10);
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    // ===== Odd / Even Length =====
    test('Odd length array', () {
      final nums = [2, 4, 6, 8, 10, 12, 14, 16, 18];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    test('Even length array', () {
      final nums = [2, 4, 6, 8, 10, 12, 14, 16];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
    });

    // ===== Larger Cases =====
    test('Large array size 31', () {
      final nums = List.generate(31, (i) => i - 15);
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(31));
      expect(height(root), lessThanOrEqualTo(6));
    });

    test('Large array size 100', () {
      final nums = List.generate(100, (i) => i + 1);
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(100));
    });

    test('Constraint-style array size 1000', () {
      final nums = List.generate(1000, (i) => i - 500);
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(1000));
    });

    test('Constraint-style array size 10000', () {
      final nums = List.generate(10000, (i) => i - 5000);
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
      expect(isValidBST(root), isTrue);
      expect(isBalanced(root), isTrue);
      expect(countNodes(root), equals(10000));
    });

    // ===== Stability / Structure Checks =====
    test('Inorder must exactly match original sorted array', () {
      final nums = [-8, -4, -2, 0, 3, 9, 11];
      final root = s.sortedArrayToBST(nums);

      expect(inorderTraversal(root), equals(nums));
    });

    test('Node count should equal array length', () {
      final nums = [-3, -1, 2, 4, 8, 10];
      final root = s.sortedArrayToBST(nums);

      expect(countNodes(root), equals(nums.length));
    });

    test('Tree must be height-balanced', () {
      final nums = List.generate(63, (i) => i + 1);
      final root = s.sortedArrayToBST(nums);

      expect(isBalanced(root), isTrue);
    });

    test('Tree must satisfy BST property', () {
      final nums = [-15, -10, -5, 0, 5, 10, 15];
      final root = s.sortedArrayToBST(nums);

      expect(isValidBST(root), isTrue);
    });

    test('Root should be near the middle value', () {
      final nums = [1, 2, 3, 4, 5, 6];
      final root = s.sortedArrayToBST(nums);

      expect(root?.val, anyOf(equals(3), equals(4)));
    });
  });
}
