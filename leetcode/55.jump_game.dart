// https://leetcode.com/problems/jump-game/description/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();
  print(Solution().canJump([2, 2, 0, 1, 4]));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  bool canJump(List<int> nums) {
    /// only one index
    if (nums.length == 1) return true;
    int maxReachableIndex = nums[0];
    for (int i = 1; i < nums.length; i++) {
      if (i > maxReachableIndex) return false;
      if (i + nums[i] > maxReachableIndex) {
        maxReachableIndex = i + nums[i];
      }
    }
    return true;
  }

  //  bool canJump(List<int> nums) {
  //   int reachable = 0;

  //   /// this will iterate only the items that are reachable
  //   for (int i = 0; i < nums.length && i <= reachable; i++) {
  //     reachable = max(reachable, nums[i] + i);
  //     if (reachable >= nums.length - 1) return true;
  //   }
  //   return false;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Jump Game', () {
    // Basic examples from problem statement
    test('Example 1: [2,3,1,1,4] → true', () {
      expect(s.canJump([2, 3, 1, 1, 4]), isTrue);
    });

    test('Example : [1,2,3] → true', () {
      expect(s.canJump([1, 2, 3]), isTrue);
    });

    test('Example 2: [3,2,1,0,4] → false', () {
      expect(s.canJump([3, 2, 1, 0, 4]), isFalse);
    });

    // Edge cases
    test('Single element: [0] → true', () {
      expect(s.canJump([0]), isTrue);
    });

    test('Single element: [5] → true', () {
      expect(s.canJump([5]), isTrue);
    });

    test('Two elements reachable: [1,0] → true', () {
      expect(s.canJump([1, 0]), isTrue);
    });

    test('Two elements unreachable: [0,1] → false', () {
      expect(s.canJump([0, 1]), isFalse);
    });

    // All zeros
    test('All zeros reachable: [0,0,0,0] → false', () {
      expect(s.canJump([0, 0, 0, 0]), isFalse);
    });

    test('All zeros except last: [0,0,0,1] → false', () {
      expect(s.canJump([0, 0, 0, 1]), isFalse);
    });

    // Large jumps
    test('Large jump at start: [10,0,0,0,0] → true', () {
      expect(s.canJump([10, 0, 0, 0, 0]), isTrue);
    });

    test('Large jump in middle: [2,5,0,0] → true', () {
      expect(s.canJump([2, 5, 0, 0]), isTrue);
    });

    // Complex cases
    test('Complex reachable: [2,0,1,1,4] → true', () {
      expect(s.canJump([2, 0, 1, 1, 4]), isTrue);
    });

    test('Complex unreachable: [1,1,0,2,4] → false', () {
      expect(s.canJump([1, 1, 0, 2, 4]), isFalse);
    });

    // Maximum constraints
    test('Maximum length reachable', () {
      final nums = List.filled(10000, 1);
      expect(s.canJump(nums), isTrue);
    });

    test('Maximum jump value', () {
      expect(s.canJump([100000, 0]), isTrue);
    });

    test('Alternating unreachable: [1,0,2,0,1] → false', () {
      expect(s.canJump([1, 0, 2, 0, 1]), isFalse);
    });

    // Random cases
    test('Random reachable case', () {
      expect(s.canJump([2, 2, 0, 1, 4]), isTrue);
    });

    test('Random unreachable case', () {
      expect(s.canJump([1, 2, 0, 0, 1]), isFalse);
    });

    test('Random unreachable case', () {
      expect(s.canJump([4, 2, 0, 0, 1, 1, 4, 4, 4, 0, 4, 0]), isTrue);
    });
  });
}
