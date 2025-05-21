// https://leetcode.com/problems/merge-sorted-array/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro Sec');
}

class Solution {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    if (n == 0) return;
    int nums1Index = m - 1;
    int nums2Index = n - 1;

    for (int i = nums1.length - 1; i >= 0; i--) {
      if (nums2Index == -1) {
        break;
      } else if (nums1Index < 0) {
        nums1[i] = nums2[nums2Index];
        nums2Index--;
      } else if (nums1[nums1Index] >= nums2[nums2Index]) {
        nums1[i] = nums1[nums1Index];
        nums1Index--;
      } else if (nums1[nums1Index] < nums2[nums2Index]) {
        nums1[i] = nums2[nums2Index];
        nums2Index--;
      }
    }
  }
}

void runTests() {
  final Solution s = Solution();

  group('Merge Sorted Array', () {
    // Basic examples from problem statement
    test(
        'Example 1: nums1=[1,2,3,0,0,0], m=3, nums2=[2,5,6], n=3 → [1,2,2,3,5,6]',
        () {
      final nums1 = [1, 2, 3, 0, 0, 0];
      s.merge(nums1, 3, [2, 5, 6], 3);
      expect(nums1, equals([1, 2, 2, 3, 5, 6]));
    });

    test('Example 2: nums1=[1], m=1, nums2=[], n=0 → [1]', () {
      final nums1 = [1];
      s.merge(nums1, 1, [], 0);
      expect(nums1, equals([1]));
    });

    test('Example 3: nums1=[0], m=0, nums2=[1], n=1 → [1]', () {
      final nums1 = [0];
      s.merge(nums1, 0, [1], 1);
      expect(nums1, equals([1]));
    });

    // Edge cases
    test('Empty nums1 and nums2: nums1=[], m=0, nums2=[], n=0 → []', () {
      final nums1 = <int>[];
      s.merge(nums1, 0, [], 0);
      expect(nums1, equals([]));
    });

    test(
        'nums1 empty, nums2 has elements: nums1=[0,0], m=0, nums2=[1,2], n=2 → [1,2]',
        () {
      final nums1 = [0, 0];
      s.merge(nums1, 0, [1, 2], 2);
      expect(nums1, equals([1, 2]));
    });

    test(
        'nums2 empty, nums1 has elements: nums1=[1,2], m=2, nums2=[], n=0 → [1,2]',
        () {
      final nums1 = [1, 2];
      s.merge(nums1, 2, [], 0);
      expect(nums1, equals([1, 2]));
    });

    // All elements from nums2 are smaller
    test(
        'All nums2 smaller: nums1=[4,5,6,0,0], m=3, nums2=[1,2], n=2 → [1,2,4,5,6]',
        () {
      final nums1 = [4, 5, 6, 0, 0];
      s.merge(nums1, 3, [1, 2], 2);
      expect(nums1, equals([1, 2, 4, 5, 6]));
    });

    // All elements from nums2 are larger
    test(
        'All nums2 larger: nums1=[1,2,3,0,0], m=3, nums2=[4,5], n=2 → [1,2,3,4,5]',
        () {
      final nums1 = [1, 2, 3, 0, 0];
      s.merge(nums1, 3, [4, 5], 2);
      expect(nums1, equals([1, 2, 3, 4, 5]));
    });

    // Interleaved elements
    test(
        'Interleaved elements: nums1=[1,3,5,0,0,0], m=3, nums2=[2,4,6], n=3 → [1,2,3,4,5,6]',
        () {
      final nums1 = [1, 3, 5, 0, 0, 0];
      s.merge(nums1, 3, [2, 4, 6], 3);
      expect(nums1, equals([1, 2, 3, 4, 5, 6]));
    });

    // Large arrays
    test('Large arrays', () {
      final nums1 = List.generate(100, (i) => i * 2) + List.filled(100, 0);
      final nums2 = List.generate(100, (i) => i * 2 + 1);
      final expected = List.generate(200, (i) => i);
      s.merge(nums1, 100, nums2, 100);
      expect(nums1, equals(expected));
    });

    // Maximum constraints
    test('Maximum length arrays', () {
      final nums1 = List.generate(200, (i) => i) + List.filled(200, 0);
      final nums2 = List.generate(200, (i) => i + 200);
      final expected = List.generate(400, (i) => i);
      s.merge(nums1, 200, nums2, 200);
      expect(nums1, equals(expected));
    });

    // Duplicate values
    test(
        'Duplicate values: nums1=[1,2,2,0,0], m=3, nums2=[2,3], n=2 → [1,2,2,2,3]',
        () {
      final nums1 = [1, 2, 2, 0, 0];
      s.merge(nums1, 3, [2, 3], 2);
      expect(nums1, equals([1, 2, 2, 2, 3]));
    });

    // Random cases
    test(
        'Random case 1: nums1=[1,3,5,0,0,0], m=3, nums2=[2,4,6], n=3 → [1,2,3,4,5,6]',
        () {
      final nums1 = [1, 3, 5, 0, 0, 0];
      s.merge(nums1, 3, [2, 4, 6], 3);
      expect(nums1, equals([1, 2, 3, 4, 5, 6]));
    });

    test(
        'Random case 2: nums1=[2,4,6,0,0], m=3, nums2=[1,3], n=2 → [1,2,3,4,6]',
        () {
      final nums1 = [2, 4, 6, 0, 0];
      s.merge(nums1, 3, [1, 3], 2);
      expect(nums1, equals([1, 2, 3, 4, 6]));
    });

    /// Leet code
    test('Leetcode: nums1=[2,0], m=1, nums2=[1], n=1 → [1,2]', () {
      final nums1 = [2, 0];
      s.merge(nums1, 1, [1], 1);
      expect(nums1, equals([1, 2]));
    });

    test(
        'Leetcode: nums1=[4,5,6,0,0,0], m=3, nums2=[1,2,3], n=3 → [1,2,3,4,5,6]',
        () {
      final nums1 = [4, 5, 6, 0, 0, 0];
      s.merge(nums1, 3, [1, 2, 3], 3);
      expect(nums1, equals([1, 2, 3, 4, 5, 6]));
    });
  });
}
