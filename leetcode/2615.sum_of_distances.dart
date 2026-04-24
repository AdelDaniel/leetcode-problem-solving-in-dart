// leetcode/2615.sum_of_distances.dart
// https://leetcode.com/problems/sum-of-distances/
import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();

  final Solution s = Solution();
  s.distance([1, 3, 1, 1, 2]);

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
}

class Solution {
  ////! Solution explanation: https://www.youtube.com/watch?v=-3A9i1BKZ9E
  List<int> distance(List<int> nums) {
    final result = List<int>.filled(nums.length, 0);
    final Map<int, int> sumMap = {};
    final Map<int, int> countMap = {};
    for (int i = 0; i < nums.length; i++) {
      final value = nums[i];
      final sum = sumMap[value];
      if (sum == null) {
        result[i] = 0;
        sumMap[value] = i;
        countMap[value] = 1;
      } else {
        result[i] = (countMap[value]! * i) - sumMap[value]!;
        sumMap[value] = sumMap[value]! + i;
        countMap[value] = countMap[value]! + 1;
      }
    }

    sumMap.clear();
    countMap.clear();

    for (int i = nums.length - 1; i >= 0; i--) {
      final value = nums[i];
      final sum = sumMap[value];
      if (sum == null) {
        sumMap[value] = i;
        countMap[value] = 1;
      } else {
        result[i] += sumMap[value]! - (countMap[value]! * i);
        sumMap[value] = sumMap[value]! + i;
        countMap[value] = countMap[value]! + 1;
      }
    }
    return result;
  }

  /// Time Limit
//   List<int> distance(List<int> nums) {
//     final List<int> result = [];
//     final Map<int,List<int>> map = {};
//     for(int i = 0; i < nums.length; i++){
//         final value = nums[i];
//         final list = map[value];
//         if(list == null){
//             map[value] = [i];
//         }else{
//             list.add(i);
//         }
//     }

//     for(int i = 0; i < nums.length; i++){
//         final List<int> list = map[nums[i]]??[];
//         int sum = 0;
//         for(int j = 0; j < list.length; j++){
//             sum += (i-list[j]).abs();
//         }
//         result.add(sum);

//     }
//     return result;
//   }

  ////! Brute Force
  ////! And time limit
//   List<int> distance(List<int> nums) {
//     final List<int> result = [];
//     for(int i = 0; i < nums.length; i++){
//         int current = nums[i];
//         int sum = 0;
//         for(int j = 0; j < nums.length; j++){
//             if(nums[j] == current) sum += (i-j).abs();
//         }
//         result.add(sum);
//     }
//     return result;
//   }
}

void runTests() {
  final Solution s = Solution();

  group('Sum of Distances', () {
    // ===== Examples =====
    test('Example 1: [1,3,1,1,2] -> [5,0,3,4,0]', () {
      final nums = [1, 3, 1, 1, 2];
      expect(s.distance(nums), equals([5, 0, 3, 4, 0]));
    });

    test('Example 2: [0,5,3] -> [0,0,0]', () {
      final nums = [0, 5, 3];
      expect(s.distance(nums), equals([0, 0, 0]));
    });

    // ===== Minimum Cases =====
    test('Single element -> [0]', () {
      final nums = [7];
      expect(s.distance(nums), equals([0]));
    });

    test('Two different elements -> [0,0]', () {
      final nums = [5, 6];
      expect(s.distance(nums), equals([0, 0]));
    });

    test('Two same elements -> [1,1]', () {
      final nums = [5, 5];
      expect(s.distance(nums), equals([1, 1]));
    });

    // ===== Small Repeated Cases =====
    test('Three same elements', () {
      final nums = [4, 4, 4];
      expect(s.distance(nums), equals([3, 2, 3]));
    });

    test('One repeated pair around a unique element', () {
      final nums = [1, 2, 1];
      expect(s.distance(nums), equals([2, 0, 2]));
    });

    test('Repeated at both ends only', () {
      final nums = [4, 1, 2, 3, 4];
      expect(s.distance(nums), equals([4, 0, 0, 0, 4]));
    });

    test('Two separate duplicated groups', () {
      final nums = [1, 2, 3, 1, 2, 3];
      expect(s.distance(nums), equals([3, 3, 3, 3, 3, 3]));
    });

    // ===== Alternating / Patterned =====
    test('Alternating values odd length', () {
      final nums = [1, 2, 1, 2, 1];
      expect(s.distance(nums), equals([6, 2, 4, 2, 6]));
    });

    test('Alternating values even length', () {
      final nums = [1, 2, 1, 2, 1, 2];
      expect(s.distance(nums), equals([6, 6, 4, 4, 6, 6]));
    });

    test('Palindrome-like repeated pattern', () {
      final nums = [7, 8, 7, 8, 7, 8, 7];
      expect(s.distance(nums), equals([12, 6, 8, 4, 8, 6, 12]));
    });

    // ===== Sparse Repetitions =====
    test('One value repeated many times with gaps', () {
      final nums = [5, 1, 5, 2, 5, 3, 5];
      expect(s.distance(nums), equals([12, 0, 8, 0, 8, 0, 12]));
    });

    test('Repeated values in uneven positions', () {
      final nums = [2, 2, 3, 2, 4, 2];
      expect(s.distance(nums), equals([9, 7, 0, 7, 0, 11]));
    });

    test('Consecutive duplicate blocks', () {
      final nums = [1, 1, 1, 2, 2, 3];
      expect(s.distance(nums), equals([3, 2, 3, 1, 1, 0]));
    });

    test('Mixed groups with different frequencies', () {
      final nums = [10, 20, 10, 30, 20, 10, 30, 20];
      expect(s.distance(nums), equals([7, 9, 5, 3, 6, 8, 3, 9]));
    });

    // ===== Value Range / Boundary Values =====
    test('Uses 0 and 1e9', () {
      final nums = [0, 1000000000, 0, 1000000000];
      expect(s.distance(nums), equals([2, 2, 2, 2]));
    });

    test('All zeros', () {
      final nums = [0, 0, 0, 0];
      expect(s.distance(nums), equals([6, 4, 4, 6]));
    });

    test('Large values with one repeated pair', () {
      final nums = [1000000000, 7, 8, 1000000000];
      expect(s.distance(nums), equals([3, 0, 0, 3]));
    });

    // ===== All Distinct =====
    test('All distinct small array', () {
      final nums = [9, 8, 7, 6, 5];
      expect(s.distance(nums), equals([0, 0, 0, 0, 0]));
    });

    test('All distinct larger generated array', () {
      final nums = List.generate(100, (i) => i);
      expect(s.distance(nums), equals(List.filled(100, 0)));
    });

    // ===== All Same =====
    test('All same 5 elements', () {
      final nums = [1, 1, 1, 1, 1];
      expect(s.distance(nums), equals([10, 7, 6, 7, 10]));
    });

    test('All same 10 elements', () {
      final nums = List.filled(10, 3);
      expect(
          s.distance(nums), equals([45, 37, 31, 27, 25, 25, 27, 31, 37, 45]));
    });

    test('All same 1000 elements - exact formula', () {
      final nums = List.filled(1000, 42);
      final expected = List<int>.generate(1000, (i) {
        final left = i * (i + 1) ~/ 2;
        final right = (999 - i) * (1000 - i) ~/ 2;
        return left + right;
      });

      expect(s.distance(nums), equals(expected));
    });

    // ===== Stress-like Shapes =====

    test('One repeated value many times, others unique', () {
      final nums = [9, 1, 9, 2, 9, 3, 9, 4, 9];
      expect(s.distance(nums), equals([20, 0, 14, 0, 12, 0, 14, 0, 20]));
    });

    // ===== Sanity / Symmetry =====
    test('Symmetric positions produce symmetric answers', () {
      final nums = [5, 1, 5, 1, 5];
      expect(s.distance(nums), equals([6, 2, 4, 2, 6]));
    });
  });
}
