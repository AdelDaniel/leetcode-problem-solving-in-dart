void main(List<String> args) {
  print(BinarySearch().call(
    [1, 3, 5, 6, 7, 8, 10, 12, 16, 19, 20, 24, 29, 44, 55, 56],
    11,
  ));
}

class BinarySearch {
  int call(List<int> list, int n) {
    int left = 0;
    int right = list.length - 1;

    // May cause overflow
    // int middle = (left + right) ~/ 2;
    int middle = left + (right - left) ~/ 2;

    do {
      print(
        'left: $left, middle: $middle, right: $right ,list[middle]: ${list[middle]}',
      );
      if (list[middle] == n) {
        return middle;
      } else if (list[middle] > n) {
        right = middle - 1;
      } else if (list[middle] < n) {
        left = middle + 1;
      }

      middle = left + (right - left) ~/ 2;
    } while (left <= right);
    print(
      'left: $left, middle: $middle, right: $right ,list[middle]: ${list[middle]}',
    );
    return -1;
  }
}
