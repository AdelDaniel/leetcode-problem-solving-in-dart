// https://leetcode.com/problems/contains-duplicate-ii/description/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // GOOD: Function Execution Time : 000 micro sec
  // BAD : Function Execution Time : 000 micro sec
}

class Solution {
  ///! TC: O(n) SC: O(n)
  bool containsNearbyDuplicate(List<int> nums, int k) {
    final Map<int, int> map = <int, int>{};
    for (int i = 0; i < nums.length; i++) {
      if (map.containsKey(nums[i]) && i - map[nums[i]]! <= k) {
        return true;
      } else {
        map[nums[i]] = i;
      }
    }
    return false;
  }
}

void runTests() {
  final Solution s = Solution();

  for (var i = 0; i < 100; i++) {
    group('Contains Duplicate II', () {
      // Basic examples from problem statement
      test('Example 1: [1,2,3,1], k=3', () {
        expect(s.containsNearbyDuplicate([1, 2, 3, 1], 3), isTrue);
      });

      test('Example 2: [1,0,1,1], k=1', () {
        expect(s.containsNearbyDuplicate([1, 0, 1, 1], 1), isTrue);
      });

      test('Example 3: [1,2,3,1,2,3], k=2', () {
        expect(s.containsNearbyDuplicate([1, 2, 3, 1, 2, 3], 2), isFalse);
      });

      // Edge cases
      test('Single element array, k=0', () {
        expect(s.containsNearbyDuplicate([5], 0), isFalse);
      });

      test('Two identical elements, k=1', () {
        expect(s.containsNearbyDuplicate([7, 7], 1), isTrue);
      });

      test('Two identical elements, k=0', () {
        expect(s.containsNearbyDuplicate([7, 7], 0), isFalse);
      });

      test('Two distinct elements, k=1', () {
        expect(s.containsNearbyDuplicate([8, 9], 1), isFalse);
      });

      // k larger than array length
      test('k larger than array length', () {
        expect(s.containsNearbyDuplicate([1, 2, 3, 4], 5), isFalse);
      });

      // Duplicate just outside k window
      test('Duplicate just outside k window', () {
        expect(s.containsNearbyDuplicate([1, 2, 3, 1], 2), isFalse);
      });

      // Multiple duplicates in window
      test('Multiple duplicates in window', () {
        expect(s.containsNearbyDuplicate([1, 2, 3, 2, 4, 2], 2), isTrue);
      });

      // Large numbers
      test('Large numbers with duplicates', () {
        expect(
            s.containsNearbyDuplicate([1000000000, -1000000000, 1000000000], 2),
            isTrue);
      });

      // Large array tests
      test('Large array with nearby duplicates', () {
        final nums = List.generate(100000, (i) => i % 100)..add(99);
        expect(s.containsNearbyDuplicate(nums, 100), isTrue);
      });

      // k = 0 cases
      test('k=0 with duplicates', () {
        expect(s.containsNearbyDuplicate([1, 1], 0), isFalse);
      });

      test('k=0 without duplicates', () {
        expect(s.containsNearbyDuplicate([1, 2], 0), isFalse);
      });

      // Minimum and maximum constraints
      test('Minimum constraints', () {
        expect(s.containsNearbyDuplicate([1], 0), isFalse);
      });

      test('Maximum k value', () {
        expect(s.containsNearbyDuplicate([1, 2, 1], 100000), isTrue);
      });

      // Random test cases
      test('Random array with nearby duplicates', () {
        expect(s.containsNearbyDuplicate([4, 2, 7, 4, 1], 2), isFalse);
      });

      test('Random array with duplicates in window', () {
        expect(s.containsNearbyDuplicate([4, 2, 7, 4, 1, 4], 3), isTrue);
      });

      // Special cases
      test('All elements same, k=1', () {
        expect(s.containsNearbyDuplicate([5, 5, 5, 5], 1), isTrue);
      });

      test('All elements same, k=0', () {
        expect(s.containsNearbyDuplicate([5, 5, 5, 5], 0), isFalse);
      });

      // Negative k (though constraints say 0 <= k)
      test('Negative k (should handle gracefully)', () {
        expect(s.containsNearbyDuplicate([1, 2, 1], -1), isFalse);
      });
    });
  }
}
