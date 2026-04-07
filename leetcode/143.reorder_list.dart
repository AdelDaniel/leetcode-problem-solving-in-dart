// leetcode/143.reorder_list.dart
// https://leetcode.com/problems/reorder-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  final head = buildList([1, 2, 3, 4]);
  s.reorderList(head);

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class ListNode {
  int val;
  ListNode? next;
  ListNode(this.val, [this.next]);
}

class Solution {
  /// Solution with the slow and fast pointers
  void reorderList(ListNode? head) {
    if (head == null || head.next == null) return;

    ListNode? slowNode = head;
    ListNode? fastNode = head.next;
    while (fastNode?.next != null) {
      slowNode = slowNode?.next;
      fastNode = fastNode?.next?.next;
    }

    ListNode? currentHead = slowNode?.next;
    slowNode?.next = null;
    final reversedListHead = reverseLinkedList(currentHead);

    ListNode? node = head;
    ListNode? reversedNode = reversedListHead;
    while (node != null) {
      final nextNodeTemp = node.next;
      final nextReversedNodeTemp = reversedNode?.next;

      node.next = reversedNode;
      reversedNode?.next = nextNodeTemp;

      node = nextNodeTemp;
      reversedNode = nextReversedNodeTemp;
    }
  }

  ListNode? reverseLinkedList(ListNode? head) {
    if (head == null || head.next == null) return head;
    ListNode? currentHead = head;
    ListNode? nextHead = head.next;
    currentHead.next = null;
    while (nextHead != null) {
      final temp = nextHead.next;
      nextHead.next = currentHead;
      currentHead = nextHead;
      nextHead = temp;
    }

    return currentHead;
  }
}

// class Solution {
//   /// Good Solved the problem
//   /// Stack used
//   void reorderList(ListNode? head) {
//     if (head == null || head.next == null) return;
//     final List<ListNode> stack = [];

//     /// fill the stack
//     ListNode? node = head;
//     while (node != null) {
//       stack.add(node);
//       node = node.next;
//     }

//     final length = stack.length;
//     node = head;
//     for (var i = 0; i < length ~/ 2; i++) {
//       final temp = node?.next;
//       final newNode = stack.removeLast();
//       node?.next = newNode;
//       newNode.next = temp;
//       node = temp;
//     }

//     node?.next = null;
//   }
// }

ListNode? buildList(List<int> values) {
  if (values.isEmpty) return null;

  final head = ListNode(values[0]);
  ListNode current = head;

  for (int i = 1; i < values.length; i++) {
    current.next = ListNode(values[i]);
    current = current.next!;
  }

  return head;
}

List<int> toList(ListNode? node) {
  final result = <int>[];

  while (node != null) {
    result.add(node.val);
    node = node.next;
  }

  return result;
}

void runTests() {
  final Solution s = Solution();

  group('Reorder List', () {
    // ===== Examples =====
    test('Example 1: [1,2,3,4] -> [1,4,2,3]', () {
      final head = buildList([1, 2, 3, 4]);
      s.reorderList(head);
      expect(toList(head), equals([1, 4, 2, 3]));
    });

    test('Example 2: [1,2,3,4,5] -> [1,5,2,4,3]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      s.reorderList(head);
      expect(toList(head), equals([1, 5, 2, 4, 3]));
    });

    // ===== Edge Cases =====
    test('Robustness: empty list', () {
      final head = buildList([]);
      s.reorderList(head);
      expect(toList(head), equals([]));
    });

    test('Single node', () {
      final head = buildList([1]);
      s.reorderList(head);
      expect(toList(head), equals([1]));
    });

    test('Two nodes remain same order', () {
      final head = buildList([1, 2]);
      s.reorderList(head);
      expect(toList(head), equals([1, 2]));
    });

    test('Three nodes -> [1,3,2]', () {
      final head = buildList([1, 2, 3]);
      s.reorderList(head);
      expect(toList(head), equals([1, 3, 2]));
    });

    // ===== Small / Medium Cases =====
    test('Four nodes', () {
      final head = buildList([1, 2, 3, 4]);
      s.reorderList(head);
      expect(toList(head), equals([1, 4, 2, 3]));
    });

    test('Six nodes -> [1,6,2,5,3,4]', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      s.reorderList(head);
      expect(toList(head), equals([1, 6, 2, 5, 3, 4]));
    });

    test('Seven nodes -> [1,7,2,6,3,5,4]', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7]);
      s.reorderList(head);
      expect(toList(head), equals([1, 7, 2, 6, 3, 5, 4]));
    });

    test('Eight nodes -> [1,8,2,7,3,6,4,5]', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8]);
      s.reorderList(head);
      expect(toList(head), equals([1, 8, 2, 7, 3, 6, 4, 5]));
    });

    test('Nine nodes -> [1,9,2,8,3,7,4,6,5]', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8, 9]);
      s.reorderList(head);
      expect(toList(head), equals([1, 9, 2, 8, 3, 7, 4, 6, 5]));
    });

    // ===== Duplicate Values =====
    test('All same values even length', () {
      final head = buildList([5, 5, 5, 5]);
      s.reorderList(head);
      expect(toList(head), equals([5, 5, 5, 5]));
    });

    test('All same values odd length', () {
      final head = buildList([7, 7, 7, 7, 7]);
      s.reorderList(head);
      expect(toList(head), equals([7, 7, 7, 7, 7]));
    });

    test('Mixed duplicates', () {
      final head = buildList([1, 2, 2, 3, 3, 4]);
      s.reorderList(head);
      expect(toList(head), equals([1, 4, 2, 3, 2, 3]));
    });

    // ===== Boundary Values =====
    test('Minimum allowed values', () {
      final head = buildList([1, 1, 1, 1, 1]);
      s.reorderList(head);
      expect(toList(head), equals([1, 1, 1, 1, 1]));
    });

    test('Maximum allowed values', () {
      final head = buildList([1000, 1000, 1000, 1000]);
      s.reorderList(head);
      expect(toList(head), equals([1000, 1000, 1000, 1000]));
    });

    test('Mixed min and max values', () {
      final head = buildList([1, 1000, 2, 999, 3, 998]);
      s.reorderList(head);
      expect(toList(head), equals([1, 998, 1000, 3, 2, 999]));
    });

    // ===== Patterned Inputs =====
    test('Alternating values even length', () {
      final head = buildList([1, 2, 1, 2, 1, 2]);
      s.reorderList(head);
      expect(toList(head), equals([1, 2, 2, 1, 1, 2]));
    });

    test('Alternating values odd length', () {
      final head = buildList([1, 2, 1, 2, 1]);
      s.reorderList(head);
      expect(toList(head), equals([1, 1, 2, 2, 1]));
    });

    test('Palindrome odd length', () {
      final head = buildList([1, 2, 3, 2, 1]);
      s.reorderList(head);
      expect(toList(head), equals([1, 1, 2, 2, 3]));
    });

    test('Increasing sequence even length', () {
      final head = buildList([10, 20, 30, 40, 50, 60]);
      s.reorderList(head);
      expect(toList(head), equals([10, 60, 20, 50, 30, 40]));
    });

    test('Increasing sequence odd length', () {
      final head = buildList([10, 20, 30, 40, 50]);
      s.reorderList(head);
      expect(toList(head), equals([10, 50, 20, 40, 30]));
    });

    // ===== Larger Cases =====
    test('Large list size 100', () {
      final values = List.generate(100, (i) => i + 1);
      final head = buildList(values);
      s.reorderList(head);
      final result = toList(head);

      expect(result.length, equals(100));
      expect(
          result.sublist(0, 10), equals([1, 100, 2, 99, 3, 98, 4, 97, 5, 96]));
      expect(result.sublist(94), equals([48, 53, 49, 52, 50, 51]));
    });

    test('Large list size 101', () {
      final values = List.generate(101, (i) => i + 1);
      final head = buildList(values);
      s.reorderList(head);
      final result = toList(head);

      expect(result.length, equals(101));
      expect(result.sublist(0, 11),
          equals([1, 101, 2, 100, 3, 99, 4, 98, 5, 97, 6]));
      expect(result.sublist(96), equals([49, 53, 50, 52, 51]));
    });

    // ===== Stability / Structure Checks =====
    test('Length should remain unchanged', () {
      final values = [1, 2, 3, 4, 5, 6, 7];
      final head = buildList(values);
      s.reorderList(head);
      expect(toList(head).length, equals(values.length));
    });

    test('All original values should still exist after reordering', () {
      final values = [4, 1, 7, 3, 9, 2, 6, 5];
      final head = buildList(values);
      s.reorderList(head);
      final result = toList(head)..sort();
      expect(result, equals([...values]..sort()));
    });
  });
}
