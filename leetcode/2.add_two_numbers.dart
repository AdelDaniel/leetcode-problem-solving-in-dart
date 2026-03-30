// leetcode/2.add_two_numbers.dart
// https://leetcode.com/problems/add-two-numbers/
import 'package:test/test.dart';

// Definition for singly-linked list.
class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  // Quick manual check: 342 + 465 = 807
  s.addTwoNumbers(listToNodes([2, 4, 3]), listToNodes([5, 6, 4]));

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  /// Recursion Solution
  ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
    if (l2 == null && l1 == null) return null;

    final value = (l2?.val ?? 0) + (l1?.val ?? 0);
    final mod = value % 10;
    final tens = value ~/ 10;

    l2 = l2?.next;
    l1 = l1?.next;

    if (l2 != null) {
      l2.val += tens;
    } else if (l1 != null) {
      l1.val += tens;
    } else if (tens == 1) {
      l1 = ListNode(1, null);
    }
    return ListNode(mod, addTwoNumbers(l2, l1));
  }

  // /// Bad Solution
  // ListNode? addTwoNumbers(ListNode? l1, ListNode? l2) {
  //   if (l2 == null && l1 == null) return null;
  //   // if (l1 == null) return l2;
  //   // if (l2 == null) return l1;

  //   // if (l2.next != null || l1.next != null) {
  //   final value = (l2?.val ?? 0) + (l1?.val ?? 0);
  //   final mod = value % 10;
  //   final tens = value ~/ 10;
  //   if (l2?.next != null) {
  //     l2?.next?.val += tens;
  //   } else if (l1?.next != null) {
  //     l1?.next?.val += tens;
  //   } else if (tens == 1) {
  //     l1 = ListNode(0, ListNode(1, null));
  //   }
  //   return ListNode(mod, addTwoNumbers(l2?.next, l1?.next));
  //   // }
  //   // Implementation goes here
  //   // return null;
  // }
}

/// Helper to convert List to Linked List
ListNode? listToNodes(List<int> list) {
  if (list.isEmpty) return null;
  ListNode head = ListNode(list[0]);
  ListNode? current = head;
  for (int i = 1; i < list.length; i++) {
    current?.next = ListNode(list[i]);
    current = current?.next;
  }
  return head;
}

/// Helper to convert Linked List back to List
List<int> nodesToList(ListNode? head) {
  List<int> result = [];
  while (head != null) {
    result.add(head.val);
    head = head.next;
  }
  return result;
}

void runTests() {
  final Solution s = Solution();

  group('Add Two Numbers', () {
    // Basic examples from problem statement
    test('Example 1: [2,4,3] + [5,6,4] → [7,0,8] (342 + 465 = 807)', () {
      final l1 = listToNodes([2, 4, 3]);
      final l2 = listToNodes([5, 6, 4]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([7, 0, 8]));
    });

    test('Example 2: [0] + [0] → [0]', () {
      final l1 = listToNodes([0]);
      final l2 = listToNodes([0]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([0]));
    });

    test('Example 3: [9,9,9,9,9,9,9] + [9,9,9,9] → [8,9,9,9,0,0,0,1]', () {
      final l1 = listToNodes([9, 9, 9, 9, 9, 9, 9]);
      final l2 = listToNodes([9, 9, 9, 9]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)),
          equals([8, 9, 9, 9, 0, 0, 0, 1]));
    });

    // Edge Case: Carry over at the very end
    test('Carry at the end: [5] + [5] → [0,1] (5 + 5 = 10)', () {
      final l1 = listToNodes([5]);
      final l2 = listToNodes([5]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([0, 1]));
    });

    test('Multiple carries: [9,9] + [1] → [0,0,1] (99 + 1 = 100)', () {
      final l1 = listToNodes([9, 9]);
      final l2 = listToNodes([1]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([0, 0, 1]));
    });

    // Different Lengths
    test('L1 shorter than L2: [1] + [9,9] → [0,0,1]', () {
      final l1 = listToNodes([1]);
      final l2 = listToNodes([9, 9]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([0, 0, 1]));
    });

    test(
        'Large numbers with zeros: [0,0,0,1] + [0,0,0,9] → [0,0,0,0,1] (1000 + 9000 = 10000)',
        () {
      final l1 = listToNodes([0, 0, 0, 1]);
      final l2 = listToNodes([0, 0, 0, 9]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([0, 0, 0, 0, 1]));
    });

    // Mixed values
    test('Mixed: [1,8] + [0] → [1,8] (81 + 0 = 81)', () {
      final l1 = listToNodes([1, 8]);
      final l2 = listToNodes([0]);
      expect(nodesToList(s.addTwoNumbers(l1, l2)), equals([1, 8]));
    });
  });
}
