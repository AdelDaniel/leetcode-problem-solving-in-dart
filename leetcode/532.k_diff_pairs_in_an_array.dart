// https://leetcode.com/problems/k-diff-pairs-in-an-array/description/
import 'package:test/test.dart';

void main(List<String> args) {
  final stopwatch = Stopwatch()..start();
  runTests();

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  ////! Enhance My Hash Map solution
  ////! AI help
  ////! Best Time Solution
  int findPairs(List<int> nums, int k) {
    if (nums.isEmpty || k < 0) return 0;

    int pairsCount = 0;
    final Map<int, int> map = {};

    for (int num in nums) {
      map[num] = (map[num] ?? 0) + 1;
    }

    final mapKeys = map.keys;
    for (int num in mapKeys) {
      if (k == 0) {
        if (map[num]! > 1) pairsCount++;
      } else {
        int otherNumber = num + k;
        if (map.containsKey(otherNumber)) pairsCount++;
      }
    }
    return pairsCount;
  }

  ////!
  ////! My Solution and solved the problem
  ////! Hash Map
  // int findPairs(List<int> nums, int k) {
  //   if (nums.length <= 1) return 0;

  //   final Map<int, Set<int>> map = {};
  //   int pairsCount = 0;

  //   for (int num in nums) {
  //     /// Both Negative Number and positive number are calculated and counted
  //     if (map[num]?.length == 2) {
  //       continue;
  //     }

  //     /// Postive number == negative number
  //     if (k == 0) {
  //       if (map[num] == null) {
  //         map[num] = {};
  //       } else if (map[num]?.isEmpty == true) {
  //         map[num]?.add(num);
  //         pairsCount++;
  //       }
  //       continue;
  //     }

  //     if (map[num] == null) {
  //       map[num] = {};
  //     }

  //     /// Find positive other number i - k = positive number
  //     int positiveNumber = num - k;

  //     /// if we can add the current num to the positive number set
  //     /// then the positive number appeared before and its set isn't contains the current num
  //     if (map[positiveNumber] != null &&
  //         map[positiveNumber]?.contains(num) == false &&
  //         map[num]?.contains(positiveNumber) == false) {
  //       map[positiveNumber]?.add(num);
  //       map[num]?.add(positiveNumber);
  //       pairsCount++;
  //     }

  //     /// Find negative other number
  //     int negativeNumber = num + k;

  //     /// if we can add the current num to the negative number set
  //     /// then the negative number appeared before and its set isn't contains the current num
  //     if (map[negativeNumber] != null &&
  //         map[negativeNumber]?.contains(num) == false &&
  //         map[num]?.contains(negativeNumber) == false) {
  //       map[negativeNumber]?.add(num);
  //       map[num]?.add(negativeNumber);
  //       pairsCount++;
  //     }
  //   }
  //   return pairsCount;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('K-diff Pairs in an Array', () {
    // Basic examples from problem statement
    test('Example 1: [3,1,4,1,5], k=2 → 2', () {
      expect(s.findPairs([3, 1, 4, 1, 5], 2), equals(2));
    });

    test('Example 2: [1,2,3,4,5], k=1 → 4', () {
      expect(s.findPairs([1, 2, 3, 4, 5], 1), equals(4));
    });

    test('Example 3: [1,3,1,5,4], k=0 → 1', () {
      expect(s.findPairs([1, 3, 1, 5, 4], 0), equals(1));
    });

    // Edge cases
    test('Single element array: [1], k=1 → 0', () {
      expect(s.findPairs([1], 1), equals(0));
    });

    test('Two elements with k=1: [1,2], k=1 → 1', () {
      expect(s.findPairs([1, 2], 1), equals(1));
    });

    test('Two identical elements with k=0: [1,1], k=0 → 1', () {
      expect(s.findPairs([1, 1], 0), equals(1));
    });

    // k=0 cases
    test('Multiple duplicates with k=0: [1,1,1,1], k=0 → 1', () {
      expect(s.findPairs([1, 1, 1, 1], 0), equals(1));
    });

    test('No duplicates with k=0: [1,2,3], k=0 → 0', () {
      expect(s.findPairs([1, 2, 3], 0), equals(0));
    });

    // Large k
    test('Large k: [1,10000000], k=9999999 → 1', () {
      expect(s.findPairs([1, 10000000], 9999999), equals(1));
    });

    test('k larger than any pair: [1,2,3], k=10 → 0', () {
      expect(s.findPairs([1, 2, 3], 10), equals(0));
    });

    // Negative numbers
    test('Negative numbers: [-1,-2,-3], k=1 → 2', () {
      expect(s.findPairs([-1, -2, -3], 1), equals(2));
    });

    // Large array
    test('Large array with k=1', () {
      final nums = List.generate(10000, (i) => i);
      expect(s.findPairs(nums, 1), equals(9999));
    });

    test('Large array with k=0 (all unique)', () {
      final nums = List.generate(10000, (i) => i);
      expect(s.findPairs(nums, 0), equals(0));
    });

    // Duplicate handling
    test('Multiple duplicates: [1,1,2,2,3,3], k=1 → 2', () {
      expect(s.findPairs([1, 1, 2, 2, 3, 3], 1), equals(2));
    });

    // Maximum constraints
    test('Maximum k with minimum nums', () {
      expect(s.findPairs([1], 10000000), equals(0));
    });

    test('Maximum value difference', () {
      expect(s.findPairs([-10000000, 10000000], 20000000), equals(1));
    });

    // Random cases
    test('Random case 2: [1,2,3,4,5,6], k=3 → 3', () {
      expect(s.findPairs([1, 2, 3, 4, 5, 6], 3), equals(3));
    });

    // Leet code
    test('Leet code: [1,1,1,1,1], k=0 → 1', () {
      expect(s.findPairs([1, 1, 1, 1, 1], 0), equals(1));
    });
  });
}
