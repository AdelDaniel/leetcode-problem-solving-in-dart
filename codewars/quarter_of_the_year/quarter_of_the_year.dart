import "package:test/test.dart";

void main() {
  test("Basic Tests", () {
    expect(quarter(3), 1);
    expect(quarter(8), 3);
    expect(quarter(11), 4);
  });
}

int quarter(int month) {
  return (month / 3).ceil();
}
