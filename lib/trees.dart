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

  List<int> inorderTraversal(TreeNode? root) {
    final List<int> result = [];
    if (root == null) return result;

    final List<TreeNode> stack = [];

    TreeNode? node = root;

    while (stack.isNotEmpty || node != null) {
      // Reach the leftmost node of the current node
      while (node != null) {
        stack.add(node);
        node = node.left;
      }

      // Current must be null at this point
      node = stack.removeLast();
      result.add(node.val);

      // Now visit the right subtree
      node = node.right;
    }

    return result;
  }

  /// TS: O(N) SC: O(N)
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
