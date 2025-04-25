void main() {
  print(Solution().fizzBuzz(10));
}

class Solution {
// List<String> fizzBuzz(int n) {
//   final List<String> list = [];
//   for (int i = 1; i <= n; i++) {
//     if (i % 3 == 0 && i % 5 == 0) {
//       list.add("FizzBuzz");
//     } else if (i % 3 == 0) {
//       list.add("Fizz");
//     } else if (i % 5 == 0) {
//       list.add("Buzz");
//     } else {
//       list.add("$i");
//     }
//   }
//   return list;
// }
  List<String> fizzBuzz(int n) {
    return List.generate(n, (int i) {
      ++i;
      if (i % 3 == 0 && i % 5 == 0) {
        return "FizzBuzz";
      } else if (i % 3 == 0) {
        return "Fizz";
      } else if (i % 5 == 0) {
        return "Buzz";
      } else {
        return "$i";
      }
    });
  }
}
