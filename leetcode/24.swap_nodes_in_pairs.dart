// leetcode/24.swap_nodes_in_pairs.dart
// https://leetcode.com/problems/swap-nodes-in-pairs/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.swapPairs(buildList([1, 2, 3, 4]));

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
  /// Good
  ListNode? swapPairs(ListNode? head) {
    if (head == null || head.next == null) return head;
    ListNode? first = head;
    ListNode? second = head.next;
    return swap(first, second);
  }

  ListNode? swap(ListNode? first, ListNode? second) {
    if (first == null || second == null) return first;
    final secondSwappedNode = swap(second.next, second.next?.next);
    second.next = first;
    first.next = secondSwappedNode;
    return second;
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

  group('Swap Nodes in Pairs', () {
    // ===== Examples =====
    // test('Example 1: [1,2,3,4] -> [2,1,4,3]', () {
    //   final head = buildList([1, 2, 3, 4]);
    //   expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3]));
    // });

    test('Example 2: [] -> []', () {
      final head = buildList([]);
      expect(toList(s.swapPairs(head)), equals([]));
    });

    test('Example 3: [1] -> [1]', () {
      final head = buildList([1]);
      expect(toList(s.swapPairs(head)), equals([1]));
    });

    test('Example 4: [1,2,3] -> [2,1,3]', () {
      final head = buildList([1, 2, 3]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 3]));
    });

    // ===== Small edge cases =====
    test('Two nodes -> swapped', () {
      final head = buildList([1, 2]);
      expect(toList(s.swapPairs(head)), equals([2, 1]));
    });

    test('Four nodes -> two swaps', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3]));
    });

    test('Five nodes -> last remains', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3, 5]));
    });

    test('Six nodes -> all swapped', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3, 6, 5]));
    });

    // ===== Values with duplicates =====
    test('All duplicate values', () {
      final head = buildList([7, 7, 7, 7]);
      expect(toList(s.swapPairs(head)), equals([7, 7, 7, 7]));
    });

    test('Mixed duplicate values', () {
      final head = buildList([1, 1, 2, 2, 3, 3]);
      expect(toList(s.swapPairs(head)), equals([1, 1, 2, 2, 3, 3]));
    });

    test('Odd length with duplicates', () {
      final head = buildList([1, 1, 2, 2, 3]);
      expect(toList(s.swapPairs(head)), equals([1, 1, 2, 2, 3]));
    });

    // ===== Boundary values =====
    test('Minimum allowed values', () {
      final head = buildList([0, 0, 0, 0]);
      expect(toList(s.swapPairs(head)), equals([0, 0, 0, 0]));
    });

    test('Maximum allowed values', () {
      final head = buildList([100, 100, 100]);
      expect(toList(s.swapPairs(head)), equals([100, 100, 100]));
    });

    test('Mixed min and max values', () {
      final head = buildList([0, 100, 0, 100, 0]);
      expect(toList(s.swapPairs(head)), equals([100, 0, 100, 0, 0]));
    });

    // ===== Increasing / decreasing =====
    test('Increasing order odd length', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3, 6, 5, 7]));
    });

    test('Increasing order even length', () {
      final head = buildList([1, 2, 3, 4, 5, 6, 7, 8]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 4, 3, 6, 5, 8, 7]));
    });

    test('Decreasing order odd length', () {
      final head = buildList([7, 6, 5, 4, 3]);
      expect(toList(s.swapPairs(head)), equals([6, 7, 4, 5, 3]));
    });

    test('Decreasing order even length', () {
      final head = buildList([8, 7, 6, 5, 4, 3]);
      expect(toList(s.swapPairs(head)), equals([7, 8, 5, 6, 3, 4]));
    });

    // ===== Patterned inputs =====
    test('Alternating values odd length', () {
      final head = buildList([1, 2, 1, 2, 1]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 2, 1, 1]));
    });

    test('Alternating values even length', () {
      final head = buildList([1, 2, 1, 2, 1, 2]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 2, 1, 2, 1]));
    });

    test('Palindrome odd length', () {
      final head = buildList([1, 2, 3, 2, 1]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 2, 3, 1]));
    });

    test('Palindrome even length', () {
      final head = buildList([1, 2, 2, 1]);
      expect(toList(s.swapPairs(head)), equals([2, 1, 1, 2]));
    });

    // ===== Larger cases =====
    test('Large list size 100', () {
      final values = List.generate(100, (i) => i);
      final expected = <int>[];
      for (int i = 0; i < values.length; i += 2) {
        expected.add(values[i + 1]);
        expected.add(values[i]);
      }

      final head = buildList(values);
      expect(toList(s.swapPairs(head)), equals(expected));
    });

    test('Large list size 99', () {
      final values = List.generate(99, (i) => i + 1);
      final expected = <int>[];
      int i = 0;
      for (; i + 1 < values.length; i += 2) {
        expected.add(values[i + 1]);
        expected.add(values[i]);
      }
      if (i < values.length) expected.add(values[i]);

      final head = buildList(values);
      expect(toList(s.swapPairs(head)), equals(expected));
    });

    // ===== Stability / structure checks =====
    test('Length should remain unchanged', () {
      final values = [1, 2, 3, 4, 5];
      final head = buildList(values);
      expect(toList(s.swapPairs(head)).length, equals(values.length));
    });

    test('All original values should still exist after swapping', () {
      final values = [4, 1, 3, 2, 5, 6];
      final head = buildList(values);
      final result = toList(s.swapPairs(head))..sort();
      expect(result, equals([...values]..sort()));
    });

    test('Swapping twice should restore original order', () {
      final values = [1, 2, 3, 4, 5, 6];
      final head = buildList(values);
      final swapped = s.swapPairs(head);
      final restored = s.swapPairs(swapped);
      expect(toList(restored), equals(values));
    });
  });
}
