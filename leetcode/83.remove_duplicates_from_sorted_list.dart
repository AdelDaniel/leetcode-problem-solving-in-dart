// leetcode/83.remove_duplicates_from_sorted_list.dart
// https://leetcode.com/problems/remove-duplicates-from-sorted-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.deleteDuplicates(buildList([1, 1, 2]));

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
  ListNode? deleteDuplicates(ListNode? head) {
    if (head == null || head.next == null) return head;
    ListNode? node = head;
    while (node?.next != null) {
      if (node?.val == node?.next?.val) {
        node?.next = node.next?.next;
      } else {
        node = node?.next;
      }
    }

    return head;
  }
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

  group('Remove Duplicates from Sorted List', () {
    // ===== Examples =====
    test('Example 1: [1,1,2] -> [1,2]', () {
      final head = buildList([1, 1, 2]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2]));
    });

    test('Example 2: [1,1,2,3,3] -> [1,2,3]', () {
      final head = buildList([1, 1, 2, 3, 3]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3]));
    });

    // ===== Edge Cases =====
    test('Empty list', () {
      final head = buildList([]);
      expect(toList(s.deleteDuplicates(head)), equals([]));
    });

    test('Single node', () {
      final head = buildList([5]);
      expect(toList(s.deleteDuplicates(head)), equals([5]));
    });

    // ===== No duplicates =====
    test('No duplicates increasing', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 4, 5]));
    });

    test('No duplicates negative values', () {
      final head = buildList([-5, -3, -1, 0, 2]);
      expect(toList(s.deleteDuplicates(head)), equals([-5, -3, -1, 0, 2]));
    });

    // ===== All duplicates =====
    test('All same values', () {
      final head = buildList([2, 2, 2, 2, 2]);
      expect(toList(s.deleteDuplicates(head)), equals([2]));
    });

    test('All same negative values', () {
      final head = buildList([-1, -1, -1, -1]);
      expect(toList(s.deleteDuplicates(head)), equals([-1]));
    });

    // ===== Mixed duplicates =====
    test('Duplicates at beginning', () {
      final head = buildList([1, 1, 1, 2, 3, 4]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 4]));
    });

    test('Duplicates at end', () {
      final head = buildList([1, 2, 3, 4, 4, 4]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 4]));
    });

    test('Duplicates in middle', () {
      final head = buildList([1, 2, 2, 2, 3]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3]));
    });

    test('Multiple duplicate groups', () {
      final head = buildList([1, 1, 2, 3, 3, 4, 4, 5]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 4, 5]));
    });

    // ===== Alternating duplicates =====
    test('Alternating duplicates', () {
      final head = buildList([1, 1, 2, 2, 3, 3, 4, 4]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 4]));
    });

    // ===== Boundary values =====
    test('Min value duplicates', () {
      final head = buildList([-100, -100, -99, -99, -98]);
      expect(toList(s.deleteDuplicates(head)), equals([-100, -99, -98]));
    });

    test('Max value duplicates', () {
      final head = buildList([98, 99, 100, 100, 100]);
      expect(toList(s.deleteDuplicates(head)), equals([98, 99, 100]));
    });

    // ===== Large cases =====
    test('Large list with duplicates (size 300)', () {
      final values = <int>[];
      for (int i = 0; i < 100; i++) {
        values.add(i);
        values.add(i);
        values.add(i);
      }
      final head = buildList(values);
      final result = toList(s.deleteDuplicates(head));

      expect(result.length, equals(100));
      expect(result.first, equals(0));
      expect(result.last, equals(99));
    });

    test('Large list without duplicates (size 300)', () {
      final values = List.generate(300, (i) => i - 150);
      final head = buildList(values);
      expect(toList(s.deleteDuplicates(head)), equals(values));
    });

    // ===== Stability =====
    test('Order should remain sorted after removal', () {
      final head = buildList([1, 1, 2, 3, 3, 5, 5, 6]);
      expect(toList(s.deleteDuplicates(head)), equals([1, 2, 3, 5, 6]));
    });

    test('Result length should be <= original length', () {
      final values = [1, 1, 2, 2, 3, 3];
      final head = buildList(values);
      expect(toList(s.deleteDuplicates(head)).length <= values.length, isTrue);
    });
  });
}
