// leetcode/1855.maximum_distance_between_a_pair_of_values.dart
// https://leetcode.com/problems/maximum-distance-between-a-pair-of-values/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.maxDistance([55, 30, 5, 4, 2], [100, 20, 10, 10, 5]);

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  int maxDistance(List<int> nums1, List<int> nums2) {
    int i = 0;
    int j = 0;
    int distance = 0;
    while (i < nums1.length && j < nums2.length) {
      if (i <= j && nums1[i] <= nums2[j] && distance < j - i) {
        distance = j - i;
        j++;
      } else if (i <= j && nums1[i] > nums2[j]) {
        i++;
      } else {
        j++;
      }
    }
    return distance;
  }
}

void runTests() {
  final Solution s = Solution();

  group('Maximum Distance Between a Pair of Values', () {
    // ===== Examples =====
    test('Example 1: [55,30,5,4,2], [100,20,10,10,5] -> 2', () {
      final nums1 = [55, 30, 5, 4, 2];
      final nums2 = [100, 20, 10, 10, 5];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Example 2: [2,2,2], [10,10,1] -> 1', () {
      final nums1 = [2, 2, 2];
      final nums2 = [10, 10, 1];
      expect(s.maxDistance(nums1, nums2), equals(1));
    });

    test('Example 3: [30,29,19,5], [25,25,25,25,25] -> 2', () {
      final nums1 = [30, 29, 19, 5];
      final nums2 = [25, 25, 25, 25, 25];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    // ===== Minimum Size =====
    test('Single element valid pair -> 0', () {
      final nums1 = [1];
      final nums2 = [1];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    test('Single element invalid pair -> 0', () {
      final nums1 = [5];
      final nums2 = [3];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    // ===== Small Cases =====
    test('Two elements with cross pair valid -> 1', () {
      final nums1 = [4, 3];
      final nums2 = [5, 4];
      expect(s.maxDistance(nums1, nums2), equals(1));
    });

    test('Two elements but only same-index valid -> 0', () {
      final nums1 = [5, 4];
      final nums2 = [5, 4];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    test('Two arrays all equal -> 1', () {
      final nums1 = [4, 4];
      final nums2 = [4, 4];
      expect(s.maxDistance(nums1, nums2), equals(1));
    });

    test('Three elements all equal -> farthest full distance', () {
      final nums1 = [7, 7, 7];
      final nums2 = [7, 7, 7, 7, 7];
      expect(s.maxDistance(nums1, nums2), equals(4));
    });

    test('nums2 shorter but still can get distance', () {
      final nums1 = [7, 7, 7, 7, 7];
      final nums2 = [7, 7, 7];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    // ===== No / Limited Valid Pairs =====
    test('No valid pairs at all -> 0', () {
      final nums1 = [10, 9, 8];
      final nums2 = [7, 6, 5];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    test('Only last index valid -> 0', () {
      final nums1 = [100, 90, 80, 1];
      final nums2 = [50, 40, 30, 1];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    test('Only later indices valid with positive distance', () {
      final nums1 = [100, 90, 1, 1];
      final nums2 = [50, 50, 50, 50, 50];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Best pair starts after index 0', () {
      final nums1 = [30, 20, 10];
      final nums2 = [20, 20, 20, 20];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Best pair does not use last index of nums2', () {
      final nums1 = [9, 7, 5, 4];
      final nums2 = [8, 8, 8, 3];
      expect(s.maxDistance(nums1, nums2), equals(1));
    });

    // ===== Duplicate / Block Patterns =====
    test('Repeated blocks case 1', () {
      final nums1 = [5, 5, 4, 4, 1];
      final nums2 = [6, 5, 5, 4, 4, 1];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Repeated blocks case 2', () {
      final nums1 = [8, 8, 8, 3, 3];
      final nums2 = [9, 9, 8, 8, 8, 3, 3];
      expect(s.maxDistance(nums1, nums2), equals(4));
    });

    test('All values equal in both arrays', () {
      final nums1 = [2, 2, 2, 2];
      final nums2 = [2, 2, 2, 2, 2];
      expect(s.maxDistance(nums1, nums2), equals(4));
    });

    test('Identical strictly decreasing arrays -> 0', () {
      final nums1 = [9, 7, 5, 3, 1];
      final nums2 = [9, 7, 5, 3, 1];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    // ===== Boundary Values =====
    test('Uses minimum values', () {
      final nums1 = [1, 1, 1];
      final nums2 = [1, 1, 1, 1];
      expect(s.maxDistance(nums1, nums2), equals(3));
    });

    test('Uses maximum values', () {
      final nums1 = [100000, 99999, 1];
      final nums2 = [100000, 100000, 100000];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Maximum values but no spread', () {
      final nums1 = [100000, 100000];
      final nums2 = [1, 1, 1];
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    // ===== Mixed Structure Cases =====
    test('Valid pair from first index to far right', () {
      final nums1 = [9, 8, 7, 1];
      final nums2 = [10, 10, 10, 10, 10, 10];
      expect(s.maxDistance(nums1, nums2), equals(5));
    });

    test('Best pair uses middle of nums1 and end of nums2', () {
      final nums1 = [9, 8, 1, 1];
      final nums2 = [5, 5, 5, 5, 5];
      expect(s.maxDistance(nums1, nums2), equals(2));
    });

    test('Another mixed case with many valid pairs', () {
      final nums1 = [12, 11, 4, 2];
      final nums2 = [20, 20, 20, 10, 10, 5, 5];
      expect(s.maxDistance(nums1, nums2), equals(4));
    });

    test('Only one index in nums1 can stretch far', () {
      final nums1 = [100, 90, 80, 70, 1];
      final nums2 = [60, 60, 60, 60, 60, 60];
      expect(s.maxDistance(nums1, nums2), equals(1));
    });

    // ===== Larger Generated-Friendly Cases =====
    test('Length 100: all nums1 are 1 and all nums2 are 100000 -> 99', () {
      final nums1 = List.generate(100, (_) => 1);
      final nums2 = List.generate(100, (_) => 100000);
      expect(s.maxDistance(nums1, nums2), equals(99));
    });

    test('Length 100: identical descending arrays -> 0', () {
      final nums1 = List.generate(100, (i) => 100 - i);
      final nums2 = List.generate(100, (i) => 100 - i);
      expect(s.maxDistance(nums1, nums2), equals(0));
    });

    test('Length 100: constant nums1, descending nums2 -> 50', () {
      final nums1 = List.generate(100, (_) => 50);
      final nums2 = List.generate(100, (i) => 100 - i);
      expect(s.maxDistance(nums1, nums2), equals(50));
    });

    test('Length 100: first element differs from the rest -> 99', () {
      final nums1 = [0, ...List.generate(99, (_) => 0)];
      final nums2 = List.generate(100, (_) => 100);
      expect(s.maxDistance(nums1, nums2), equals(99));
    });

    test('Length 100: only last part of nums1 can match -> 49', () {
      final nums1 = [
        ...List.generate(50, (_) => 100),
        ...List.generate(50, (_) => 1),
      ];
      final nums2 = List.generate(100, (_) => 50);
      expect(s.maxDistance(nums1, nums2), equals(49));
    });

    // ===== Sanity / Trick Cases =====
    test('Answer should never be negative', () {
      final nums1 = [9, 8, 7];
      final nums2 = [1, 1, 1];
      final result = s.maxDistance(nums1, nums2);
      expect(result >= 0, isTrue);
    });

    test('Random-like sanity case 3', () {
      final nums1 = [60, 40, 20, 10, 5];
      final nums2 = [70, 70, 50, 50, 50, 20, 20];
      expect(s.maxDistance(nums1, nums2), equals(4));
    });
  });
}
