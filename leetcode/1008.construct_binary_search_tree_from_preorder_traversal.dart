// leetcode/1008.construct_binary_search_tree_from_preorder_traversal.dart
// https://leetcode.com/problems/construct-binary-search-tree-from-preorder-traversal/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.bstFromPreorder([8, 5, 1, 7, 10, 12]);

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
  TreeNode? bstFromPreorder(List<int> preorder) {
    if (preorder.isEmpty) return null;
    final root = TreeNode(preorder[0]);
    final List<TreeNode> stack = [root];

    for (var i = 1; i < preorder.length; i++) {
      final val = preorder[i];
      final newNode = TreeNode(val);

      /// Add left
      if (preorder[i - 1] > preorder[i]) {
        stack.last.left = newNode;

        /// Add right
      } else {
        TreeNode lastNode = stack.removeLast();
        while (lastNode.val < val && stack.isNotEmpty) {
          if (stack.last.val < val) {
            lastNode = stack.removeLast();
          } else {
            break;
          }
        }
        lastNode.right = newNode;
      }
      stack.add(newNode);
    }

    return root;
  }

  ////! Another Solution
  // int nodeIndex = 0;

  // TreeNode? bstFromPreorder(List<int> preorder) {
  //   if (preorder.isEmpty) return null;
  //   return helper(preorder, null, null);
  // }

  // TreeNode? helper(List<int> preorder, int? min, int? max) {
  //   if (nodeIndex == preorder.length) return null;

  //   int current = preorder[nodeIndex];

  //   if ((min != null && current <= min) || (max != null && current >= max)) {
  //     return null;
  //   }

  //   nodeIndex++;
  //   TreeNode node = TreeNode(current);

  //   node.left = helper(preorder, min, current);
  //   node.right = helper(preorder, current, max);

  //   return node;
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

List<int> preorderTraversal(TreeNode? root) {
  final result = <int>[];

  void dfs(TreeNode? node) {
    if (node == null) return;
    result.add(node.val);
    dfs(node.left);
    dfs(node.right);
  }

  dfs(root);
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

int countNodes(TreeNode? root) {
  if (root == null) return 0;
  return 1 + countNodes(root.left) + countNodes(root.right);
}

void runTests() {
  final Solution s = Solution();

  group('Construct Binary Search Tree from Preorder Traversal', () {
    // ===== Examples =====
    test('Example 1: [8,5,1,7,10,12]', () {
      final preorder = [8, 5, 1, 7, 10, 12];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([8, 5, 10, 1, 7, null, 12]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 5, 7, 8, 10, 12]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    test('Example 2: [1,3]', () {
      final preorder = [1, 3];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([1, null, 3]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 3]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    // ===== Edge Cases =====
    test('Single node', () {
      final preorder = [5];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([5]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([5]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(1));
    });

    test('Minimum-like value single node', () {
      final preorder = [1];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([1]));
      expect(preorderTraversal(root), equals(preorder));
      expect(isValidBST(root), isTrue);
    });

    test('Maximum-like value single node', () {
      final preorder = [1000];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([1000]));
      expect(preorderTraversal(root), equals(preorder));
      expect(isValidBST(root), isTrue);
    });

    // ===== Small Trees =====
    test('Three nodes balanced: [2,1,3]', () {
      final preorder = [2, 1, 3];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([2, 1, 3]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3]));
      expect(isValidBST(root), isTrue);
    });

    test('Three nodes right-skewed: [1,2,3]', () {
      final preorder = [1, 2, 3];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([1, null, 2, null, 3]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3]));
      expect(isValidBST(root), isTrue);
    });

    test('Three nodes left-skewed: [3,2,1]', () {
      final preorder = [3, 2, 1];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([3, 2, null, 1]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3]));
      expect(isValidBST(root), isTrue);
    });

    test('Four nodes mixed: [4,2,1,3]', () {
      final preorder = [4, 2, 1, 3];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([4, 2, null, 1, 3]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3, 4]));
      expect(isValidBST(root), isTrue);
    });

    // ===== Classic BST Shapes =====
    test('Perfect BST preorder: [4,2,1,3,6,5,7]', () {
      final preorder = [4, 2, 1, 3, 6, 5, 7];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([4, 2, 6, 1, 3, 5, 7]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3, 4, 5, 6, 7]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(7));
    });

    test('Mixed BST shape: [10,5,1,7,40,50]', () {
      final preorder = [10, 5, 1, 7, 40, 50];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([10, 5, 40, 1, 7, null, 50]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 5, 7, 10, 40, 50]));
      expect(isValidBST(root), isTrue);
    });

    test('Another mixed BST shape: [7,3,1,5,4,6,9,8,10]', () {
      final preorder = [7, 3, 1, 5, 4, 6, 9, 8, 10];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 3, 4, 5, 6, 7, 8, 9, 10]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    // ===== Increasing / Decreasing =====
    test('Strictly increasing preorder creates right-skewed BST', () {
      final preorder = [1, 2, 3, 4, 5, 6];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root),
          equals([1, null, 2, null, 3, null, 4, null, 5, null, 6]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3, 4, 5, 6]));
      expect(isValidBST(root), isTrue);
    });

    test('Strictly decreasing preorder creates left-skewed BST', () {
      final preorder = [6, 5, 4, 3, 2, 1];
      final root = s.bstFromPreorder(preorder);

      expect(
          treeToList(root), equals([6, 5, null, 4, null, 3, null, 2, null, 1]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 2, 3, 4, 5, 6]));
      expect(isValidBST(root), isTrue);
    });

    // ===== Boundary / Constraint Style =====
    test('Smallest and largest values mixed', () {
      final preorder = [500, 1, 250, 1000, 750];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 250, 500, 750, 1000]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    test('Near constraint values ascending-like split', () {
      final preorder = [100, 50, 25, 75, 150, 125, 175];
      final root = s.bstFromPreorder(preorder);

      expect(treeToList(root), equals([100, 50, 150, 25, 75, 125, 175]));
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([25, 50, 75, 100, 125, 150, 175]));
      expect(isValidBST(root), isTrue);
    });

    // ===== More Complex Valid Cases =====
    test('Deep left and right transitions', () {
      final preorder = [15, 10, 8, 12, 11, 13, 20, 17, 25];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(
          inorderTraversal(root), equals([8, 10, 11, 12, 13, 15, 17, 20, 25]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    test('Nested subtree boundaries', () {
      final preorder = [30, 20, 10, 25, 23, 28, 40, 35, 50];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(
          inorderTraversal(root), equals([10, 20, 23, 25, 28, 30, 35, 40, 50]));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(preorder.length));
    });

    test('Right subtree with left descendants', () {
      final preorder = [8, 5, 1, 7, 10, 9, 12, 11];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals([1, 5, 7, 8, 9, 10, 11, 12]));
      expect(isValidBST(root), isTrue);
    });

    // ===== Larger Cases =====
    test('15-node perfect BST preorder', () {
      final preorder = [8, 4, 2, 1, 3, 6, 5, 7, 12, 10, 9, 11, 14, 13, 15];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(
        inorderTraversal(root),
        equals([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]),
      );
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(15));
    });

    test('Large increasing input size 100', () {
      final preorder = List.generate(100, (i) => i + 1);
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals(preorder));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(100));
    });

    test('Large decreasing input size 100', () {
      final preorder = List.generate(100, (i) => 100 - i);
      final root = s.bstFromPreorder(preorder);

      final expectedInorder = List.generate(100, (i) => i + 1);
      expect(preorderTraversal(root), equals(preorder));
      expect(inorderTraversal(root), equals(expectedInorder));
      expect(isValidBST(root), isTrue);
      expect(countNodes(root), equals(100));
    });

    // ===== Stability / Structure Checks =====
    test('Preorder traversal of constructed tree must equal input exactly', () {
      final preorder = [9, 5, 2, 7, 6, 8, 12, 11, 15];
      final root = s.bstFromPreorder(preorder);

      expect(preorderTraversal(root), equals(preorder));
    });

    test('Inorder traversal must be sorted ascending', () {
      final preorder = [9, 5, 2, 7, 6, 8, 12, 11, 15];
      final root = s.bstFromPreorder(preorder);

      expect(inorderTraversal(root), equals([2, 5, 6, 7, 8, 9, 11, 12, 15]));
    });

    test('Constructed tree must be a valid BST', () {
      final preorder = [50, 30, 20, 40, 70, 60, 80];
      final root = s.bstFromPreorder(preorder);

      expect(isValidBST(root), isTrue);
    });

    test('Node count should match preorder length', () {
      final preorder = [14, 7, 3, 9, 20, 18, 25];
      final root = s.bstFromPreorder(preorder);

      expect(countNodes(root), equals(preorder.length));
    });

    test('Root should equal first preorder value', () {
      final preorder = [42, 21, 10, 30, 84, 63, 96];
      final root = s.bstFromPreorder(preorder);

      expect(root?.val, equals(42));
      expect(preorderTraversal(root), equals(preorder));
      expect(isValidBST(root), isTrue);
    });
  });
}
