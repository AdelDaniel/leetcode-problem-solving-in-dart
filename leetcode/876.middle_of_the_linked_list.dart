// leetcode/876.middle_of_the_linked_list.dart
// https://leetcode.com/problems/middle-of-the-linked-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.middleNode(buildList([1, 2, 3, 4, 5]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class ListNode {
  int val;
  ListNode? next;
  ListNode(this.val, [this.next]);
}

class Solution {
  /// Best solution
  /// SC: O(1) not efficient
  ListNode? middleNode(ListNode? head) {
    
    if (head == null || head.next == null) return head;
    ListNode? slowPointer = head;
    ListNode? fastPointer = head;

    while (fastPointer?.next != null) {
      fastPointer = fastPointer?.next?.next;
      slowPointer = slowPointer?.next;
    }

    return slowPointer;
  }

  /// SC: O(n) not efficient
  // ListNode? middleNode(ListNode? head) {
  //   List<ListNode> values = [];
  //   ListNode? next = head;
  //   while (next != null) {
  //     values.add(next);
  //     next = next.next;
  //   }

  //   return values[values.length ~/ 2];
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

  group('Middle of the Linked List', () {
    // Example 1: Odd length list
    test('Example 1: [1,2,3,4,5] -> [3,4,5]', () {
      final head = buildList([1, 2, 3, 4, 5]);
      expect(toList(s.middleNode(head)), equals([3, 4, 5]));
    });

    // Example 2: Even length list, return second middle
    test('Example 2: [1,2,3,4,5,6] -> [4,5,6]', () {
      final head = buildList([1, 2, 3, 4, 5, 6]);
      expect(toList(s.middleNode(head)), equals([4, 5, 6]));
    });

    // Edge Case: Single node
    test('Single node list', () {
      final head = buildList([1]);
      expect(toList(s.middleNode(head)), equals([1]));
    });

    // Edge Case: Two nodes, return second
    test('Two nodes -> second node is middle', () {
      final head = buildList([1, 2]);
      expect(toList(s.middleNode(head)), equals([2]));
    });

    // Small odd list
    test('Three nodes -> middle is second node', () {
      final head = buildList([1, 2, 3]);
      expect(toList(s.middleNode(head)), equals([2, 3]));
    });

    // Small even list
    test('Four nodes -> second middle is third node', () {
      final head = buildList([1, 2, 3, 4]);
      expect(toList(s.middleNode(head)), equals([3, 4]));
    });

    // Duplicate values
    test('All duplicate values odd length', () {
      final head = buildList([7, 7, 7, 7, 7]);
      expect(toList(s.middleNode(head)), equals([7, 7, 7]));
    });

    test('All duplicate values even length', () {
      final head = buildList([9, 9, 9, 9, 9, 9]);
      expect(toList(s.middleNode(head)), equals([9, 9, 9]));
    });

    // Increasing sequence
    test('Increasing values odd length', () {
      final head = buildList([10, 20, 30, 40, 50, 60, 70]);
      expect(toList(s.middleNode(head)), equals([40, 50, 60, 70]));
    });

    test('Increasing values even length', () {
      final head = buildList([10, 20, 30, 40, 50, 60, 70, 80]);
      expect(toList(s.middleNode(head)), equals([50, 60, 70, 80]));
    });

    // Decreasing sequence
    test('Decreasing values odd length', () {
      final head = buildList([7, 6, 5, 4, 3, 2, 1]);
      expect(toList(s.middleNode(head)), equals([4, 3, 2, 1]));
    });

    test('Decreasing values even length', () {
      final head = buildList([8, 7, 6, 5, 4, 3, 2, 1]);
      expect(toList(s.middleNode(head)), equals([4, 3, 2, 1]));
    });

    // Minimum and maximum values within constraints
    test('Minimum value repeated', () {
      final head = buildList([1, 1, 1, 1, 1, 1, 1]);
      expect(toList(s.middleNode(head)), equals([1, 1, 1, 1]));
    });

    test('Maximum value repeated', () {
      final head = buildList([100, 100, 100, 100]);
      expect(toList(s.middleNode(head)), equals([100, 100]));
    });

    // Mixed random values
    test('Mixed values odd length', () {
      final head = buildList([2, 8, 1, 9, 3]);
      expect(toList(s.middleNode(head)), equals([1, 9, 3]));
    });

    test('Mixed values even length', () {
      final head = buildList([4, 1, 7, 2, 8, 6]);
      expect(toList(s.middleNode(head)), equals([2, 8, 6]));
    });

    // Alternating values
    test('Alternating values odd length', () {
      final head = buildList([1, 2, 1, 2, 1]);
      expect(toList(s.middleNode(head)), equals([1, 2, 1]));
    });

    test('Alternating values even length', () {
      final head = buildList([1, 2, 1, 2, 1, 2]);
      expect(toList(s.middleNode(head)), equals([2, 1, 2]));
    });

    // Palindrome style input
    test('Palindrome odd length', () {
      final head = buildList([1, 2, 3, 2, 1]);
      expect(toList(s.middleNode(head)), equals([3, 2, 1]));
    });

    test('Palindrome even length', () {
      final head = buildList([1, 2, 3, 3, 2, 1]);
      expect(toList(s.middleNode(head)), equals([3, 2, 1]));
    });

    // Large constraints
    test('Max size 99 increasing', () {
      final values = List.generate(99, (i) => i + 1);
      final head = buildList(values);
      expect(toList(s.middleNode(head)), equals(values.sublist(49)));
    });

    test('Max size 100 increasing', () {
      final values = List.generate(100, (i) => i + 1);
      final head = buildList(values);
      expect(toList(s.middleNode(head)), equals(values.sublist(50)));
    });

    test('Max size 100 all same values', () {
      final values = List.generate(100, (_) => 5);
      final head = buildList(values);
      expect(toList(s.middleNode(head)), equals(List.generate(50, (_) => 5)));
    });

    // Boundary middle checks
    test('Length 99 -> first value of returned list should be 50', () {
      final values = List.generate(99, (i) => i + 1);
      final head = buildList(values);
      expect(toList(s.middleNode(head)).first, equals(50));
    });

    test('Length 100 -> first value of returned list should be 51', () {
      final values = List.generate(100, (i) => i + 1);
      final head = buildList(values);
      expect(toList(s.middleNode(head)).first, equals(51));
    });
  });
}
