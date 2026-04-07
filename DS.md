# Data Structure Types

A **data structure** is a way to **organize, store, and manage data** so that operations like **access, insertion, deletion, searching, and updating** can be done efficiently.

Think of it like this:

- **Data** = your books, clothes, or files
- **Data structure** = the shelf, drawer, cabinet, or folder system you use to arrange them

Different problems need different ways of organizing data.

---

# Why We Study Data Structures

We study data structures because they help us:

- store data efficiently
- access data quickly
- reduce time and memory usage
- solve programming problems in a structured way

A good programmer does not just ask:

> “Can I store the data?”

They also ask:

> “What is the best way to store it for this problem?”

---

# Main Classification of Data Structures

Data structures are usually divided into **two main categories**:

## 1) Primitive Data Structures

These are the **basic built-in types** that store a **single value**.

Examples:

- `int` → whole numbers
- `float` / `double` → decimal numbers
- `char` → a single character
- `bool` → `true` or `false`
- `pointer` → stores a memory address

These are the building blocks for more advanced structures.

---

## 2) Non-Primitive Data Structures

These are more advanced structures built using primitive data types.

They are commonly divided into:

- **Linear Data Structures**
- **Non-Linear Data Structures**

In many courses, books also discuss:

- **Hash-based structures**
- **Specialized / advanced structures**

---

# Full Classification Map

```text
Data Structures
│
├── 1) Primitive
│   ├── Integer
│   ├── Float / Double
│   ├── Character
│   ├── Boolean
│   └── Pointer
│
└── 2) Non-Primitive
    │
    ├── A) Linear
    │   ├── Array
    │   ├── Linked List
    │   ├── Stack
    │   └── Queue
    │       ├── Simple Queue
    │       ├── Circular Queue
    │       ├── Priority Queue
    │       └── Deque
    │
    ├── B) Non-Linear
    │   ├── Tree
    │   │   ├── General Tree
    │   │   ├── Binary Tree
    │   │   ├── Binary Search Tree (BST)
    │   │   ├── AVL Tree
    │   │   ├── Red-Black Tree
    │   │   ├── B-Tree
    │   │   ├── B+ Tree
    │   │   ├── Heap
    │   │   └── Trie
    │   └── Graph
    │       ├── Directed Graph
    │       ├── Undirected Graph
    │       ├── Weighted Graph
    │       ├── Unweighted Graph
    │       ├── Cyclic Graph
    │       ├── Acyclic Graph
    │       └── DAG
    │
    ├── C) Hash-Based
    │   ├── Hash Table
    │   ├── Hash Map
    │   └── Hash Set
    │
    └── D) Specialized / Advanced
        ├── Set
        ├── Map / Dictionary
        ├── Disjoint Set (Union-Find)
        ├── Skip List
        ├── Segment Tree
        ├── Fenwick Tree (Binary Indexed Tree)
        ├── Suffix Tree
        └── Suffix Array
```

---

# Important Note About Classification

Some data structures can appear in **more than one category** depending on the book or instructor.

For example:

- **Heap** is a **tree-based** structure, but many books list it separately because of its importance in priority queues.
- **Trie** is also a **tree**, but it is often discussed separately because it is mainly used for strings and prefixes.
- **Set** and **Map** are often treated as abstract containers, while their internal implementation may use a **hash table** or a **tree**.

So classification is helpful for learning, but some overlap is normal.

---

# 1) Primitive Data Structures

Primitive data structures hold **single values**.

## Integer

Stores whole numbers.

Examples:

- `5`
- `-12`
- `100`

## Float / Double

Stores decimal numbers.

Examples:

- `3.14`
- `99.5`

## Character

Stores a single letter, digit, or symbol.

Examples:

- `'A'`
- `'z'`
- `'#'`

## Boolean

Stores only one of two values:

- `true`
- `false`

## Pointer

Stores the memory address of another variable.

Used a lot in:

- C
- C++
- linked lists
- trees
- dynamic memory allocation

---

# 2) Non-Primitive Data Structures

These store **multiple values** and organize them in useful ways.

---

# A) Linear Data Structures

In linear structures, elements are arranged in a **sequence**.
Each element is connected in a straight order.

Example:

```text
A → B → C → D
```

## 1. Array

An **array** stores elements of the same type in **contiguous memory locations**.

Example:

```text
[10, 20, 30, 40]
```

### Key idea

Fast access by index.

### Example

- `arr[0] = 10`
- `arr[2] = 30`

### Advantages

- simple to understand
- fast random access
- memory-efficient for fixed-size data

### Disadvantages

- fixed size in many languages
- insertion and deletion can be expensive

### Real-life example

Like seats in a cinema row:

- every seat has a number
- you can go directly to seat 5

---

## 2. Linked List

A **linked list** is made of nodes, and each node contains:

- data
- a reference (or pointer) to the next node

Example:

```text
10 → 20 → 30 → 40
```

Unlike arrays, nodes are not required to be next to each other in memory.

### Types of Linked List

- Singly Linked List
- Doubly Linked List
- Circular Linked List

### Advantages

- dynamic size
- easy insertion and deletion

### Disadvantages

- slow direct access
- extra memory needed for links/pointers

### Real-life example

Like a treasure hunt:

- each clue leads you to the next clue

---

## 3. Stack

A **stack** follows the rule:

## LIFO

**Last In, First Out**

The last element inserted is the first one removed.

Example:

```text
Push 1, Push 2, Push 3
Stack = [1, 2, 3]
Pop → 3
```

### Main operations

- `push()` → insert
- `pop()` → remove
- `peek()` / `top()` → view the top element

### Real-life example

A stack of plates:

- you add and remove from the top

### Uses

- function calls
- recursion
- undo feature
- expression evaluation
- syntax parsing

---

## 4. Queue

A **queue** follows the rule:

## FIFO

**First In, First Out**

The first element inserted is the first one removed.

Example:

```text
Enqueue 10, 20, 30
Dequeue → 10
```

### Main operations

- `enqueue()` → insert
- `dequeue()` → remove
- `front()` → get the first element

### Real-life example

People standing in a line:

- the first person in line is served first

### Types of Queue

- Simple Queue
- Circular Queue
- Priority Queue
- Deque (Double-Ended Queue)

### Uses

- printer queues
- task scheduling
- buffering
- breadth-first search (BFS)

---

# B) Non-Linear Data Structures

In non-linear structures, data is **not arranged in one straight line**.
A single element may connect to multiple elements.

They are useful when data has:

- hierarchy
- branching
- network-like relationships

---

## 1. Tree

A **tree** is a hierarchical structure.

It includes terms such as:

- **Root** → top node
- **Parent** → node with children
- **Child** → node under a parent
- **Leaf** → node with no children
- **Subtree** → a smaller tree inside a larger tree

Example:

```text
        A
       / \
      B   C
     / \
    D   E
```

### Types of Trees

- General Tree
- Binary Tree
- Binary Search Tree (BST)
- AVL Tree
- Red-Black Tree
- Heap
- Trie
- B-Tree
- B+ Tree

### Uses

- file systems
- databases
- searching
- hierarchical data
- compilers
- indexing systems

### Real-life example

Like a family tree or a folder structure on a computer

---

## 2. Graph

A **graph** consists of:

- **Vertices (Nodes)**
- **Edges (Connections)**

Example:

```text
A --- B
|     |
C --- D
```

Graphs are used when data items have complex relationships.

### Types of Graphs

- Directed Graph
- Undirected Graph
- Weighted Graph
- Unweighted Graph
- Cyclic Graph
- Acyclic Graph
- DAG (Directed Acyclic Graph)

### Uses

- social networks
- maps and navigation
- routing
- recommendation systems
- dependency graphs

### Real-life example

Cities connected by roads

---

# Other Important Data Structures

These are often studied after the basic structures because they are very useful in real applications.

---

## 3. Hash Table

A **hash table** stores data as **key-value pairs**.

Example:

```text
"name"  → "Adel"
"id"    → 15
"grade" → 90
```

### Features

- very fast search, insertion, and deletion on average
- uses a **hash function** to compute an index

### Uses

- dictionaries
- symbol tables
- caching
- database indexing

### Real-life example

Like a dictionary:

- you search by word and get its meaning

---

## 4. Heap

A **heap** is a special tree-based structure.

### Types

- Max Heap → parent is greater than its children
- Min Heap → parent is smaller than its children

### Uses

- priority queues
- scheduling systems
- shortest path algorithms
- heap sort

### Real-life example

Like a priority waiting system:

- the highest-priority task comes first

---

## 5. Trie

A **trie** is a tree used mainly for storing strings.

### Used for

- autocomplete
- dictionaries
- spell checking
- prefix searching

Example words:

- `cat`
- `car`
- `call`

All words that start with `ca` share part of the same structure.

---

## 6. Set

A **set** stores **unique values only**.

Example:

```text
{1, 2, 3}
```

Not:

```text
{1, 2, 2, 3}
```

because duplicates are not allowed.

### Uses

- removing duplicates
- membership checking
- mathematical set operations

---

## 7. Map / Dictionary

A **map** stores data in **key-value pairs**.

Example:

```text
{
  "Egypt": "Cairo",
  "France": "Paris"
}
```

Useful when you want to find a value by a key.

---

## 8. Disjoint Set (Union-Find)

A **disjoint set** keeps track of elements divided into separate groups.

### Main operations

- `find()` → determine which set an element belongs to
- `union()` → merge two sets

### Uses

- network connectivity
- Kruskal’s algorithm
- grouping and clustering problems

---

## 9. Skip List

A **skip list** is a layered linked-list structure that allows faster searching.

### Uses

- ordered data storage
- fast search, insert, and delete

It can be seen as an alternative to balanced trees in some systems.

---

## 10. Segment Tree

A **segment tree** is used to answer range queries efficiently.

### Uses

- sum over a range
- minimum/maximum in a range
- competitive programming and interval problems

---

## 11. Fenwick Tree (Binary Indexed Tree)

A **Fenwick tree** is another structure used for prefix sums and updates.

### Uses

- prefix sum queries
- frequency tables
- efficient cumulative calculations

---

## 12. Suffix Tree / Suffix Array

These structures are used mainly in advanced string processing.

### Uses

- substring searching
- pattern matching
- text indexing
- bioinformatics

---

# Another Common Classification

Sometimes data structures are also classified by size behavior:

## A) Static Data Structures

Their size is fixed.

Example:

- Array

## B) Dynamic Data Structures

Their size can grow or shrink during program execution.

Examples:

- Linked List
- Stack using linked list
- Queue using linked list
- Trees
- Graphs

---

# Summary Table

| Type         | Category             | Main Idea              | Example               |
| ------------ | -------------------- | ---------------------- | --------------------- |
| Primitive    | Basic                | Single value           | `int`, `char`, `bool` |
| Array        | Linear               | Indexed elements       | `[1,2,3]`             |
| Linked List  | Linear               | Nodes linked together  | `10 → 20 → 30`        |
| Stack        | Linear / ADT         | LIFO                   | stack of plates       |
| Queue        | Linear / ADT         | FIFO                   | waiting line          |
| Tree         | Non-Linear           | Hierarchical structure | folders               |
| Graph        | Non-Linear           | Network relationships  | maps                  |
| Hash Table   | Hash-Based           | Fast key lookup        | dictionary            |
| Heap         | Tree-Based / Special | Priority-based         | scheduling            |
| Trie         | Tree-Based / Special | Prefix-based strings   | autocomplete          |
| Set          | Abstract / Special   | Unique values          | `{1,2,3}`             |
| Map          | Abstract / Special   | Key-value pairs        | `name → Adel`         |
| Disjoint Set | Specialized          | Group membership       | connectivity          |
| Segment Tree | Specialized          | Range queries          | intervals             |
| Fenwick Tree | Specialized          | Prefix sums            | cumulative sums       |

---

# Easiest Way to Remember Them

Use this order:

## Step 1: Start with the big groups

- Primitive
- Non-Primitive

## Step 2: Split Non-Primitive into:

- Linear
- Non-Linear
- Hash-Based
- Specialized / Advanced

## Step 3: Remember the main

### Linear

- Array
- Linked List
- Stack
- Queue

### Non-Linear

- Tree
- Graph

### Very Important Special Structures

- Hash Table
- Heap
- Trie
- Set
- Map

---

# Memory Tricks

## Core exam list

**A L S Q T G H H T S M**

- **A**rray
- **L**inked List
- **S**tack
- **Q**ueue
- **T**ree
- **G**raph
- **H**ash Table
- **H**eap
- **T**rie
- **S**et
- **M**ap

## Easy grouped memory

### Linear = **A L S Q**

- Array
- Linked List
- Stack
- Queue

### Non-Linear = **T G**

- Tree
- Graph

### Important Special = **H H T S M**

- Hash Table
- Heap
- Trie
- Set
- Map

---

# Very Short Revision Version

## Primitive

- Integer
- Float / Double
- Character
- Boolean
- Pointer

## Non-Primitive

### Linear

- Array
- Linked List
- Stack
- Queue

### Non-Linear

- Tree
- Graph

### Hash-Based / Special / Advanced

- Hash Table
- Heap
- Trie
- Set
- Map
- Disjoint Set
- Skip List
- Segment Tree
- Fenwick Tree
- Suffix Tree
- Suffix Array

---
