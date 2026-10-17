import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddd_02/STT/stt.dart';

class VowelRecordBtn extends StatelessWidget {
  const VowelRecordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeechToTextProvider>(
      builder: (context, speechProvider, child) {
        return FloatingActionButton.large(
          // FAB 마이크 버튼
          onPressed: () {
            if (speechProvider.isListening) {
              speechProvider.stopListening();
            } else {
              speechProvider.startListening();
            }
          },
          backgroundColor: Color(0xFF528DD7),
          child: Icon(
            speechProvider.isListening ? Icons.mic_off : Icons.mic,
            color: Color(0xFFFFFDF4),
          ),
          shape: CircleBorder(),
        );
      },
    );
  }
}
