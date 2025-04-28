// https://leetcode.com/problems/count-subarrays-with-score-less-than-k/description/?envType=daily-question&envId=2025-04-28
void main() {
  final stopwatch = Stopwatch()..start();
  print(Solution().countSubarrays([1, 1, 1], 5)); // 5
  print(Solution().countSubarrays([2, 1, 4, 3, 5], 10)); // 6

  // final int longK = 293438213912;
  // print(Solution().countSubarrays(positiveLongList, longK));

  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro s');
}

class Solution {
  //! Time Limit
  int countSubarrays(List<int> nums, int k) {
    int subArraysNumber = 0;
    for (int i = 0; i < nums.length; i++) {
      int scoreSum = 0;
      int score = 0;
      int length = 0;
      for (int j = i; j < nums.length; j++) {
        scoreSum += nums[j];
        score = scoreSum * (length + 1);
        if (score < k) {
          length++;
          if (j == nums.length - 1) {
            subArraysNumber += length;
            break;
          }
        } else {
          subArraysNumber += length;
          break;
        }
      }
    }
    return subArraysNumber;
  }
}

// int countSubarrays(List<int> nums, int k) {
//   int subArraysNumber = 0;
//   int scoreSum = 0;
//   int score = 0;
//   final List<int> list = [];
//   int i = 0;
//   int j = 0;

//   while (i < nums.length) {
//     list.add(nums[j]);
//     scoreSum = list.fold(0, (previous, current) => previous + current);
//     score = scoreSum * (list.length);
//     if (score < k) {
//       if (j < nums.length) {
//         j++;
//         subArraysNumber = j - i;
//       } else {
//         i++;
//         list.removeAt(0);
//         // subArraysNumber =
//         //     subArraysNumber + (list.length * (list.length + 1)) ~/ 2;
//       }
//     } else {
//       // subArraysNumber =
//       //     subArraysNumber + (list.length * (list.length + 1)) ~/ 2;
//       i++;
//       list.removeAt(0);
//     }

//     // if (score < k) {
//     //   print("length: ${list.length}");
//     //   if (j < nums.length) {}
//     // }
//   }

//   // while (i < nums.length) {
//   //   if (j < nums.length) {
//   //     list.add(nums[j]);
//   //     scoreSum = list.fold(0, (previous, current) => previous + current);
//   //     score = scoreSum * (list.length);
//   //     j++;
//   //   } else {
//   //     // list.removeAt(0);
//   //     subArraysNumber += (list.length * (list.length + 1)) ~/ 2;
//   //     // print("subArraysNumber: $subArraysNumber");
//   //     // break;
//   //   }

//   //   print("score: $score");
//   //   if (score < k) {
//   //     print("length: ${list.length}");
//   //     if (j < nums.length) {}
//   //   } else {
//   //     i++;

//   //     /// Remove the last J you added because you will add again in the next time
//   //     j--;
//   //     list.removeLast();
//   //     int lenght = list.length;
//   //     subArraysNumber += (lenght * (lenght + 1)) ~/ 2;
//   //     list.removeAt(0);
//   //     // scoreSum = list.fold(0, (previous, current) => previous + current);
//   //     print("subArraysNumber: $subArraysNumber");
//   //   }
//   // }

//   // list.removeAt(0);
//   // scoreSum = list.fold(
//   //   0,
//   //   (previousValue, element) => previousValue + element,
//   // );

//   return subArraysNumber;
// }
