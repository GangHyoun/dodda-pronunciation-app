import 'package:flutter/material.dart';

// 문자열 비교 로직을 수행하는 위젯 함수
Widget buildComparisonText(String currentText, String compareWord,) {
  // 문장 정규화
  String normalizedCurrentText = _normalize(currentText); //사용자가 발음한 단어
  String normalizedCompareWord = _normalize(compareWord); //읽은 단어

//공백 기준으로 어절 분리 후 리스트에 저장
  List<String> words = currentText.split(' ');
  List<String> expectedWords = compareWord.split(' ');
  List<String> normalizedWords = normalizedCurrentText.split(' ');
  List<String> normalizedCompareWords = normalizedCompareWord.split(' ');

  List<Widget> comparisonWidgets = [];

  for (int i = 0; i < words.length; i++) {
    // 읽은 단어 개수보다 발음한 단어의 개수가 짧거나 같은 경우
    if (i < expectedWords.length) {
      comparisonWidgets.add(
        Text(
          words[i] + ' ',
          style: TextStyle(
            color: normalizedWords[i] == normalizedCompareWords[i]
                ? Colors.black
                : Colors.red,
            fontSize: 40,
          ),
          softWrap: true, // 텍스트 자동 줄바꿈
        ),
      );
      // 읽은 단어 개수보다 발음한 단어의 개수가 긴 경우
    } else {
      comparisonWidgets.add(
        Text(
          words[i] + ' ',
          style: TextStyle(color: Colors.red, fontSize: 40),
          softWrap: true, // 텍스트 자동 줄바꿈
        ),
      );
    }
  }

  return Wrap(
    children: comparisonWidgets,
  );
}

//정규화 함수
String _normalize(String text) {
  return text.toLowerCase().replaceAll(RegExp(r'\-|\.|,|!|\?|"'), '');
}
