// leetcode/25.reverse_nodes_in_k_group.dart
// https://leetcode.com/problems/reverse-nodes-in-k-group/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.reverseKGroup(buildList([1, 2, 3, 4, 5]), 2);

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
  ListNode? reverseKGroup(ListNode? head, int k) {
    if (head == null || head.next == null || k == 0) return head;

    /// Get the tail of the current List
    ListNode? tail = head;
    for (var i = 0; i < k - 1; i++) {
      tail = tail?.next;
      if (tail == null) {
        return head;
      }
    }

    ListNode? nextHead = tail?.next;
    tail?.next = null;
    final updatedNextHead = reverseKGroup(nextHead, k);
    final newHeadAfterReverse = reverseSubList(head);

    ListNode? newTailAfterReverse = newHeadAfterReverse;
    while (newTailAfterReverse?.next != null) {
      newTailAfterReverse = newTailAfterReverse?.next;
    }

    newTailAfterReverse?.next = updatedNextHead;
    return newHeadAfterReverse;
  }

  ListNode? reverseSubList(ListNode? head) {
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

  group('Reverse Nodes in k-Group', () {
    // ===== Examples =====
    test('Example 1: [1,2,3,4,5], k=2 -> [2,1,4,3,5]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseKGroup(head, 2)), equals([2, 1, 4, 3, 5]));
    });

    test('Example 2: [1,2,3,4,5], k=3 -> [3,2,1,4,5]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseKGroup(head, 3)), equals([3, 2, 1, 4, 5]));
    });

    // ===== Basic Edge Cases =====
    test('Single node, k=1', () {
      final head = buildList([1]);
      expect(toList(s.reverseKGroup(head, 1)), equals([1]));
    });

    test('Single node, k=1 with max allowed single value', () {
      final head = buildList([1000]);
      expect(toList(s.reverseKGroup(head, 1)), equals([1000]));
    });

    test('Two nodes, k=1 -> unchanged', () {
      final head = buildList([1, 2]);
      expect(toList(s.reverseKGroup(head, 1)), equals([1, 2]));
    });

    test('Two nodes, k=2 -> fully reversed', () {
      final head = buildList([1, 2]);
      expect(toList(s.reverseKGroup(head, 2)), equals([2, 1]));
    });

    // ===== k equals list length =====
    test('k equals length: [1,2,3,4], k=4 -> full reverse', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.reverseKGroup(head, 4)), equals([4, 3, 2, 1]));
    });

    test('k equals length: [1,2,3,4,5], k=5 -> full reverse', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseKGroup(head, 5)), equals([5, 4, 3, 2, 1]));
    });

    // ===== k = 1 =====
    test('k=1 should keep odd length list unchanged', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseKGroup(head, 1)), equals([1, 2, 3, 4, 5]));
    });

    test('k=1 should keep even length list unchanged', () {
      final head = buildList([2, 4, 6, 8]);
      expect(toList(s.reverseKGroup(head, 1)), equals([2, 4, 6, 8]));
    });

    // ===== Length not multiple of k =====
    test('Length not multiple of k: [1,2,3,4,5], k=4 -> [4,3,2,1,5]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.reverseKGroup(head, 4)), equals([4, 3, 2, 1, 5]));
    });

    test('Length not multiple of k: [1,2,3,4,5,6,7], k=3 -> [3,2,1,6,5,4,7]',
        () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7]);
      expect(toList(s.reverseKGroup(head, 3)), equals([3, 2, 1, 6, 5, 4, 7]));
    });

    test(
        'Length not multiple of k: [1,2,3,4,5,6,7,8], k=3 -> [3,2,1,6,5,4,7,8]',
        () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8]);
      expect(
          toList(s.reverseKGroup(head, 3)), equals([3, 2, 1, 6, 5, 4, 7, 8]));
    });

    // ===== Exact multiple of k =====
    test('Exact multiple: [1,2,3,4,5,6], k=2 -> [2,1,4,3,6,5]', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.reverseKGroup(head, 2)), equals([2, 1, 4, 3, 6, 5]));
    });

    test('Exact multiple: [1,2,3,4,5,6], k=3 -> [3,2,1,6,5,4]', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.reverseKGroup(head, 3)), equals([3, 2, 1, 6, 5, 4]));
    });

    test('Exact multiple: [1,2,3,4,5,6,7,8], k=4 -> [4,3,2,1,8,7,6,5]', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8]);
      expect(
          toList(s.reverseKGroup(head, 4)), equals([4, 3, 2, 1, 8, 7, 6, 5]));
    });

    // ===== Duplicate values =====
    test('All duplicate values, k=2', () {
      final head = buildList([5, 5, 5, 5, 5, 5]);
      expect(toList(s.reverseKGroup(head, 2)), equals([5, 5, 5, 5, 5, 5]));
    });

    test('Mixed duplicates, k=3', () {
      final head = buildList([1, 1, 2, 2, 3, 3]);
      expect(toList(s.reverseKGroup(head, 3)), equals([2, 1, 1, 3, 3, 2]));
    });

    // ===== Values near constraints =====
    test('Min allowed values with k=2', () {
      final head = buildList([0, 0, 0, 0]);
      expect(toList(s.reverseKGroup(head, 2)), equals([0, 0, 0, 0]));
    });

    test('Max allowed values with k=3', () {
      final head = buildList([1000, 999, 1000, 999, 1000, 999]);
      expect(
        toList(s.reverseKGroup(head, 3)),
        equals([1000, 999, 1000, 999, 1000, 999]),
      );
    });

    // ===== Increasing patterns =====
    test('Increasing list, k=2', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8]);
      expect(
          toList(s.reverseKGroup(head, 2)), equals([2, 1, 4, 3, 6, 5, 8, 7]));
    });

    test('Increasing list, k=5', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(toList(s.reverseKGroup(head, 5)),
          equals([5, 4, 3, 2, 1, 6, 7, 8, 9]));
    });

    // ===== Alternating / patterned input =====
    test('Alternating values, k=2', () {
      final head = buildList([1, 2, 1, 2, 1, 2]);
      expect(toList(s.reverseKGroup(head, 2)), equals([2, 1, 2, 1, 2, 1]));
    });

    test('Alternating values, k=4', () {
      final head = buildList([1, 2, 1, 2, 1, 2, 1]);
      expect(toList(s.reverseKGroup(head, 4)), equals([2, 1, 2, 1, 1, 2, 1]));
    });

    // ===== Many small groups =====
    test('k=2 over odd-length 9 nodes', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(toList(s.reverseKGroup(head, 2)),
          equals([2, 1, 4, 3, 6, 5, 8, 7, 9]));
    });

    test('k=2 over even-length 10 nodes', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(
        toList(s.reverseKGroup(head, 2)),
        equals([2, 1, 4, 3, 6, 5, 8, 7, 10, 9]),
      );
    });

    // ===== Large cases =====
    test('Large list of 100 nodes, k=10', () {
      final values = List.generate(100, (i) => i + 1);
      final expected = <int>[];
      for (int i = 0; i < 100; i += 10) {
        expected.addAll(values.sublist(i, i + 10).reversed);
      }

      final head = buildList(values);
      expect(toList(s.reverseKGroup(head, 10)), equals(expected));
    });

    test('Large list of 99 nodes, k=10 -> last 9 remain as-is', () {
      final values = List.generate(99, (i) => i + 1);
      final expected = <int>[];
      for (int i = 0; i < 90; i += 10) {
        expected.addAll(values.sublist(i, i + 10).reversed);
      }
      expected.addAll(values.sublist(90));

      final head = buildList(values);
      expect(toList(s.reverseKGroup(head, 10)), equals(expected));
    });

    test('Max constraint style check: 5000 nodes, k=100', () {
      final values = List.generate(5000, (i) => i % 1001);
      final head = buildList(values);
      final result = toList(s.reverseKGroup(head, 100));

      expect(result.length, equals(5000));

      // First group should be reversed
      expect(result.first, equals(values[99]));
      expect(result[99], equals(values[0]));

      // Last group exists exactly since 5000 % 100 == 0
      expect(result.last, equals(values[4900]));
    });

    // ===== Boundary k values =====
    test('k=n with 10 nodes', () {
      final values = List.generate(10, (i) => i + 1);
      final head = buildList(values);
      expect(
          toList(s.reverseKGroup(head, 10)), equals(values.reversed.toList()));
    });

    test('k=n-1 with 6 nodes -> last node remains', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.reverseKGroup(head, 5)), equals([5, 4, 3, 2, 1, 6]));
    });

    // ===== Consistency / structure checks =====
    test('Result length should remain unchanged', () {
      final values = [1, 2, 3, 4, 5, 6, 7];
      final head = buildList(values);
      expect(toList(s.reverseKGroup(head, 3)).length, equals(values.length));
    });

    test('All original values should still exist after regroup reversal', () {
      final values = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      final head = buildList(values);
      final result = toList(s.reverseKGroup(head, 4))..sort();
      expect(result, equals([...values]..sort()));
    });
  });
}
