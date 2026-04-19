// heap/min_heap.dart
class MinHeap {
  final List<int> _heap = [];

  int _parent(int i) => (i - 1) ~/ 2;
  int _left(int i) => 2 * i + 1;
  int _right(int i) => 2 * i + 2;

  // Adds an element and bubbles it up if it's smaller than its parent
  void insert(int value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  // Removes and returns the smallest element
  int? pop() {
    if (_heap.isEmpty) return null;
    if (_heap.length == 1) return _heap.removeLast();

    final min = _heap[0];
    _heap[0] = _heap.removeLast(); // Move last element to root
    _bubbleDown(0);
    return min;
  }

  void _bubbleUp(int index) {
    // Change: Check if current is LESS than parent
    while (index > 0 && _heap[index] < _heap[_parent(index)]) {
      _swap(index, _parent(index));
      index = _parent(index);
    }
  }

  void _bubbleDown(int index) {
    int smallest = index;
    int left = _left(index);
    int right = _right(index);

    // Change: Find the SMALLEST among parent and children
    if (left < _heap.length && _heap[left] < _heap[smallest]) smallest = left;
    if (right < _heap.length && _heap[right] < _heap[smallest]) {
      smallest = right;
    }

    if (smallest != index) {
      _swap(index, smallest);
      _bubbleDown(smallest);
    }
  }

  void _swap(int i, int j) {
    int temp = _heap[i];
    _heap[i] = _heap[j];
    _heap[j] = temp;
  }

  int? peek() => _heap.isNotEmpty ? _heap[0] : null;
  bool get isEmpty => _heap.isEmpty;
}

void main() {
  final minHeap = MinHeap();
  [30, 10, 20, 5].forEach(minHeap.insert);

  print('Root (Min): ${minHeap.peek()}'); // 5
  print('Extracted: ${minHeap.pop()}'); // 5
  print('New Root: ${minHeap.peek()}'); // 10
}
