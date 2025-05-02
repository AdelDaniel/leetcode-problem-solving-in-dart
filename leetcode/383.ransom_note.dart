// https://leetcode.com/problems/ransom-note/

import 'package:test/test.dart';

void main() {
  final stopwatch = Stopwatch()..start();
  runTests();
  stopwatch.stop();
  print('Function Execution Time : ${stopwatch.elapsedMicroseconds} micro sec');
  // Function Execution Time : 365384 micro s
  // Function Execution Time : 394717 micro s
}

class Solution {
  /// TC: O(n) SC: O(1)
  bool canConstruct(String ransomNote, String magazine) {
    if (ransomNote.length > magazine.length) {
      return false;
    }

    final List<String> ransomNoteChars = ransomNote.split('');
    final List<String> magazineChars = magazine.split('');
    for (final String char in ransomNoteChars) {
      int magazineCharIndex = magazineChars.indexOf(char);
      if (magazineCharIndex == -1) {
        return false;
      } else {
        magazineChars[magazineCharIndex] = "";
        //! Don't Do the next one the TC will be Huge
        // magazineChars.removeAt(magazineCharIndex);
      }
    }

    return true;
  }

  ///  TC: O(3n) SC: O(2n)
  // bool canConstruct(String ransomNote, String magazine) {
  //   if (ransomNote.length > magazine.length) {
  //     return false;
  //   }
  //   final Map<String, int> ransomNoteMap = <String, int>{};
  //   final Map<String, int> magazineMap = <String, int>{};

  //   for (final String char in ransomNote.split('')) {
  //     if (ransomNoteMap.containsKey(char)) {
  //       ransomNoteMap[char] = ransomNoteMap[char]! + 1;
  //     } else {
  //       ransomNoteMap[char] = 1;
  //     }
  //   }

  //   for (final String char in magazine.split('')) {
  //     if (magazineMap.containsKey(char)) {
  //       magazineMap[char] = magazineMap[char]! + 1;
  //     } else {
  //       magazineMap[char] = 1;
  //     }
  //   }

  //   for (var ransomNoteMapKey in ransomNoteMap.keys) {
  //     if (ransomNoteMap[ransomNoteMapKey]! >
  //         (magazineMap[ransomNoteMapKey] ?? 0)) {
  //       return false;
  //     }
  //   }

  //   return true;
  // }
}

void runTests() {
  final Solution s = Solution();
  for (var i = 0; i < 10000; i++) {
    group('Ransom Note', () {
      // Basic examples from problem statement
      test('Example 1: ransomNote="a", magazine="b"', () {
        expect(s.canConstruct('a', 'b'), isFalse);
      });

      test('Example 2: ransomNote="aa", magazine="ab"', () {
        expect(s.canConstruct('aa', 'ab'), isFalse);
      });

      test('Example 3: ransomNote="aa", magazine="aab"', () {
        expect(s.canConstruct('aa', 'aab'), isTrue);
      });

      // Edge cases
      test('Empty ransomNote', () {
        expect(s.canConstruct('', 'abc'), isTrue);
      });

      test('Empty magazine with non-empty ransomNote', () {
        expect(s.canConstruct('a', ''), isFalse);
      });

      test('Both empty', () {
        expect(s.canConstruct('', ''), isTrue);
      });

      // Exact match cases
      test('Exact match single character', () {
        expect(s.canConstruct('x', 'x'), isTrue);
      });

      test('Exact match multiple characters', () {
        expect(s.canConstruct('abc', 'abc'), isTrue);
      });

      // Character frequency cases
      test('Magazine has exactly enough characters', () {
        expect(s.canConstruct('aabbcc', 'aabbcc'), isTrue);
      });

      test('Magazine has more than enough characters', () {
        expect(s.canConstruct('abc', 'aaabbbccc'), isTrue);
      });

      test('Magazine has some but not enough characters', () {
        expect(s.canConstruct('aaa', 'aa'), isFalse);
      });

      // Mixed cases
      test('Mixed characters with enough letters', () {
        expect(s.canConstruct('aab', 'baa'), isTrue);
      });

      test('Mixed characters missing one letter', () {
        expect(s.canConstruct('aabc', 'baa'), isFalse);
      });

      // Case with all same letters
      test('All same letters in both', () {
        expect(s.canConstruct('aaaaa', 'aaaaaaaaaa'), isTrue);
      });

      test('All same letters but not enough', () {
        expect(s.canConstruct('aaaaa', 'aaa'), isFalse);
      });

      // Large input cases
      test('Large ransomNote with exact magazine', () {
        final ransomNote = 'a' * 100000;
        final magazine = 'a' * 100000;
        expect(s.canConstruct(ransomNote, magazine), isTrue);
      });

      test('Large ransomNote with larger magazine', () {
        final ransomNote = 'a' * 100000;
        final magazine = 'a' * 200000;
        expect(s.canConstruct(ransomNote, magazine), isTrue);
      });

      test('Large ransomNote with insufficient magazine', () {
        final ransomNote = 'a' * 100001;
        final magazine = 'a' * 100000;
        expect(s.canConstruct(ransomNote, magazine), isFalse);
      });

      // Complex cases
      test('Complex case with multiple letters', () {
        expect(s.canConstruct('abcdefghij', 'jihgfedcba'), isTrue);
      });

      test('Complex case missing one letter', () {
        expect(s.canConstruct('abcdefghij', 'jihgfedcb'), isFalse);
      });

      // Unicode characters (though constraints say lowercase English letters)
      test('Non-English lowercase letters', () {
        expect(s.canConstruct('ñ', 'ñ'), isTrue);
      });
    });
  }
}
