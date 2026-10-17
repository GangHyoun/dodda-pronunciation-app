import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddd_02/STT/stt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/STT/compareSentence.dart';

class FairyTaleRecordBtn extends StatelessWidget {
  final String bookTitle;
  final String genre;
  final String currentSentence; // 현재 문장을 받는 새로운 필드
  final String userSentence; // 사용자가 발음한 문장
  final String uid;
  final int currentPage;

  const FairyTaleRecordBtn({
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

      // Book 컬렉션 존재 확인
      final bookCollectionRef = userDoc.collection('Book');
      final bookCollectionSnapshot = await bookCollectionRef.get();
      if (bookCollectionSnapshot.docs.isEmpty) {
        // Book 컬렉션이 없으면 booktitle로 된 문서 생성
        final bookDoc = bookCollectionRef.doc(bookTitle);
        await bookDoc.set({
          'genre': genre,
          'learnedPage': currentPage, // learnedPage 필드 추가
        });
      } else {
        // Book 컬렉션이 존재하면 booktitle 문서에 대한 처리
        final bookDoc = bookCollectionRef.doc(bookTitle);
        final bookDocSnapshot = await bookDoc.get();
        if (!bookDocSnapshot.exists) {
          // booktitle 문서가 없으면 생성
          await bookDoc.set({
            'genre': genre,
            'learnedPage': currentPage, // learnedPage 필드 추가
          });
        } else {
          // 문서가 있으면 learnedPage 필드를 가져옴
          int learnedPage = bookDocSnapshot.data()?['learnedPage'] ?? 0;
          if (currentPage > learnedPage) {
            // currentPage가 더 크면 업데이트
            await bookDoc.update({
              'learnedPage': currentPage,
            });
          }
        }
      }

      final learnedDoc = bookCollectionRef.doc(bookTitle).collection('learned').doc(currentPage.toString());

      if (!compareCheckSentence) {
        // compareCheckSentence가 false인 경우
        final learnedDocSnapshot = await learnedDoc.get();
        if (learnedDocSnapshot.exists) {
          // 문서가 존재하면 wrongSentence 업데이트
          await learnedDoc.update({
            'wrongSentence': userSentence,
          });
        } else {
          // 문서가 없으면 새로 생성
          await learnedDoc.set({
            'originalSentence': currentSentence,
            'wrongSentence': userSentence,
          });
        }
      } else {
        // compareCheckSentence가 true인 경우
        final learnedDocSnapshot = await learnedDoc.get();
        if (learnedDocSnapshot.exists) {
          await learnedDoc.delete();
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
              print("일치여부 : $compareCheckSentence");

              // Firestore 데이터 관리
              await _manageFirestoreData(compareCheckSentence);
              
            } else {
              speechProvider.startListening();
            }
          },
          backgroundColor: Color(0xFFFF9C4D),
          child: Icon(
            speechProvider.isListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
          ), //마이크 아이콘
          shape: CircleBorder(),
        );
      },
    );
  }
}
