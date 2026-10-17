import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../STT/compareSentence.dart';
import '../STT/stt.dart';

class ReviewRecordBtn extends StatelessWidget {
  final String bookTitle;
  final String genre;
  final String currentSentence; // 현재 문장을 받는 필드
  final String userSentence; // 사용자가 발음한 문장
  final String uid;
  final int currentPage;

  const ReviewRecordBtn({
    super.key,
    required this.bookTitle,
    required this.genre,
    required this.currentSentence,
    required this.userSentence,
    required this.uid,
    required this.currentPage,
  });

  Future<void> _manageFirestoreData(bool compareCheckSentence) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // users 컬렉션에서 uid에 해당하는 문서
      final userDoc = firestore.collection('users').doc(uid);

      // Book 컬렉션에서 bookTitle로 된 문서에 접근
      final bookDoc = userDoc.collection('Book').doc(bookTitle);

      // learned 컬렉션에서 originalSentence가 currentSentence와 같은 문서에 접근
      final learnedCollection = bookDoc.collection('learned');

      // originalSentence가 currentSentence와 같은 문서를 쿼리
      final querySnapshot = await learnedCollection
          .where('originalSentence', isEqualTo: currentSentence)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final learnedDoc = querySnapshot.docs.first.reference;

        if (compareCheckSentence) {
          // 문서 자체를 삭제
          await learnedDoc.delete();
        } else {
          // wrongSentence 필드만 업데이트
          await learnedDoc.update({
            'wrongSentence': userSentence,
          });
        }
      }
    } catch (e) {
      print("Firestore 데이터 관리 중 오류 발생: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    bool compareCheckSentence = true;
    return Consumer<SpeechToTextProvider>(
      builder: (context, speechProvider, child) {
        return FloatingActionButton(
          //FAB 마이크 버튼
          onPressed: () async {
            if (speechProvider.isListening) {
              speechProvider.stopListening();
              compareCheckSentence =
                  compareCheck(currentSentence, userSentence);
              print("일치 여부: $compareCheckSentence");

              // Firestore 데이터 관리
              await _manageFirestoreData(compareCheckSentence);
            } else {
              speechProvider.startListening();
            }
          },
          backgroundColor: const Color(0xFFFF9C4D),
          child: Icon(
            speechProvider.isListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
          ), //마이크 아이콘
          shape: const CircleBorder(),
        );
      },
    );
  }
}
