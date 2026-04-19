// heap/max_heap.dart
class MaxHeap {
  final List<int> _heap = [];

  // Helper to get parent and child indices
  int _parent(int i) => (i - 1) ~/ 2;
  int _left(int i) => 2 * i + 1;
  int _right(int i) => 2 * i + 2;

  // Adds an element and restores the heap property (bubble up)
  void insert(int value) {
    _heap.add(value);
    _bubbleUp(_heap.length - 1);
  }

  // Removes and returns the largest element (bubble down)
  int? pop() {
    if (_heap.isEmpty) return null;
    if (_heap.length == 1) return _heap.removeLast();

    final max = _heap[0];
    _heap[0] = _heap.removeLast(); // Move last element to root
    _bubbleDown(0);
    return max;
  }

  void _bubbleUp(int index) {
    while (index > 0 && _heap[index] > _heap[_parent(index)]) {
      _swap(index, _parent(index));
      index = _parent(index);
    }
  }

  void _bubbleDown(int index) {
    int largest = index;
    int left = _left(index);
    int right = _right(index);

    if (left < _heap.length && _heap[left] > _heap[largest]) largest = left;
    if (right < _heap.length && _heap[right] > _heap[largest]) largest = right;

    if (largest != index) {
      _swap(index, largest);
      _bubbleDown(largest);
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
  final maxHeap = MaxHeap();
  [10, 20, 5, 30].forEach(maxHeap.insert);

  print('Root (Max): ${maxHeap.peek()}'); // 30
  print('Extracted: ${maxHeap.pop()}'); // 30
  print('New Root: ${maxHeap.peek()}'); // 20
}
