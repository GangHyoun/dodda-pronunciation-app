import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/04_VowelHomePages/VowelAppbar.dart';
import 'package:ddd_02/04_VowelPractice/VowelRecordBtn.dart';
import 'package:ddd_02/04_VowelPractice/VowelResultRow.dart';
import 'package:ddd_02/04_VowelPractice/VowelWordContainer.dart';
import 'package:flutter/material.dart';
import 'package:ddd_02/STT/stt.dart';
import 'package:provider/provider.dart';
import 'package:ddd_02/03_HomePages/Home.dart';

class VowelPractice extends StatefulWidget {
  const VowelPractice({
    super.key,
    required this.vowel,
    required this.uid,
  });
  final String vowel;
  final String uid;

  @override
  State<VowelPractice> createState() => _VowelPracticeState();
}

class _VowelPracticeState extends State<VowelPractice> {
  List<String> wordIds = []; // List to hold the fetched Document IDs
  int currentWordIndex = 0; // 현재 단어 인덱스

  @override
  void initState() {
    super.initState();
    fetchWordIds();
  }

  Future<void> fetchWordIds() async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('DiphthongWord')
          .doc(widget.vowel)
          .collection('word');
      var snapshot = await collection.get();
      var fetchedWordIds = snapshot.docs.map((doc) => doc.id).toList();
      setState(() {
        wordIds = fetchedWordIds;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void goToPreviousWord() {
    if (currentWordIndex > 0) {
      setState(() {
        currentWordIndex--;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("현재 첫 번째 페이지 입니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  void goToNextWord() async {
    if (currentWordIndex < wordIds.length - 1) {
      setState(() {
        currentWordIndex++;
      });
    } else {
      bool exit = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("마지막 페이지 입니다"),
            content: Text("학습을 종료하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("확인"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("취소"),
              ),
            ],
          );
        },
      );
      if (exit) {
        var userName = await getUserName(widget.uid);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomePage(
                userName: userName,
                uid: widget.uid,
              ),
            ),
            (route) => false);
      }
    }
  }

// Home 화면으로 이동할 때 사용할 userName
  Future<String> getUserName(String uid) async {
    try {
      var document = FirebaseFirestore.instance.collection('users').doc(uid);
      var snapshot = await document.get();
      return snapshot.data()?['userName'] ?? 'User';
    } catch (e) {
      print("Error fetching user name: $e");
      return 'User';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold -> ChangeNotifierProvider 로 변경 (STT 실시간 데이터 전송용)
    return ChangeNotifierProvider(
      create: (_) => SpeechToTextProvider(),
      child: Scaffold(
        backgroundColor: Color(0xFFFFFDF4),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: VowelAppBar(),
        ),
        body: Consumer<SpeechToTextProvider>(
          builder: (context, speechProvider, child) {
            return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 16, 0),
              child: Column(
                children: [
                  VowelResultRow(
                    // result 사용자 발음, compareWord 비교 단어
                    result: speechProvider.text,
                    compareWord: wordIds.isNotEmpty
                        ? wordIds[currentWordIndex]
                        : 'Loading...',
                  ),
                  VowelWordContainer(
                    word: wordIds.isNotEmpty
                        ? wordIds[currentWordIndex]
                        : 'Loading...',
                    vowel: widget.vowel,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: VowelBottomNavigate(
          onPrevious: goToPreviousWord,
          onNext: goToNextWord,
        ),
        floatingActionButton: VowelRecordBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

// 하단 버튼 이동 바
class VowelBottomNavigate extends StatelessWidget {
  const VowelBottomNavigate({super.key, this.onPrevious, this.onNext});

  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Color(0xFFFF6B74),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: onPrevious,
            icon: Icon(Icons.navigate_before),
            color: Color(0xFFFFFDF4),
          ),
          IconButton(
            onPressed: onNext,
            icon: Icon(Icons.navigate_next),
            color: Color(0xFFFFFDF4),
          ),
        ],
      ),
    );
  }
}
