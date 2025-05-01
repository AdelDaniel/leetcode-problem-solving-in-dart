// https://leetcode.com/problems/factorial-trailing-zeroes/

import 'package:test/test.dart';

void main() {
  runTests();
}

/*
Those are the basic cases.
The examples given are straightforward. 
Example 1: n=3, output 0. 
Example 2: n=5, output 1. it contains only one 5 --> (5): 5=5*1
Example 3: n=0, output 0. 
Example 4: n=10, output 2. it contains 2 Fives ---> (5,10): 10=2*5
Example 5: n=20, output 4. it contains 4 Fives ---> (5,10,15,20): 15=3*5 20=4*5

So that was the easy way (Count how many five is thers)
The Solution depends on number fo [fives] 5 in a each number 
-----

Now, think about edge cases.
Then numbers that are multiples of 5, 25, 125, etc.,x
since each contributes more than one 5.
-----

Example 6:
n=25, output 6 NOT 5. Why it contains 6 Fives 
---> (5,10,15,20,25)  [25=5*5] 5^2=25 the 25 contains 5*5
5->5^1
10->5^1
15->5^1
20->5^1
25->5^2<-
30->5^1
35->5^1
40->5^1
45->5^1
50->5^2<-
.
.
.
75->5^2<-
100->5^2<-

in the above 100 / 5 = 20
But still there are 4 fives in the (25 & 50 & 75 & 100)
Then we need to divide 100/25=4
Total 20+4=24
125


----
How to solve these case?!
n=25.
The trailing zeros would be  25/25 = 5 -> 25/5=5 -> (5 + 1 = 6). 
So that's a test case. 
-----
What will happend if 125 it is 5^3=125
Here is the equation:
(n/5)+(n/25)+(n/125)+.......=total Number of zersos 

----------
The second way to solve this 
----------

n=30.
30/5=6, 6/5=1, total 6+1=7. 
But wait, 30/125 is 0. So 6+1=7.

n=100.
100/5=20, 20/5=4 (from 25,50,75,100), 4/5=0.
So total 20+4=24. 
So 24 is trailing zeros.
----
What about larger numbers? 
Like 1000. 
Let's compute: 1000 /5 =200, 200/5=40, 40/5=8, 8/5=1. 
Total 200+40+8+1=249.
 */

/// TC: O(log5 n) SC: O(1)
class Solution {
  int trailingZeroes(int n) {
    int numberOfZeros = 0;
    int powerOfFives = 5;
    while (n ~/ powerOfFives > 0) {
      numberOfZeros += n ~/ powerOfFives;
      powerOfFives = powerOfFives * 5;
    }
    return numberOfZeros;
  }

  // More optimized
  // int trailingZeroes(int n) {
  //   int numberOfZeros = 0;
  //   while (n > 0) {
  //     numberOfZeros += n ~/ 5;
  //     n = n ~/ 5;
  //   }
  //   return numberOfZeros;
  // }
}

void runTests() {
  final Solution s = Solution();

  group('Factorial Trailing Zeroes', () {
    // Basic examples from problem statement
    test('Example 1: n=3', () {
      expect(s.trailingZeroes(3), equals(0));
    });

    test('Example 2: n=5', () {
      expect(s.trailingZeroes(5), equals(1));
    });

    test('Example 3: n=0', () {
      expect(s.trailingZeroes(0), equals(0));
    });

    // Edge cases
    test('n=1 (smallest positive input)', () {
      expect(s.trailingZeroes(1), equals(0));
    });

    test('n=4 (before first multiple of 5)', () {
      expect(s.trailingZeroes(4), equals(0));
    });

    // Single multiple of 5 cases
    test('n=6 (first after 5)', () {
      expect(s.trailingZeroes(6), equals(1));
    });

    test('n=9 (last before 10)', () {
      expect(s.trailingZeroes(9), equals(1));
    });

    // Multiple simple factors of 5
    test('n=10 (two 5s)', () {
      expect(s.trailingZeroes(10), equals(2));
    });

    test('n=15 (three 5s)', () {
      expect(s.trailingZeroes(15), equals(3));
    });

    // Cases with multiple factors (25 = 5²)
    test('n=25 (5²)', () {
      expect(s.trailingZeroes(25), equals(6));
    });

    test('n=30 (multiple factors of 5 and 25)', () {
      expect(s.trailingZeroes(30), equals(7));
    });

    test('n=49 (multiple factors up to 25)', () {
      expect(s.trailingZeroes(49), equals(10));
    });

    // Large numbers
    test('n=100 (multiple factors up to 125)', () {
      expect(s.trailingZeroes(100), equals(24));
    });

    test('n=250 (multiple higher exponents)', () {
      expect(s.trailingZeroes(250), equals(62));
    });

    test('n=125 (multiple higher exponents)', () {
      expect(s.trailingZeroes(125), equals(25 + 5 + 1));
    });

    test('n=1000 (complex factor breakdown)', () {
      expect(s.trailingZeroes(1000), equals(249));
    });

    // Special cases
    test('n=625 (5⁴)', () {
      expect(s.trailingZeroes(625), equals(156));
    });

    test('n=3125 (5⁵)', () {
      expect(s.trailingZeroes(3125), equals(781));
    });

    // Maximum constraint test
    test('n=10^4 (large input)', () {
      expect(s.trailingZeroes(10000), equals(2499));
    });

    // Numbers with multiple 5 factors
    test('n=130 (mixed factors)', () {
      expect(s.trailingZeroes(130), equals(32));
    });

    test('n=200 (combination of 5s and 25s)', () {
      expect(s.trailingZeroes(200), equals(49));
    });
  });
}
