// leetcode/295.find_median_from_data_stream.dart
// https://leetcode.com/problems/find-median-from-data-stream/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();

  // final MedianFinder medianFinder = MedianFinder();
  // medianFinder.addNum(1);
  // medianFinder.addNum(2);
  // medianFinder.findMedian();

  final mf = MedianFinder();

  mf.addNum(7);
  mf.addNum(1);
  mf.addNum(5);
  mf.addNum(3);
  mf.findMedian();

  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class MedianFinder {
  final List<int> nums = [];
  MedianFinder() {
    // Initialization goes here
  }

  // void addNum(int num) {
  //   int left = 0;
  //   int right = nums.length - 1;
  //   int mid = left + (right - left) ~/ 2;
  //   while (left <= right) {
  //     mid = left + (right - left) ~/ 2;
  //     if (nums[mid] < num) {
  //       left = mid + 1;
  //     } else if (nums[mid] > num) {
  //       right = mid - 1;
  //     } else {
  //       break;
  //     }
  //   }

  //   nums.insert(mid, num);
  // }

  void addNum(int num) {
    int low = 0;
    int high = nums.length;
    int mid = low + (high - low) ~/ 2;
    while (low < high) {
      mid = low + (high - low) ~/ 2;
      if (nums[mid] < num) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }

    nums.insert(low, num);
  }

  double findMedian() {
    int size = nums.length;
    if (size == 0) return 0;
    if (size == 1) return nums.first.toDouble();
    if (size == 2) return (nums.first + nums.last) / 2;
    if (size % 2 == 0) {
      final index = size ~/ 2;
      final result = (nums[index] + nums[index - 1]) / 2;
      return result;
    }
    return nums[size ~/ 2].toDouble();
  }
}

void runTests() {
  group('Find Median from Data Stream', () {
    // ===== Examples =====
    test('Example 1: [1], [1,2], [1,2,3]', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(2);
      expect(mf.findMedian(), closeTo(1.5, 1e-9));

      mf.addNum(3);
      expect(mf.findMedian(), closeTo(2.0, 1e-9));
    });

    // ===== Single / Small Cases =====
    test('Single element', () {
      final mf = MedianFinder();

      mf.addNum(5);
      expect(mf.findMedian(), closeTo(5.0, 1e-9));
    });

    test('Two elements ascending', () {
      final mf = MedianFinder();

      mf.addNum(2);
      mf.addNum(4);
      expect(mf.findMedian(), closeTo(3.0, 1e-9));
    });

    test('Two elements descending', () {
      final mf = MedianFinder();

      mf.addNum(4);
      mf.addNum(2);
      expect(mf.findMedian(), closeTo(3.0, 1e-9));
    });

    test('Three elements ascending', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(2);
      mf.addNum(3);
      expect(mf.findMedian(), closeTo(2.0, 1e-9));
    });

    test('Three elements descending', () {
      final mf = MedianFinder();

      mf.addNum(3);
      mf.addNum(2);
      mf.addNum(1);
      expect(mf.findMedian(), closeTo(2.0, 1e-9));
    });

    test('Four elements mixed order', () {
      final mf = MedianFinder();

      mf.addNum(7);
      mf.addNum(1);
      mf.addNum(5);
      mf.addNum(3);
      expect(mf.findMedian(), closeTo(4.0, 1e-9));
    });

    // ===== Repeated findMedian =====
    test('Repeated findMedian without new insert', () {
      final mf = MedianFinder();

      mf.addNum(10);
      mf.addNum(20);
      expect(mf.findMedian(), closeTo(15.0, 1e-9));
      expect(mf.findMedian(), closeTo(15.0, 1e-9));
      expect(mf.findMedian(), closeTo(15.0, 1e-9));
    });

    // ===== Negative Values =====
    test('Single negative value', () {
      final mf = MedianFinder();

      mf.addNum(-7);
      expect(mf.findMedian(), closeTo(-7.0, 1e-9));
    });

    test('Two negative values', () {
      final mf = MedianFinder();

      mf.addNum(-10);
      mf.addNum(-2);
      expect(mf.findMedian(), closeTo(-6.0, 1e-9));
    });

    test('Mixed negative values odd count', () {
      final mf = MedianFinder();

      mf.addNum(-5);
      mf.addNum(-1);
      mf.addNum(-3);
      expect(mf.findMedian(), closeTo(-3.0, 1e-9));
    });

    test('Mixed negative values even count', () {
      final mf = MedianFinder();

      mf.addNum(-8);
      mf.addNum(-2);
      mf.addNum(-6);
      mf.addNum(-4);
      expect(mf.findMedian(), closeTo(-5.0, 1e-9));
    });

    // ===== Mixed Negative / Positive =====
    test('Symmetric around zero odd count', () {
      final mf = MedianFinder();

      mf.addNum(-2);
      mf.addNum(0);
      mf.addNum(2);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    test('Symmetric around zero even count', () {
      final mf = MedianFinder();

      mf.addNum(-3);
      mf.addNum(-1);
      mf.addNum(1);
      mf.addNum(3);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    test('Mixed negatives and positives random order', () {
      final mf = MedianFinder();

      mf.addNum(5);
      mf.addNum(-10);
      mf.addNum(3);
      mf.addNum(8);
      mf.addNum(-2);
      expect(mf.findMedian(), closeTo(3.0, 1e-9));
    });

    test('Mixed negatives and positives even count', () {
      final mf = MedianFinder();

      mf.addNum(10);
      mf.addNum(-10);
      mf.addNum(5);
      mf.addNum(-5);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    // ===== Duplicates =====
    test('All duplicate values odd count', () {
      final mf = MedianFinder();

      mf.addNum(7);
      mf.addNum(7);
      mf.addNum(7);
      expect(mf.findMedian(), closeTo(7.0, 1e-9));
    });

    test('All duplicate values even count', () {
      final mf = MedianFinder();

      mf.addNum(9);
      mf.addNum(9);
      mf.addNum(9);
      mf.addNum(9);
      expect(mf.findMedian(), closeTo(9.0, 1e-9));
    });

    test('Duplicates with one different center', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(1);
      mf.addNum(2);
      mf.addNum(2);
      mf.addNum(2);
      expect(mf.findMedian(), closeTo(2.0, 1e-9));
    });

    test('Duplicates with even median between groups', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(1);
      mf.addNum(5);
      mf.addNum(5);
      expect(mf.findMedian(), closeTo(3.0, 1e-9));
    });

    // ===== Zeros =====
    test('All zeros', () {
      final mf = MedianFinder();

      mf.addNum(0);
      mf.addNum(0);
      mf.addNum(0);
      mf.addNum(0);
      mf.addNum(0);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    test('Zeros mixed with positives', () {
      final mf = MedianFinder();

      mf.addNum(0);
      mf.addNum(0);
      mf.addNum(5);
      mf.addNum(10);
      expect(mf.findMedian(), closeTo(2.5, 1e-9));
    });

    test('Zeros mixed with negatives', () {
      final mf = MedianFinder();

      mf.addNum(-10);
      mf.addNum(0);
      mf.addNum(0);
      mf.addNum(10);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    // ===== Boundary Values =====
    test('Minimum constraint values', () {
      final mf = MedianFinder();

      mf.addNum(-100000);
      mf.addNum(-100000);
      mf.addNum(-100000);
      expect(mf.findMedian(), closeTo(-100000.0, 1e-9));
    });

    test('Maximum constraint values', () {
      final mf = MedianFinder();

      mf.addNum(100000);
      mf.addNum(100000);
      mf.addNum(100000);
      mf.addNum(100000);
      expect(mf.findMedian(), closeTo(100000.0, 1e-9));
    });

    test('Min and max constraints together', () {
      final mf = MedianFinder();

      mf.addNum(-100000);
      mf.addNum(100000);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    test('Extreme values with zero center', () {
      final mf = MedianFinder();

      mf.addNum(-100000);
      mf.addNum(0);
      mf.addNum(100000);
      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    // ===== Interleaved Operations =====
    test('Interleaved median checks 1', () {
      final mf = MedianFinder();

      mf.addNum(6);
      expect(mf.findMedian(), closeTo(6.0, 1e-9));

      mf.addNum(10);
      expect(mf.findMedian(), closeTo(8.0, 1e-9));

      mf.addNum(2);
      expect(mf.findMedian(), closeTo(6.0, 1e-9));

      mf.addNum(8);
      expect(mf.findMedian(), closeTo(7.0, 1e-9));
    });

    test('Interleaved median checks 2', () {
      final mf = MedianFinder();

      mf.addNum(100);
      expect(mf.findMedian(), closeTo(100.0, 1e-9));

      mf.addNum(1);
      expect(mf.findMedian(), closeTo(50.5, 1e-9));

      mf.addNum(50);
      expect(mf.findMedian(), closeTo(50.0, 1e-9));

      mf.addNum(75);
      expect(mf.findMedian(), closeTo(62.5, 1e-9));

      mf.addNum(25);
      expect(mf.findMedian(), closeTo(50.0, 1e-9));
    });

    test('Interleaved with duplicates and negatives', () {
      final mf = MedianFinder();

      mf.addNum(-1);
      expect(mf.findMedian(), closeTo(-1.0, 1e-9));

      mf.addNum(-1);
      expect(mf.findMedian(), closeTo(-1.0, 1e-9));

      mf.addNum(5);
      expect(mf.findMedian(), closeTo(-1.0, 1e-9));

      mf.addNum(5);
      expect(mf.findMedian(), closeTo(2.0, 1e-9));

      mf.addNum(5);
      expect(mf.findMedian(), closeTo(5.0, 1e-9));
    });

    // ===== Sorted Insert Orders =====
    test('Increasing order sequence', () {
      final mf = MedianFinder();

      for (final n in [1, 2, 3, 4, 5, 6, 7]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(4.0, 1e-9));
    });

    test('Decreasing order sequence', () {
      final mf = MedianFinder();

      for (final n in [7, 6, 5, 4, 3, 2, 1]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(4.0, 1e-9));
    });

    test('Increasing even sequence', () {
      final mf = MedianFinder();

      for (final n in [1, 2, 3, 4, 5, 6]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(3.5, 1e-9));
    });

    test('Decreasing even sequence', () {
      final mf = MedianFinder();

      for (final n in [6, 5, 4, 3, 2, 1]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(3.5, 1e-9));
    });

    // ===== Alternating / Patterned Streams =====
    test('Alternating low-high values', () {
      final mf = MedianFinder();

      for (final n in [1, 100, 2, 99, 3, 98, 4, 97]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(50.5, 1e-9));
    });

    test('Alternating around center odd count', () {
      final mf = MedianFinder();

      for (final n in [50, 40, 60, 30, 70, 20, 80]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(50.0, 1e-9));
    });

    test('Alternating around center even count', () {
      final mf = MedianFinder();

      for (final n in [50, 40, 60, 30, 70, 20, 80, 10]) {
        mf.addNum(n);
      }

      expect(mf.findMedian(), closeTo(45.0, 1e-9));
    });

    // ===== Large Cases =====
    test('Large sequence 1..100', () {
      final mf = MedianFinder();

      for (int i = 1; i <= 100; i++) {
        mf.addNum(i);
      }

      expect(mf.findMedian(), closeTo(50.5, 1e-9));
    });

    test('Large sequence 1..101', () {
      final mf = MedianFinder();

      for (int i = 1; i <= 101; i++) {
        mf.addNum(i);
      }

      expect(mf.findMedian(), closeTo(51.0, 1e-9));
    });

    test('Large repeated values', () {
      final mf = MedianFinder();

      for (int i = 0; i < 1000; i++) {
        mf.addNum(42);
      }

      expect(mf.findMedian(), closeTo(42.0, 1e-9));
    });

    test('Large balanced negatives and positives', () {
      final mf = MedianFinder();

      for (int i = 1; i <= 500; i++) {
        mf.addNum(-i);
        mf.addNum(i);
      }

      expect(mf.findMedian(), closeTo(0.0, 1e-9));
    });

    test('Large mostly small-range values', () {
      final mf = MedianFinder();

      for (int i = 0; i < 1000; i++) {
        mf.addNum(i % 101);
      }

      expect(mf.findMedian(), closeTo(50.0, 1e-9));
    });

    // ===== Precision Cases =====
    test('Median must be fractional .5', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(4);
      expect(mf.findMedian(), closeTo(2.5, 1e-9));
    });

    test('Median must be fractional negative .5', () {
      final mf = MedianFinder();

      mf.addNum(-4);
      mf.addNum(-1);
      expect(mf.findMedian(), closeTo(-2.5, 1e-9));
    });

    test('Median with distant values', () {
      final mf = MedianFinder();

      mf.addNum(1);
      mf.addNum(1000);
      mf.addNum(1001);
      mf.addNum(2000);
      expect(mf.findMedian(), closeTo(1000.5, 1e-9));
    });

    // ===== Stress-like Sequential Assertions =====
    test('Median after each insertion in 1..10', () {
      final mf = MedianFinder();
      final nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      final expected = [1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5];

      for (int i = 0; i < nums.length; i++) {
        mf.addNum(nums[i]);
        expect(mf.findMedian(), closeTo(expected[i], 1e-9));
      }
    });

    test('Median after each insertion in shuffled stream', () {
      final mf = MedianFinder();
      final nums = [5, 15, 1, 3];
      final expected = [5.0, 10.0, 5.0, 4.0];

      for (int i = 0; i < nums.length; i++) {
        mf.addNum(nums[i]);
        expect(mf.findMedian(), closeTo(expected[i], 1e-9));
      }
    });

    // ===== Stability =====
    test('Order of insertion should not change final median', () {
      final mf1 = MedianFinder();
      final mf2 = MedianFinder();

      final a = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      final b = [9, 1, 8, 2, 7, 3, 6, 4, 5];

      for (final n in a) {
        mf1.addNum(n);
      }

      for (final n in b) {
        mf2.addNum(n);
      }

      expect(mf1.findMedian(), closeTo(5.0, 1e-9));
      expect(mf2.findMedian(), closeTo(5.0, 1e-9));
    });

    test('Final median same for reverse insertion', () {
      final mf1 = MedianFinder();
      final mf2 = MedianFinder();

      for (final n in [2, 4, 6, 8, 10, 12]) {
        mf1.addNum(n);
      }

      for (final n in [12, 10, 8, 6, 4, 2]) {
        mf2.addNum(n);
      }

      expect(mf1.findMedian(), closeTo(7.0, 1e-9));
      expect(mf2.findMedian(), closeTo(7.0, 1e-9));
    });
  });
}
