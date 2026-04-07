# Trees in Data Structures

A **tree** is a **non-linear hierarchical data structure**.

It is used when data is organized in **levels**, not in a straight line.

## Simple idea

Think of:

- a **family tree**
- folders inside folders on your computer
- an organization chart in a company

That is exactly how a tree works.

---

# Basic Definition

A **tree** is a collection of **nodes** connected by **edges**, arranged in a parent-child relationship.

It starts from one top node called the **root**.

Each node can have **zero or more children**.

---

# Why is it called a Tree?

Because it looks like an upside-down real tree:

- the **root** is at the top
- the **branches** go downward
- the **leaves** are at the bottom

Example:

```text
        A
       / \
      B   C
     / \   \
    D   E   F
```

---

# Important Terms in Trees

You must know these very well.

## 1. Node

Each element in the tree is called a **node**.

In the example above:

- A, B, C, D, E, F are nodes

## 2. Edge

A connection between two nodes.

Examples:

- A → B
- A → C
- B → D

## 3. Root

The topmost node in the tree.

In the example:

- **A** is the root

## 4. Parent

A node that has children.

Examples:

- A is parent of B and C
- B is parent of D and E

## 5. Child

A node directly below another node.

Examples:

- B and C are children of A
- D and E are children of B

## 6. Siblings

Nodes that share the same parent.

Examples:

- B and C are siblings
- D and E are siblings

## 7. Leaf Node

A node with **no children**.

Examples:

- D, E, F are leaf nodes

## 8. Internal Node

A node that has at least one child.

Examples:

- A, B, C

## 9. Degree of a Node

The number of children a node has.

Examples:

- degree(A) = 2
- degree(B) = 2
- degree(F) = 0

## 10. Depth

The number of edges from the root to a node.

If root depth = 0:

- depth(A) = 0
- depth(B) = 1
- depth(D) = 2

## 11. Height of a Node

The number of edges in the longest path from that node to a leaf.

## 12. Height of the Tree

The height of the root.

In the example above, height = 2

## 13. Level

Sometimes level is counted starting from 1.

Example:

- A at level 1
- B, C at level 2
- D, E, F at level 3

## 14. Subtree

Any node with all its descendants forms a subtree.

Example:
The subtree rooted at B is:

```text
      B
     / \
    D   E
```

---

# Main Idea of Trees

Trees are useful when:

- data is hierarchical
- searching must be faster
- insertion and deletion should be organized
- relationships are parent-child, not one-by-one

---

# General Structure of a Tree

A tree is made of:

- one **root**
- many **children**
- zero or more **subtrees**

A tree with no nodes is called an **empty tree**.

---

# Properties of Trees

Here are important properties:

## 1. A tree has one root

Only one root exists in a normal tree.

## 2. Every child has exactly one parent

Except the root, which has no parent.

## 3. A tree has no cycles

You cannot start at a node and come back to it again by following edges.

## 4. A tree with n nodes has n - 1 edges

Very important rule.

Example:

- 6 nodes → 5 edges

---

# Types of Trees

Now let’s study the important types.

# 1. General Tree

In a **general tree**, a node can have **any number of children**.

Example:

```text
        A
      / | \
     B  C  D
       / \
      E   F
```

Here, A has 3 children.

---

# 2. Binary Tree

A **binary tree** is a tree in which each node can have **at most two children**:

- left child
- right child

Example:

```text
        A
       / \
      B   C
     / \   \
    D   E   F
```

This is one of the most important trees in computer science.

## Why binary trees are important

Because many algorithms become easier and faster with them.

---

# Types of Binary Trees

## A. Full Binary Tree

Every node has either:

- 0 children
- or 2 children

No node has only one child.

Example:

```text
        A
       / \
      B   C
     / \
    D   E
```

B has 2 children, C has 0.

---

## B. Complete Binary Tree

All levels are completely filled except possibly the last level, and the last level is filled from **left to right**.

Example:

```text
        A
       / \
      B   C
     / \  /
    D  E F
```

This is complete.

---

## C. Perfect Binary Tree

All internal nodes have 2 children and all leaves are at the same level.

Example:

```text
        A
       / \
      B   C
     / \ / \
    D  E F  G
```

This is perfect.

## Property

If height = h, then number of nodes is:

```text
2^(h+1) - 1
```

---

## D. Skewed Binary Tree

Every node has only one child.

It may be:

- left-skewed
- right-skewed

Example:

```text
A
 \
  B
   \
    C
     \
      D
```

This is bad for performance in searching because it behaves like a linked list.

---

## E. Balanced Binary Tree

A tree where the height difference between left and right subtrees stays small.

Balanced trees are important because operations stay fast.

Examples:

- AVL Tree
- Red-Black Tree

---

# 3. Binary Search Tree (BST)

This is one of the most important trees.

A **Binary Search Tree** is a binary tree where:

- all values in the left subtree are **smaller** than the root
- all values in the right subtree are **greater** than the root
- this rule applies recursively to all nodes

Example:

```text
        50
       /  \
     30    70
    / \    / \
   20 40  60 80
```

## BST rule

For node 50:

- left side < 50
- right side > 50

For node 30:

- left side < 30
- right side > 30

And so on.

---

# Why BST is useful

Because searching becomes faster.

To search for 60:

- compare with 50 → go right
- compare with 70 → go left
- found 60

This is much faster than checking every element one by one.

---

# Operations in BST

## Search

Compare and move:

- smaller → go left
- greater → go right

## Insertion

Find the correct empty place according to BST rules and insert there.

## Deletion

This is more complex. There are 3 cases:

### Case 1: Node is a leaf

Just remove it.

### Case 2: Node has one child

Remove the node and connect its child to its parent.

### Case 3: Node has two children

Replace it with:

- inorder successor, or
- inorder predecessor

Then delete that replacement node.

---

# BST Time Complexity

If the tree is balanced:

- Search: O(log n)
- Insert: O(log n)
- Delete: O(log n)

If the tree becomes skewed:

- Search: O(n)
- Insert: O(n)
- Delete: O(n)

So balance matters a lot.

---

# 4. AVL Tree

An **AVL tree** is a self-balancing BST.

It keeps the tree balanced after insertion and deletion.

## AVL condition

For every node:

```text
Balance Factor = height(left subtree) - height(right subtree)
```

Allowed values:

- -1
- 0
- 1

If it becomes outside this range, we rotate the tree.

## Why AVL is useful

Because it guarantees fast operations.

## Rotations in AVL

There are 4 cases:

- LL Rotation
- RR Rotation
- LR Rotation
- RL Rotation

You do not need to master them all at once today unless you want the advanced part.

---

# 5. Red-Black Tree

Another self-balancing BST.

Each node has a color:

- red
- black

Special rules keep the tree approximately balanced.

## Why used

Red-Black Trees are used in:

- maps
- sets
- operating systems
- library implementations

They are usually a bit less strict than AVL, so updates can be more practical.

---

# 6. Heap

A **heap** is a special complete binary tree.

There are two types:

## Max Heap

Parent is greater than or equal to its children.

Example:

```text
        90
       /  \
     70    60
    / \   /
   50 40 30
```

## Min Heap

Parent is smaller than or equal to its children.

Example:

```text
        10
       /  \
     20    30
    / \   /
   40 50 60
```

## Important

A heap is **not** a BST.

It only guarantees parent-child order, not full left-small/right-big ordering.

## Uses of Heap

- priority queue
- scheduling
- heap sort
- shortest path algorithms

---

# 7. Trie

A **trie** is a tree used to store strings.

Example words:

- car
- cat
- call

They share prefixes.

Simple view:

```text
        root
         |
         c
         |
         a
       / | \
      r  t  l
            |
            l
```

## Uses

- autocomplete
- dictionary lookup
- spell checker
- prefix search

---

# 8. B-Tree

A **B-Tree** is a self-balancing search tree that can have more than two children.

Used in:

- databases
- file systems
- disk storage systems

Why?
Because it reduces disk reads and writes.

---

# 9. B+ Tree

Very similar to B-Tree, but all actual data records are usually stored at leaf nodes.

Very common in:

- database indexing

---

# Tree Traversal

Traversal means **visiting all nodes of the tree in a specific order**.

This is extremely important.

There are two main groups:

- Depth First Traversal
- Breadth First Traversal

---

# 1. Depth First Traversal (DFS)

In DFS, we go deep into a branch before moving to another one.

For this tree:

```text
        A
       / \
      B   C
     / \
    D   E
```

## A. Preorder (C,L,R)

Order:

- Current
- Left
- Right

Result:

```text
A B D E C
```

## B. Inorder (L,C,R)

Order:

- Left
- Current
- Right

Result:

```text
D B E A C
```

In BST, inorder gives sorted order.

## C. Postorder (L,R,C)

Order:

- Left
- Right
- Current

Result:

```text
D E B C A
```

---

# 2. Breadth First Traversal (Level Order)

Visit nodes level by level.

```text
        A
       / \
      B   C
     / \   \
    D   E   F

```

## Standard Level Order Traversal

Order:

```text
A B C D E
```

Usually implemented using a **queue**.

## Reverse Level Order Traversal

- Visit nodes level by level, but print them from the bottom level to the top.

## Zigzag Level Order Traversal

- first level: left to right
- second level: right to left
- third level: left to right
- and so on

---

# Easy Way to Remember Traversals

## Preorder

**Root first**

## Inorder

**Root in the middle**

## Postorder

**Root last**

---

# Tree Representation in Memory

Trees can be stored in memory in different ways.

## 1. Linked Representation

Each node stores:

- data
- pointer to left child
- pointer to right child

For binary tree:

```c
struct Node {
    int data;
    Node* left;
    Node* right;
};
```

## 2. Array Representation

Mostly used for complete binary trees, especially heaps.

If a node is at index `i`:

- left child = `2i + 1`
- right child = `2i + 2`

This works well in arrays.

---

# Applications of Trees

Trees are everywhere in computer science.

## Common uses

- file systems
- HTML/XML DOM
- organization hierarchy
- database indexing
- expression parsing
- auto-complete
- AI decision trees
- routing tables
- compiler syntax trees

---

# Trees vs Other Data Structures

## Tree vs Array

- Array is linear
- Tree is hierarchical

## Tree vs Linked List

- Linked list is one-by-one
- Tree branches into many paths

## Tree vs Graph

- Tree is a special kind of graph
- Tree has no cycles and usually has one root
- Graph can have cycles and complex connections

---

# Expression Tree

A special binary tree used to represent expressions.

Example:
For:

```text
(A + B) * C
```

Tree:

```text
        *
       / \
      +   C
     / \
    A   B
```

Used in:

- compilers
- calculators
- expression evaluation

---

# Complexity of Basic Tree Operations

This depends on tree type.

## In a balanced BST

- Search: O(log n)
- Insert: O(log n)
- Delete: O(log n)

## In a skewed BST

- Search: O(n)
- Insert: O(n)
- Delete: O(n)

## Traversal in any tree

- O(n)

because every node is visited once.

---

# Most Important Exam Points

Focus on these first:

## Definitions

- tree
- node
- root
- parent
- child
- leaf
- subtree
- depth
- height

## Types

- General Tree
- Binary Tree
- BST
- AVL
- Heap
- Trie
- B-Tree

## Traversals

- preorder
- inorder
- postorder
- level order

## Key rules

- tree with n nodes has n - 1 edges
- BST left < root < right
- inorder of BST gives sorted order
- heap is not BST
- balanced trees are faster

---

# Memory Tricks

## 1. BST rule

**Left Small, Right Big**

## 2. Traversals

- Pre = root first
- In = root middle
- Post = root last

## 3. Heap

- Max Heap = biggest on top
- Min Heap = smallest on top

## 4. Trie

Think: **tree for text**

---

# Super Short Revision Sheet

## Tree

A hierarchical non-linear structure made of nodes and edges.

## Binary Tree

Each node has at most 2 children.

## BST

Left subtree < root < right subtree.

## AVL

Self-balancing BST.

## Heap

Complete binary tree with min/max property.

## Trie

Tree for strings and prefixes.

## Traversals

- Preorder = Root Left Right
- Inorder = Left Root Right
- Postorder = Left Right Root
- Level Order = level by level

---

# One Beautiful Final Summary

A **tree** is one of the most important data structures because it stores data in a **hierarchical way**. It is used when relationships are naturally parent-child, such as folders, family relationships, and search systems. The most important tree types are **binary tree**, **BST**, **AVL**, **heap**, **trie**, and **B-tree**. To master trees, you must understand the terminology, types, traversals, and the BST rule.

---

Now let’s make studying easier.

## Study order for Trees

Read in this order:

1. Tree concept
2. Tree terminology
3. Binary Tree
4. BST
5. Traversals
6. AVL
7. Heap
8. Trie
9. B-Tree / B+ Tree

## Mini quiz for you

1. What is the difference between a **tree** and a **graph**?
2. What is the difference between a **binary tree** and a **BST**?
3. Why does **inorder traversal** of a BST give sorted order?
4. Why is a **heap** not the same as a BST?
5. What is the difference between a **leaf node** and an **internal node**?

Answer these 5, and I’ll correct them and then teach you **Tree Traversal** in an even easier way.
