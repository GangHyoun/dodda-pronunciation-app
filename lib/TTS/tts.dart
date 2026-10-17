import 'package:flutter_tts/flutter_tts.dart';

FlutterTts tts = FlutterTts();

Future<void> speakText(String text) async {
  //final TextEditingController con = TextEditingController();
  await tts.setLanguage('ko-KR'); // 언어 설정
  await tts.setPitch(1.0); // 음성 높낮이 설정
  await tts.setSpeechRate(0.3); // 음성 속도 설정
  await tts.speak(text); // 텍스트 음성 변환 및 재생
  //dbread();
}
