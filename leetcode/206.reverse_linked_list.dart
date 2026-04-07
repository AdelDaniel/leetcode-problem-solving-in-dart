// leetcode/206.reverse_linked_list.dart
// https://leetcode.com/problems/reverse-linked-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.reverseList(buildList([1, 2, 3, 4, 5]));

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
  /// Recursion Solution
  ListNode? reverseList(ListNode? head) {
    if (head == null || head.next == null) return head;
    return reversNode(head, head.next!);
  }

  ListNode? reversNode(ListNode current, ListNode next) {
    ListNode? head;
    if (next.next != null) {
      head = reversNode(current.next!, next.next!);
    } else {
      head = next;
    }

    current.next = null;
    next.next = current;
    return head;
  }

  // /// work with recursion
  // ListNode? reverseList(ListNode? head) {
  //   if (head == null) return head;
  //   return reverse(head, null);
  // }

  // ListNode? reverse(ListNode? head, ListNode? newHead) {
  //   if (head == null) return newHead;
  //   final next = head.next;
  //   head.next = newHead;
  //   return reverse(next, head);
  // }

  /// Solved --> Easier Solution --> Good Solution
  // ListNode? reverseList(ListNode? head) {
  //   if (head == null || head.next == null) return head;
  //   ListNode? currentHead = head;
  //   ListNode? nextHead = head.next;
  //   currentHead.next = null;
  //   while (nextHead != null) {
  //     final temp = nextHead.next;
  //     nextHead.next = currentHead;
  //     currentHead = nextHead;
  //     nextHead = temp;
  //   }

  //   return currentHead;
  // }
}

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

  group('Reverse Linked List', () {
    // ===== Basic Cases =====
    test('Example 1: [1,2,3,4,5] -> [5,4,3,2,1]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseList(head)), equals([5, 4, 3, 2, 1]));
    });

    test('Example 2: [1,2] -> [2,1]', () {
      final head = buildList([1, 2]);
      expect(toList(s.reverseList(head)), equals([2, 1]));
    });

    test('Example 3: [] -> []', () {
      final head = buildList([]);
      expect(toList(s.reverseList(head)), equals([]));
    });

    // ===== Edge Cases =====
    test('Single node', () {
      final head = buildList([10]);
      expect(toList(s.reverseList(head)), equals([10]));
    });

    test('Two nodes', () {
      final head = buildList([7, 8]);
      expect(toList(s.reverseList(head)), equals([8, 7]));
    });

    // ===== Small Lists =====
    test('Three nodes', () {
      final head = buildList([1, 2, 3]);
      expect(toList(s.reverseList(head)), equals([3, 2, 1]));
    });

    test('Four nodes', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.reverseList(head)), equals([4, 3, 2, 1]));
    });

    // ===== Negative Values =====
    test('Negative values', () {
      final head = buildList([-1, -2, -3, -4]);
      expect(toList(s.reverseList(head)), equals([-4, -3, -2, -1]));
    });

    test('Mixed negative and positive', () {
      final head = buildList([-10, 0, 10]);
      expect(toList(s.reverseList(head)), equals([10, 0, -10]));
    });

    // ===== Duplicate Values =====
    test('All duplicates', () {
      final head = buildList([5, 5, 5, 5]);
      expect(toList(s.reverseList(head)), equals([5, 5, 5, 5]));
    });

    test('Mixed duplicates', () {
      final head = buildList([1, 2, 2, 3, 3]);
      expect(toList(s.reverseList(head)), equals([3, 3, 2, 2, 1]));
    });

    // ===== Sorted Lists =====
    test('Increasing order', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.reverseList(head)), equals([6, 5, 4, 3, 2, 1]));
    });

    test('Decreasing order', () {
      final head = buildList([6, 5, 4, 3, 2, 1]);
      expect(toList(s.reverseList(head)), equals([1, 2, 3, 4, 5, 6]));
    });

    // ===== Special Patterns =====
    test('Alternating pattern', () {
      final head = buildList([1, 2, 1, 2, 1]);
      expect(toList(s.reverseList(head)),
          equals([1, 2, 1, 2, 1].reversed.toList()));
    });

    test('Palindrome list', () {
      final head = buildList([1, 2, 3, 2, 1]);
      expect(toList(s.reverseList(head)),
          equals([1, 2, 3, 2, 1].reversed.toList()));
    });

    // ===== Boundary Values =====
    test('Min constraint values', () {
      final head = buildList(List.generate(10, (_) => -5000));
      expect(
          toList(s.reverseList(head)), equals(List.generate(10, (_) => -5000)));
    });

    test('Max constraint values', () {
      final head = buildList(List.generate(10, (_) => 5000));
      expect(
          toList(s.reverseList(head)), equals(List.generate(10, (_) => 5000)));
    });

    // ===== Large Cases =====
    test('Large list size 100', () {
      final values = List.generate(100, (i) => i + 1);
      final head = buildList(values);
      expect(toList(s.reverseList(head)), equals(values.reversed.toList()));
    });

    test('Large list size 500', () {
      final values = List.generate(500, (i) => i);
      final head = buildList(values);
      expect(toList(s.reverseList(head)), equals(values.reversed.toList()));
    });

    test('Max constraint size 5000', () {
      final values = List.generate(5000, (i) => i);
      final head = buildList(values);
      final result = toList(s.reverseList(head));
      expect(result.first, equals(4999));
      expect(result.last, equals(0));
      expect(result.length, equals(5000));
    });

    // ===== Stability Tests =====
    test('Reverse twice should return original', () {
      final values = [1, 2, 3, 4, 5];
      final head = buildList(values);
      final reversed = s.reverseList(head);
      final restored = s.reverseList(reversed);
      expect(toList(restored), equals(values));
    });

    test('Multiple reversals consistency', () {
      final values = [10, 20, 30];
      final head = buildList(values);

      final r1 = s.reverseList(head);
      final r2 = s.reverseList(r1);
      final r3 = s.reverseList(r2);

      expect(toList(r3), equals(values.reversed.toList()));
    });
  });
}
