// leetcode/21.merge_two_sorted_lists.dart
// https://leetcode.com/problems/merge-two-sorted-lists/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  /// Example execution
  final Solution s = Solution();
  final list1 = listToNodes([1, 2, 4]);
  final list2 = listToNodes([1, 3, 4]);
  s.mergeTwoLists(list1, list2);

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
  /// Best Recursion Solution
  /// Efficient
  ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
    if (list1 == null && list2 == null) return null;
    if (list1 == null) return list2;
    if (list2 == null) return list1;

    if (list1.val < list2.val) {
      list1.next = mergeTwoLists(list1.next, list2);
      return list1;
    } else {
      list2.next = mergeTwoLists(list2.next, list1);
      return list2;
    }
  }

  ///
  /// Not recursion Solution
  // ListNode? mergeTwoLists(ListNode? list1, ListNode? list2) {
  //   if (list1 == null && list2 == null) return null;
  //   if (list1 == null) return list2;
  //   if (list2 == null) return list1;

  //   final List<int> result = [];
  //   ListNode? list1Next = list1;
  //   ListNode? list2Next = list2;

  //   while (list1Next != null || list2Next != null) {
  //     if (list1Next == null) {
  //       result.add(list2Next!.val);
  //       list2Next = list2Next.next;
  //     } else if (list2Next == null) {
  //       result.add(list1Next.val);
  //       list1Next = list1Next.next;
  //     } else if (list1Next.val < list2Next.val) {
  //       result.add(list1Next.val);
  //       list1Next = list1Next.next;
  //     } else {
  //       result.add(list2Next.val);
  //       list2Next = list2Next.next;
  //     }
  //   }
  //   ListNode? resultNext;

  //   for (var i = result.length - 1; i >= 0; i--) {
  //     resultNext = ListNode(result[i], resultNext);
  //   }

  //   return resultNext;
  // }
}

/// ---------- Helper Methods ----------

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

/// Helper to convert Linked List back to List for easy comparison
List<int> nodesToList(ListNode? head) {
  List<int> result = [];
  while (head != null) {
    result.add(head.val);
    head = head.next;
  }
  return result;
}

/// ---------- Tests ----------

void runTests() {
  final Solution s = Solution();

  group('Merge Two Sorted Lists', () {
    /// Example cases
    test('Example 1: [1,2,4] + [1,3,4] → [1,1,2,3,4,4]', () {
      final l1 = listToNodes([1, 2, 4]);
      final l2 = listToNodes([1, 3, 4]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 1, 2, 3, 4, 4]));
    });

    test('Example 2: [] + [] → []', () {
      final l1 = listToNodes([]);
      final l2 = listToNodes([]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([]));
    });

    test('Example 3: [] + [0] → [0]', () {
      final l1 = listToNodes([]);
      final l2 = listToNodes([0]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([0]));
    });

    /// Edge cases
    test('One empty, one non-empty', () {
      final l1 = listToNodes([5, 6, 7]);
      final l2 = listToNodes([]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([5, 6, 7]));
    });

    test('Single element each (equal)', () {
      final l1 = listToNodes([1]);
      final l2 = listToNodes([1]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 1]));
    });

    test('Single element each (different)', () {
      final l1 = listToNodes([1]);
      final l2 = listToNodes([2]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2]));
    });

    /// All elements from one list smaller
    test('All elements of list1 smaller than list2', () {
      final l1 = listToNodes([1, 2, 3]);
      final l2 = listToNodes([4, 5, 6]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2, 3, 4, 5, 6]));
    });

    test('All elements of list2 smaller than list1', () {
      final l1 = listToNodes([4, 5, 6]);
      final l2 = listToNodes([1, 2, 3]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2, 3, 4, 5, 6]));
    });

    /// Interleaving elements
    test('Interleaving lists', () {
      final l1 = listToNodes([1, 3, 5]);
      final l2 = listToNodes([2, 4, 6]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2, 3, 4, 5, 6]));
    });

    /// Duplicates
    test('Lists with duplicates', () {
      final l1 = listToNodes([1, 1, 2]);
      final l2 = listToNodes([1, 3, 3]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 1, 1, 2, 3, 3]));
    });

    /// Negative numbers
    test('Lists with negative numbers', () {
      final l1 = listToNodes([-10, -3, 0]);
      final l2 = listToNodes([-5, 2, 4]);
      expect(
          nodesToList(s.mergeTwoLists(l1, l2)), equals([-10, -5, -3, 0, 2, 4]));
    });

    /// Zeros
    test('Lists with zeros', () {
      final l1 = listToNodes([0, 0, 0]);
      final l2 = listToNodes([0, 0]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)), equals([0, 0, 0, 0, 0]));
    });

    /// Different lengths
    test('Different lengths (list1 longer)', () {
      final l1 = listToNodes([1, 2, 3, 7, 8]);
      final l2 = listToNodes([4, 5]);
      expect(
          nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2, 3, 4, 5, 7, 8]));
    });

    test('Different lengths (list2 longer)', () {
      final l1 = listToNodes([2, 4]);
      final l2 = listToNodes([1, 3, 5, 6, 7]);
      expect(
          nodesToList(s.mergeTwoLists(l1, l2)), equals([1, 2, 3, 4, 5, 6, 7]));
    });

    /// Maximum constraint case (50 elements)
    test('Maximum constraint size (50 elements total)', () {
      final l1 = listToNodes(List.generate(25, (i) => i * 2));
      final l2 = listToNodes(List.generate(25, (i) => i * 2 + 1));
      final result = nodesToList(s.mergeTwoLists(l1, l2));
      expect(result.length, equals(50));
      expect(result, equals(List.generate(50, (i) => i)));
    });

    /// Already merged scenario
    test('Already perfectly merged pattern', () {
      final l1 = listToNodes([1, 4, 7]);
      final l2 = listToNodes([2, 3, 5, 6, 8]);
      expect(nodesToList(s.mergeTwoLists(l1, l2)),
          equals([1, 2, 3, 4, 5, 6, 7, 8]));
    });
  });
}
