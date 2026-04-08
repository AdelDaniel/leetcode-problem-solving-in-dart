// trees.dart

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode(this.val, [this.left, this.right]);
}

class Trees {
  /// TS: O(N) SC: O(N)
  ////! Important to understand: https://www.youtube.com/watch?v=HZ5YTanv5QE
  List<List<int>> levelOrder(TreeNode? root) {
    final List<List<int>> result = [];
    if (root == null) return result;

    List<TreeNode> queue = [];
    queue.add(root);
    while (queue.isNotEmpty) {
      int size = queue.length;
      final List<int> newLevel = [];
      while (size > 0) {
        final node = queue.removeAt(0);
        newLevel.add(node.val);
        if (node.left != null) queue.add(node.left!);
        if (node.right != null) queue.add(node.right!);
        size--;
      }
      result.add(newLevel);
    }

    return result;
  }

  List<List<int>> zigzagLevelOrder(TreeNode? root) {
    final List<List<int>> result = [];
    if (root == null) return result;

    final List<TreeNode> queue = [];

    queue.add(root);
    int currentLevel = 0;

    while (queue.isNotEmpty) {
      int size = queue.length;
      final List<int> newLevel = [];
      while (size > 0) {
        final visitedNode = queue.removeAt(0);
        currentLevel % 2 == 0
            ? newLevel.add(visitedNode.val)
            : newLevel.insert(0, visitedNode.val);
        if (visitedNode.left != null) queue.add(visitedNode.left!);
        if (visitedNode.right != null) queue.add(visitedNode.right!);
        size--;
      }
      result.add(newLevel);
      currentLevel++;
    }

    return result;
  }

  /// TS: O(N) SC: O(N)
  ////! Understand it: https://www.youtube.com/watch?v=1WxLM2hwL-U
  List<int> preorderTraversal(TreeNode? root) {
    final List<int> result = [];
    if (root == null) return result;

    final List<TreeNode> stack = [];
    stack.add(root);

    TreeNode? visitedNode;
    while (stack.isNotEmpty) {
      visitedNode = stack.removeLast();
      result.add(visitedNode.val);
      if (visitedNode.right != null) stack.add(visitedNode.right!);
      if (visitedNode.left != null) stack.add(visitedNode.left!);
    }

    return result;
  }
}
