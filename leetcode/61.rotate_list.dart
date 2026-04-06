// leetcode/61.rotate_list.dart
// https://leetcode.com/problems/rotate-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  // s.rotateRight(buildList([1, 2, 3, 4, 5]), 2);
  s.rotateRight(buildList([1, 2, 3, 4]), 1);
  // s.rotateRight(buildList([0, 1, 2]), 4);

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
  ListNode? rotateRight(ListNode? head, int k) {
    if (head == null || head.next == null || k == 0) return head;

    int length = 0;
    ListNode? node = head;
    ListNode? lastNode = head;
    while (node != null) {
      if (node.next == null) {
        lastNode = node;
      }
      node = node.next;
      length++;
    }

    k = k % length;
    if (k == 0) return head;

    lastNode?.next = head;
    node = head;

    /// Get the new last node what would be
    for (var i = 0; i < length - k - 1; i++) {
      node = node?.next;
    }
    final newLastNode = node;
    final newFirstNode = node?.next;
    newLastNode?.next = null;
    return newFirstNode;
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

  group('Rotate List', () {
    // ===== Examples =====
    test('Example 1: [1,2,3,4,5], k=2 -> [4,5,1,2,3]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.rotateRight(head, 2)), equals([4, 5, 1, 2, 3]));
    });

    test('Example 2: [0,1,2], k=4 -> [2,0,1]', () {
      final head = buildList([0, 1, 2]);
      expect(toList(s.rotateRight(head, 4)), equals([2, 0, 1]));
    });

    // ===== Edge Cases =====
    test('Empty list', () {
      final head = buildList([]);
      expect(toList(s.rotateRight(head, 5)), equals([]));
    });

    test('Single node', () {
      final head = buildList([10]);
      expect(toList(s.rotateRight(head, 100)), equals([10]));
    });

    // ===== k = 0 =====
    test('k = 0 should return same list', () {
      final head = buildList([1, 2, 3]);
      expect(toList(s.rotateRight(head, 0)), equals([1, 2, 3]));
    });

    // ===== k < length =====
    test('k = 1', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.rotateRight(head, 1)), equals([4, 1, 2, 3]));
    });

    test('k = 2', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.rotateRight(head, 2)), equals([3, 4, 1, 2]));
    });

    // ===== k == length =====
    test('k equals length', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.rotateRight(head, 4)), equals([1, 2, 3, 4]));
    });

    // ===== k > length =====
    test('k greater than length', () {
      final head = buildList([1, 2, 3]);
      expect(toList(s.rotateRight(head, 5)), equals([2, 3, 1]));
    });

    test('k much larger than length', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.rotateRight(head, 1000000000)), equals([1, 2, 3, 4, 5]));
    });

    // ===== Small Lists =====
    test('Two nodes k=1', () {
      final head = buildList([1, 2]);
      expect(toList(s.rotateRight(head, 1)), equals([2, 1]));
    });

    test('Two nodes k=2', () {
      final head = buildList([1, 2]);
      expect(toList(s.rotateRight(head, 2)), equals([1, 2]));
    });

    test('Edge Case: [1,2], k=1 -> [2,1]', () {
      final head = buildList([1, 2]);
      expect(toList(s.rotateRight(head, 1)), equals([2, 1]));
    });

    // ===== Negative values =====
    test('Negative values', () {
      final head = buildList([-1, -2, -3, -4]);
      expect(toList(s.rotateRight(head, 2)), equals([-3, -4, -1, -2]));
    });

    // ===== Mixed values =====
    test('Mixed values', () {
      final head = buildList([10, -5, 3, 8]);
      expect(toList(s.rotateRight(head, 3)), equals([-5, 3, 8, 10]));
    });

    // ===== Duplicate values =====
    test('All duplicates', () {
      final head = buildList([7, 7, 7, 7]);
      expect(toList(s.rotateRight(head, 2)), equals([7, 7, 7, 7]));
    });

    test('Mixed duplicates', () {
      final head = buildList([1, 2, 2, 3, 3]);
      expect(toList(s.rotateRight(head, 2)), equals([3, 3, 1, 2, 2]));
    });

    // ===== Increasing / Decreasing =====
    test('Increasing order', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.rotateRight(head, 3)), equals([4, 5, 6, 1, 2, 3]));
    });

    test('Decreasing order', () {
      final head = buildList([6, 5, 4, 3, 2, 1]);
      expect(toList(s.rotateRight(head, 2)), equals([2, 1, 6, 5, 4, 3]));
    });

    // ===== Boundary values =====
    test('Min values', () {
      final head = buildList(List.generate(5, (_) => -100));
      expect(toList(s.rotateRight(head, 3)),
          equals(List.generate(5, (_) => -100)));
    });

    test('Max values', () {
      final head = buildList(List.generate(5, (_) => 100));
      expect(
          toList(s.rotateRight(head, 1)), equals(List.generate(5, (_) => 100)));
    });

    // ===== Large Cases =====
    test('Large list size 100', () {
      final values = List.generate(100, (i) => i + 1);
      final head = buildList(values);
      final result = toList(s.rotateRight(head, 25));

      expect(result.length, equals(100));
      expect(result.first, equals(76));
      expect(result.last, equals(75));
    });

    test('Large list size 500', () {
      final values = List.generate(500, (i) => i);
      final head = buildList(values);
      final result = toList(s.rotateRight(head, 250));

      expect(result.length, equals(500));
      expect(result.first, equals(250));
      expect(result.last, equals(249));
    });

    // ===== Stability =====
    test('Rotation should preserve all values', () {
      final values = [1, 2, 3, 4, 5];
      final head = buildList(values);
      final result = toList(s.rotateRight(head, 3))..sort();

      expect(result, equals([...values]..sort()));
    });

    test('Length should remain unchanged', () {
      final values = [1, 2, 3, 4, 5];
      final head = buildList(values);
      expect(toList(s.rotateRight(head, 3)).length, equals(values.length));
    });
  });
}
