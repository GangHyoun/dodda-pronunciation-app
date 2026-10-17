import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextProvider extends ChangeNotifier {
  late stt.SpeechToText _speech; // late 키워드를 사용하여 나중에 초기화
  bool _isListening = false;
  String _text = "";

  SpeechToTextProvider() {
    _speech = stt.SpeechToText();
  }

  String get text => _text;

  bool get isListening => _isListening;

  Future<void> startListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('onStatus: $status'),
      onError: (error) => print('onError: $error'),
    );
    if (available) {
      _isListening = true;
      notifyListeners();
      _speech.listen(
        onResult: (result) {
          _text = result.recognizedWords;
          notifyListeners();
        },
      );
    } else {
      _isListening = false;
      notifyListeners();
    }
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }
}
