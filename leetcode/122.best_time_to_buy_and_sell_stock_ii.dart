// https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/

import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  ////! Solved the problem in TC: O(n) time and SC: O(1) space
  int maxProfit(List<int> prices) {
    int totalProfit = 0;
    for (int i = 1; i < prices.length; i++) {
      if (prices[i - 1] < prices[i]) {
        totalProfit += prices[i] - prices[i - 1];
      }
    }
    return totalProfit;
  }

  ////! Solved the problem in TC: O(n) time and SC: O(1) space
  // int maxProfit(List<int> prices) {
  //   int buyIndex = 0;
  //   int totalProfit = 0;
  //   for (int i = 0; i < prices.length; i++) {
  //     if (prices[buyIndex] < prices[i]) {
  //       totalProfit += prices[i] - prices[buyIndex];
  //     }
  //     buyIndex = i;
  //   }
  //   return totalProfit;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Best Time to Buy and Sell Stock II', () {
    // Problem examples
    test('Example 1: [7,1,5,3,6,4] → 7', () {
      expect(s.maxProfit([7, 1, 5, 3, 6, 4]), equals(7));
    });

    test('Example 2: [1,2,3,4,5] → 4', () {
      expect(s.maxProfit([1, 2, 3, 4, 5]), equals(4));
    });

    test('Example 3: [7,6,4,3,1] → 0', () {
      expect(s.maxProfit([7, 6, 4, 3, 1]), equals(0));
    });

    // Edge cases
    test('Single day: [5] → 0', () {
      expect(s.maxProfit([5]), equals(0));
    });

    test('Two days increasing: [1,2] → 1', () {
      expect(s.maxProfit([1, 2]), equals(1));
    });

    test('Two days decreasing: [2,1] → 0', () {
      expect(s.maxProfit([2, 1]), equals(0));
    });

    // Multiple transactions
    test('Multiple peaks: [3,2,6,5,0,3] → 7', () {
      expect(s.maxProfit([3, 2, 6, 5, 0, 3]), equals(7));
    });

    test('All same price: [5,5,5,5] → 0', () {
      expect(s.maxProfit([5, 5, 5, 5]), equals(0));
    });

    // Complex scenarios
    test('Up-down-up pattern: [1,5,3,9] → 10', () {
      expect(s.maxProfit([1, 5, 3, 9]), equals(10));
    });

    test('Down-up-down pattern: [5,2,7,1] → 5', () {
      expect(s.maxProfit([5, 2, 7, 1]), equals(5));
    });

    test('Random fluctuation: [5,2,8,1,4,9,3] → 14', () {
      expect(s.maxProfit([5, 2, 8, 1, 4, 9, 3]), equals(14));
    });

    // Large inputs
    test('Large increasing array', () {
      final prices = List.generate(30000, (i) => i);
      expect(s.maxProfit(prices), equals(29999));
    });

    test('Large decreasing array', () {
      final prices = List.generate(30000, (i) => 30000 - i);
      expect(s.maxProfit(prices), equals(0));
    });

    // Boundary values
    test('Minimum price values: [0,0,0] → 0', () {
      expect(s.maxProfit([0, 0, 0]), equals(0));
    });

    test('Maximum price values: [10000,10000] → 0', () {
      expect(s.maxProfit([10000, 10000]), equals(0));
    });

    // Special cases
    test('Buy-sell same day: [1,1,1,2,2] → 1', () {
      expect(s.maxProfit([1, 1, 1, 2, 2]), equals(1));
    });

    test('All increasing except last day: [1,2,3,4,3] → 3', () {
      expect(s.maxProfit([1, 2, 3, 4, 3]), equals(3));
    });

    test('All decreasing except last day: [4,3,2,1,2] → 1', () {
      expect(s.maxProfit([4, 3, 2, 1, 2]), equals(1));
    });
  });
}
