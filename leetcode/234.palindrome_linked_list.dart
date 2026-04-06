// leetcode/234.palindrome_linked_list.dart
// https://leetcode.com/problems/palindrome-linked-list/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  final Solution s = Solution();
  s.isPalindrome(buildList([1, 2, 2, 1]));

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
  bool isPalindrome(ListNode? head) {
    if (head == null) return false;
    if (head.next == null) return true;

    /// Get the center node
    ListNode? slowNode = head;
    ListNode? fastNode = head.next;
    while (fastNode?.next != null) {
      slowNode = slowNode?.next;
      fastNode = fastNode?.next?.next;
    }

    /// Reverse from the center to the end.
    ListNode? currentNode = slowNode;
    ListNode? nextNode = slowNode?.next;
    slowNode?.next = null;
    currentNode?.next = null;
    while (nextNode != null) {
      final temp = nextNode.next;
      nextNode.next = currentNode;
      currentNode = nextNode;
      nextNode = temp;
    }

    /// Compare between first part and the second reversed part
    ListNode? mainNode = head;
    ListNode? reversedNode = currentNode;
    while (mainNode != null) {
      if (mainNode.val != reversedNode?.val) {
        return false;
      }
      mainNode = mainNode.next;
      reversedNode = reversedNode?.next;
    }

    return true;
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

void runTests() {
  final Solution s = Solution();

  group('Palindrome Linked List', () {
    // ===== Examples =====
    test('Example 1: [1,2,2,1] -> true', () {
      final head = buildList([1, 2, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Example 2: [1,2] -> false', () {
      final head = buildList([1, 2]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Edge Cases =====
    test('Single node -> true', () {
      final head = buildList([1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Two equal nodes -> true', () {
      final head = buildList([7, 7]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Two different nodes -> false', () {
      final head = buildList([3, 4]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Small Odd Length =====
    test('[1,2,1] -> true', () {
      final head = buildList([1, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('[1,2,3] -> false', () {
      final head = buildList([1, 2, 3]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('[5,0,5] -> true', () {
      final head = buildList([5, 0, 5]);
      expect(s.isPalindrome(head), isTrue);
    });

    // ===== Small Even Length =====
    test('[1,2,2,1] -> true', () {
      final head = buildList([1, 2, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('[1,2,3,1] -> false', () {
      final head = buildList([1, 2, 3, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('[9,8,8,9] -> true', () {
      final head = buildList([9, 8, 8, 9]);
      expect(s.isPalindrome(head), isTrue);
    });

    // ===== Duplicate Values =====
    test('All same values odd length -> true', () {
      final head = buildList([4, 4, 4, 4, 4]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('All same values even length -> true', () {
      final head = buildList([6, 6, 6, 6, 6, 6]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Mostly duplicates but not palindrome -> false', () {
      final head = buildList([2, 2, 2, 3, 2]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Zeros / Allowed Range =====
    test('All zeros -> true', () {
      final head = buildList([0, 0, 0, 0]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Zeros mixed palindrome -> true', () {
      final head = buildList([0, 1, 0]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Zeros mixed non-palindrome -> false', () {
      final head = buildList([0, 1, 2, 0]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Odd Length Palindromes =====
    test('[1,2,3,2,1] -> true', () {
      final head = buildList([1, 2, 3, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('[1,2,3,4,1] -> false', () {
      final head = buildList([1, 2, 3, 4, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('[9,1,8,1,9] -> true', () {
      final head = buildList([9, 1, 8, 1, 9]);
      expect(s.isPalindrome(head), isTrue);
    });

    // ===== Even Length Palindromes =====
    test('[1,2,3,3,2,1] -> true', () {
      final head = buildList([1, 2, 3, 3, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('[1,2,3,4,2,1] -> false', () {
      final head = buildList([1, 2, 3, 4, 2, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('[8,7,6,6,7,8] -> true', () {
      final head = buildList([8, 7, 6, 6, 7, 8]);
      expect(s.isPalindrome(head), isTrue);
    });

    // ===== Near Palindrome Failures =====
    test('Mismatch at center-left -> false', () {
      final head = buildList([1, 2, 4, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Mismatch at center-right -> false', () {
      final head = buildList([1, 2, 3, 2, 2]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('Only last value breaks palindrome -> false', () {
      final head = buildList([1, 2, 3, 2, 9]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('Only first value breaks palindrome -> false', () {
      final head = buildList([9, 2, 3, 2, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Patterned Inputs =====
    test('Alternating palindrome odd length -> true', () {
      final head = buildList([1, 0, 1, 0, 1, 0, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Alternating non-palindrome even length -> false', () {
      final head = buildList([1, 0, 1, 0, 1, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    test('Wave pattern palindrome -> true', () {
      final head = buildList([1, 3, 5, 7, 5, 3, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    // ===== Longer Palindromes =====
    test('Long odd palindrome', () {
      final head = buildList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Long even palindrome', () {
      final head = buildList([1, 2, 3, 4, 4, 3, 2, 1]);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Long non-palindrome', () {
      final head = buildList([1, 2, 3, 4, 5, 3, 2, 1]);
      expect(s.isPalindrome(head), isFalse);
    });

    // ===== Large Cases =====
    test('Large palindrome size 1000', () {
      final firstHalf = List.generate(500, (i) => i % 10);
      final values = [...firstHalf, ...firstHalf.reversed];
      final head = buildList(values);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Large non-palindrome size 1000', () {
      final firstHalf = List.generate(500, (i) => i % 10);
      final values = [...firstHalf, ...firstHalf.reversed];
      values[999] = 9;
      final head = buildList(values);
      expect(s.isPalindrome(head), isFalse);
    });

    test('Large odd palindrome size 999', () {
      final firstHalf = List.generate(499, (i) => i % 10);
      final values = [...firstHalf, 7, ...firstHalf.reversed];
      final head = buildList(values);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Constraint-style large palindrome size 100000', () {
      final firstHalf = List.generate(50000, (i) => i % 10);
      final values = [...firstHalf, ...firstHalf.reversed];
      final head = buildList(values);
      expect(s.isPalindrome(head), isTrue);
    });

    test('Constraint-style large non-palindrome size 100000', () {
      final firstHalf = List.generate(50000, (i) => i % 10);
      final values = [...firstHalf, ...firstHalf.reversed];
      values[50000] = (values[50000] + 1) % 10;
      final head = buildList(values);
      expect(s.isPalindrome(head), isFalse);
    });
  });
}
