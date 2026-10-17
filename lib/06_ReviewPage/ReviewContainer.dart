import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/STT/compareSentence.dart';
import 'package:ddd_02/TTS/tts.dart';
import 'package:flutter/material.dart';

class ReviewContainer extends StatefulWidget {
  final String booktitle;
  final String genre;
  final String currentSentence; // 현재 문장을 받는 새로운 필드
  final String userSentence; // 사용자가 발음한 문장
  final String wrongSentence;

  const ReviewContainer(
      {super.key,
      required this.booktitle,
      required this.genre,
      required this.currentSentence,
      required this.userSentence,
      required this.wrongSentence,
      required this.uid});

  final String uid;

  @override
  State<ReviewContainer> createState() => _ReviewContainerState();
}

class _ReviewContainerState extends State<ReviewContainer> {
  double fontSize = 20; // Default font size

  @override
  void initState() {
    super.initState();
    fetchFontSize();
  }

  void fetchFontSize() async {
    var settingsDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('Setting')
        .doc('Settings');
    settingsDoc.get().then((snapshot) {
      if (snapshot.exists && snapshot.data()!.containsKey('fontsize')) {
        setState(() {
          fontSize = snapshot.data()!['fontsize'].toDouble();
        });
      }
    }).catchError((error) {
      print("Failed to fetch font size: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // screenSize를 현재 컨텍스트의 MediaQuery를 통해 얻습니다.
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height, // 고정 높이
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => speakText(widget.currentSentence),
              // 발음 듣기 버튼 동작
              icon: Icon(Icons.campaign_rounded),
              color: Color(0xFFFFD664),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFFFD664),
                border: Border.all(color: Color(0xFFFFF7E2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: buildComparisonText(
                      widget.currentSentence, widget.wrongSentence, fontSize)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              //--------------------------------------------------------------------------------사용자 발음 문장이 들어가는 Container2
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFFFF7E2),
                  border: Border.all(color: Color(0xFFFFD664)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 3))
                  ]),
              child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                  child: buildComparisonText(widget.userSentence,
                      widget.currentSentence, fontSize)), //발음 비교
            ),
          ],
        ),
      ),
    );
  }
}
