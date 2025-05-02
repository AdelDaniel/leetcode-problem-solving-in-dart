// https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
import 'package:test/test.dart';

void main() {
  runTests();
}

class Solution {
  //! Best Solution TC: O(N) SC: O(1)
  int maxProfit(List<int> prices) {
    int minBuyIndex = 0;
    int maxProfit = 0;

    for (int i = 0; i < prices.length; i++) {
      if (prices[minBuyIndex] > prices[i]) {
        minBuyIndex = i;
      }
      if (maxProfit < prices[i] - prices[minBuyIndex]) {
        maxProfit = prices[i] - prices[minBuyIndex];
      }
    }
    return maxProfit;
  }

  // //! Time Limit Exceeded ---- TC: O(N^2)
  // int maxProfit(List<int> prices) {
  //   int minBuyIndex = 0;
  //   int maxSellIndex = 1;
  //   int maxProfit = 0;

  //   for (int i = 0; i < prices.length; i++) {
  //     maxSellIndex = prices.length - i - 1;

  //     for (int j = 0; j < maxSellIndex; j++) {
  //       minBuyIndex = j;
  //       if (maxProfit < prices[maxSellIndex] - prices[minBuyIndex]) {
  //         maxProfit = prices[maxSellIndex] - prices[minBuyIndex];
  //       }
  //     }

  //     // print("minBuyIndex: $minBuyIndex => ${prices[minBuyIndex]}");
  //     // print("maxSellIndex: $maxSellIndex => ${prices[maxSellIndex]}");
  //     // print(maxProfit);
  //   }
  //   return maxProfit;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Best Time to Buy and Sell Stock', () {
    test('Example 1: [7,1,5,3,6,4]', () {
      expect(s.maxProfit([7, 1, 5, 3, 6, 4]), equals(5));
    });

    test('Example 2: [7,6,4,3,1]', () {
      expect(s.maxProfit([7, 6, 4, 3, 1]), equals(0));
    });

    test('Additional Test 1: [3,3,5,0,0,3,1,4]', () {
      expect(s.maxProfit([3, 3, 5, 0, 0, 3, 1, 4]), equals(4));
    });

    test('Additional Test 2: [3,3,5,0,0,3,1,4] (duplicate test)', () {
      expect(s.maxProfit([3, 3, 5, 0, 0, 3, 1, 4]), equals(4));
    });

    test('Single day: [5]', () {
      expect(s.maxProfit([5]), equals(0));
    });

    test('Two days increasing: [1,2]', () {
      expect(s.maxProfit([1, 2]), equals(1));
    });

    test('Two days decreasing: [2,1]', () {
      expect(s.maxProfit([2, 1]), equals(0));
    });

    test('Multiple peaks: [3,2,6,5,0,3]', () {
      expect(s.maxProfit([3, 2, 6, 5, 0, 3]), equals(4));
    });

    test('All same price: [5,5,5,5]', () {
      expect(s.maxProfit([5, 5, 5, 5]), equals(0));
    });

    test('Early buy late sell: [1,2,3,4,5]', () {
      expect(s.maxProfit([1, 2, 3, 4, 5]), equals(4));
    });

    test('Multiple buy opportunities: [2,1,2,0,1]', () {
      expect(s.maxProfit([2, 1, 2, 0, 1]), equals(1));
    });

    test('Profit at end: [2,4,1,7]', () {
      expect(s.maxProfit([2, 4, 1, 7]), equals(6));
    });

    test('Profit in middle: [3,8,1,2]', () {
      expect(s.maxProfit([3, 8, 1, 2]), equals(5));
    });

    test('Large price jump: [1,10]', () {
      expect(s.maxProfit([1, 10]), equals(9));
    });

    test('Minimum price first: [1,2,1,2,1,2]', () {
      expect(s.maxProfit([1, 2, 1, 2, 1, 2]), equals(1));
    });

    test('Large array with max profit at end', () {
      final prices = List.generate(100000, (i) => i ~/ 2);
      expect(s.maxProfit(prices), equals(49999));
    });

    test('Large array with no profit', () {
      final prices = List.generate(100000, (i) => 100000 - i);
      expect(s.maxProfit(prices), equals(0));
    });

    test('Price drops then rises sharply', () {
      expect(s.maxProfit([10, 9, 8, 7, 6, 5, 10]), equals(5));
    });

    test('Multiple possible profits', () {
      expect(s.maxProfit([1, 5, 3, 8, 2, 10]), equals(9));
    });

    test('Minimum constraint values', () {
      expect(s.maxProfit([0, 0]), equals(0));
    });

    test('Maximum constraint values', () {
      expect(s.maxProfit([0, 10000]), equals(10000));
    });

    test('Random fluctuation prices', () {
      expect(s.maxProfit([5, 2, 8, 1, 4, 9, 3]), equals(8));
    });
  });
}
