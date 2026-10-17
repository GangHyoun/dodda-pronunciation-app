import 'package:ddd_02/TTS/tts.dart';
import 'package:flutter/material.dart';

//이중모음 단어 부분
class VowelWordText extends StatelessWidget {
  const VowelWordText({super.key, required this.word //속성으로 단어
      });

  final String word;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 20), //Row에 Text랑 IconBtn 같이 넣으니까 단어가 중앙에 안 와서 급한대로 요래 배치
        Text(
          //이중 모음 단어 텍스트
          word, //이게 텍스트 부분인데 단어는 넘기면 바뀌는 거니까 변수(속성)로 지정
          style: TextStyle(fontSize: 64, color: Colors.black),
        ),
        IconButton(
            //발음 듣기 버튼
            onPressed: () => speakText(word)
            //눌렀을 때 동작
            ,
            icon: Icon(Icons.campaign_rounded))
      ],
    );
  }
}
