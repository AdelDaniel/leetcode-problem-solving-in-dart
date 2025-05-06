// https://leetcode.com/problems/product-of-array-except-self/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  ///
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! Enhance  Prefix Product And Better Solution
  ////! TC: O(2n) = O(n) --- SC: O(n)
  List<int> productExceptSelf(List<int> nums) {
    List<int> result = List.filled(nums.length, 1);
    int total = 1;
    int zerosCount = 0;
    for (int i = 1; i < nums.length; i++) {
      total *= nums[i - 1];
      result[i] = total;
      if (nums[i] == 0) zerosCount++;
      if (zerosCount >= 2) return List.filled(nums.length, 0);
    }
    total = 1;
    for (int i = nums.length - 2; i >= 0; i--) {
      total *= nums[i + 1];
      result[i] = total * result[i];
    }
    return result;
  }

  ////! Prefix Product From Udemy Video
  // List<int> productExceptSelf(List<int> nums) {
  //   List<int> prefixProduct = List.filled(nums.length, 1);
  //   prefixProduct[0] = 1;
  //   int zerosCount = 0;
  //   for (int i = 1; i < nums.length; i++) {
  //     prefixProduct[i] = prefixProduct[i - 1] * nums[i - 1];
  //     if (nums[i] == 0) zerosCount++;
  //     if (zerosCount >= 2) return List.filled(nums.length, 0);
  //   }
  //   int suffixProductTotal = 1;

  //   for (int i = nums.length - 1; i >= 0; i--) {
  //     prefixProduct[i] = prefixProduct[i] * suffixProductTotal;
  //     suffixProductTotal *= nums[i];
  //   }

  //   return prefixProduct;
  // }

  ////! Under Standing using prefix Product
  // List<int> productExceptSelf(List<int> nums) {
  //   List<int> right = List.filled(nums.length, 1);
  //   List<int> left = List.filled(nums.length, 1);
  //   List<int> result = List.filled(nums.length, 0);
  //   int total = 1;
  //   int zerosCount = 0;
  //   for (int i = 1; i < nums.length; i++) {
  //     total *= nums[i - 1];
  //     right[i] = total;
  //     result[i] = right[i];
  //     if (nums[i] == 0) zerosCount++;
  //     if (zerosCount >= 2) return List.filled(nums.length, 0);
  //   }
  //   total = 1;
  //   for (int i = nums.length - 2; i >= 0; i--) {
  //     total *= nums[i + 1];
  //     left[i] = total;
  //     result[i] = left[i] * right[i];
  //   }
  //   return result;
  // }

  ////! Accepted From the first time.  TC: O(2n) = O(n) --- SC: O(n)
  ////! Bad Solution With
  // List<int> productExceptSelf(List<int> nums) {
  //   List<int> result = List.filled(nums.length, 0);
  //   int total = 1;
  //   int zerosCount = 0;
  //   for (int i = 0; i < nums.length; i++) {
  //     if (nums[i] != 0) {
  //       total *= nums[i];
  //     } else {
  //       zerosCount++;
  //       if (zerosCount >= 2) break;
  //     }
  //   }
  //   if (zerosCount >= 2) return result;
  //   for (int i = 0; i < nums.length; i++) {
  //     if (nums[i] != 0 && zerosCount == 1) {
  //       result[i] = 0;
  //     } else if (nums[i] == 0 && zerosCount == 1) {
  //       result[i] = total;
  //     } else if (nums[i] != 0 && zerosCount != 1) {
  //       result[i] = total ~/ nums[i];
  //     }
  //   }
  //   return result;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Product of Array Except Self', () {
    // Basic examples from problem statement
    test('Example 1: [1,2,3,4] → [24,12,8,6]', () {
      expect(s.productExceptSelf([1, 2, 3, 4]), equals([24, 12, 8, 6]));
    });

    test('Example 2: [-1,1,0,-3,3] → [0,0,9,0,0]', () {
      expect(s.productExceptSelf([-1, 1, 0, -3, 3]), equals([0, 0, 9, 0, 0]));
    });

    // Edge cases
    test('Two elements: [3,5] → [5,3]', () {
      expect(s.productExceptSelf([3, 5]), equals([5, 3]));
    });

    test('Two elements with zero: [0,4] → [4,0]', () {
      expect(s.productExceptSelf([0, 4]), equals([4, 0]));
    });

    // Zero cases
    test('Single zero: [1,0,3] → [0,3,0]', () {
      expect(s.productExceptSelf([1, 0, 3]), equals([0, 3, 0]));
    });

    test('Multiple zeros: [0,2,0,4] → [0,0,0,0]', () {
      expect(s.productExceptSelf([0, 2, 0, 4]), equals([0, 0, 0, 0]));
    });

    // Negative numbers
    test('All negatives: [-2,-3,-4] → [12,8,6]', () {
      expect(s.productExceptSelf([-2, -3, -4]), equals([12, 8, 6]));
    });

    test('Mixed positives and negatives: [2,-1,3,-4] → [12,-24,8,-6]', () {
      expect(s.productExceptSelf([2, -1, 3, -4]), equals([12, -24, 8, -6]));
    });

    // Large numbers
    test('Large numbers: [10,20,30] → [600,300,200]', () {
      expect(s.productExceptSelf([10, 20, 30]), equals([600, 300, 200]));
    });

    test('With maximum constraint value: [30,30] → [30,30]', () {
      expect(s.productExceptSelf([30, 30]), equals([30, 30]));
    });

    // Minimum length case
    test('Minimum length array: [2,3] → [3,2]', () {
      expect(s.productExceptSelf([2, 3]), equals([3, 2]));
    });

    // Large array
    test('Large array with alternating 1s and 2s', () {
      final nums = List.generate(100000, (i) => i.isEven ? 1 : 2);
      final expected =
          List.generate(100000, (i) => i.isEven ? 1 << 99999 : 1 << 99998);
      expect(s.productExceptSelf(nums), equals(expected));
    });

    // Special cases
    test('All ones: [1,1,1,1] → [1,1,1,1]', () {
      expect(s.productExceptSelf([1, 1, 1, 1]), equals([1, 1, 1, 1]));
    });

    test('One element zero others one: [1,0,1,1] → [0,1,0,0]', () {
      expect(s.productExceptSelf([1, 0, 1, 1]), equals([0, 1, 0, 0]));
    });

    // Random cases
    test('Random case 1: [2,3,5,7] → [105,70,42,30]', () {
      expect(s.productExceptSelf([2, 3, 5, 7]), equals([105, 70, 42, 30]));
    });

    test('Random case 2: [1,2,3,0,5] → [0,0,0,30,0]', () {
      expect(s.productExceptSelf([1, 2, 3, 0, 5]), equals([0, 0, 0, 30, 0]));
    });
  });
}
