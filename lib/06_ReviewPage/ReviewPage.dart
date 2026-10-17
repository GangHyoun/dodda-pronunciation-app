import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/06_ReviewPage/ReviewBottomBar.dart';
import 'package:ddd_02/06_ReviewPage/ReviewContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/STT/stt.dart';
import 'ReviewRecordBtn.dart';
import 'package:ddd_02/03_HomePages/Home.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    super.key,
    required this.booktitle,
    required this.genre,
    required this.uid,
  });

  final String genre;
  final String booktitle;
  final String uid;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int currentSentenceIndex = 0;
  List<String> sentences = [];
  List<String> wrongSentences = [];
  String backgroundImgUrl = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchBackgroundImage().then((imgUrl) {
      setState(() {
        backgroundImgUrl = imgUrl;
      });
    });
    fetchDescriptions().then((result) {
      setState(() {
        sentences = result['sentences'] ?? [];
        wrongSentences = result['wrongSentences'] ?? [];
      });
    });

    fetchUserName(); // Fetch user name
  }

  // Fetch background image URL from Firestore
  Future<String> fetchBackgroundImage() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference bookRef = firestore
        .collection('Book')
        .doc(widget.genre)
        .collection('fable')
        .doc(widget.booktitle);

    DocumentSnapshot snapshot = await bookRef.get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (snapshot.exists && data != null) {
      String backgroundImg =
          data['backgroundImg'] ?? ''; // Get the background image URL
      return backgroundImg;
    } else {
      return ''; // Default or placeholder image URL
    }
  }

  // Firestore에서 description 리스트를 직접 가져오기
  Future<Map<String, List<String>>> fetchDescriptions() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference learnedCollection = firestore
        .collection('users')
        .doc(widget.uid)
        .collection('Book')
        .doc(widget.booktitle)
        .collection('learned');

    QuerySnapshot snapshot = await learnedCollection.get();
    List<String> loadedSentences = [];
    List<String> loadedWrongSentences = [];

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        loadedSentences.add(data['originalSentence']?.toString() ?? '');
        loadedWrongSentences.add(data['wrongSentence']?.toString() ?? '');
      }
    }

    if (loadedSentences.isEmpty) {
      loadedSentences.add("해당 문서가 존재하지 않거나 설명 데이터가 없습니다.");
      loadedWrongSentences.add("");
    }

    return {
      'sentences': loadedSentences,
      'wrongSentences': loadedWrongSentences,
    };
  }

  // 사용자 이름 불러오기(홈 화면 이동 시 필요)
  Future<void> fetchUserName() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference userRef = firestore.collection('users').doc(widget.uid);

    DocumentSnapshot snapshot = await userRef.get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (snapshot.exists && data != null) {
      setState(() {
        userName = data['userName'] as String;
      });
    }
  }

  // 전 페이지 이동
  void goToPreviousSentence() {
    if (currentSentenceIndex > 0) {
      setState(() {
        currentSentenceIndex--;
      });
    } else {
      //첫 번째 페이지 알림
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("현재 첫 번째 페이지 입니다."),
            actions: [
              TextButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // 다음 페이지 이동
  void goToNextSentence() {
    if (currentSentenceIndex < sentences.length - 1) {
      setState(() {
        currentSentenceIndex++;
      });
    } else {
      //마지막 페이지 알림
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("마지막 페이지 입니다."),
            content: Text("학습을 종료하시겠습니까?"),
            actions: [
              TextButton(
                //확인 시 홈 화면으로 이동
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(userName: userName, uid: widget.uid)),
                      (route) => false);
                },
              ),
              TextButton(
                child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold -> ChangeNotifierProvider 로 변경 (STT 실시간 데이터 전송용)
    return ChangeNotifierProvider(
      create: (_) => SpeechToTextProvider(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: FairyTaleAppbar(
            appbarTitle: widget.booktitle,
            color: Color(0xFF86DCEC),
          ),
        ),
        body: Container(
          //---------------------------------------------
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(backgroundImgUrl.isNotEmpty
                  ? backgroundImgUrl
                  : 'https://via.placeholder.com/150'), // Default placeholder image URL
              fit: BoxFit.fill, // 이미지를 컨테이너에 맞게 조절
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Consumer<SpeechToTextProvider>(
              builder: (context, speechProvider, child) {
                return ReviewContainer(
                  genre: widget.genre,
                  booktitle: widget.booktitle,
                  currentSentence: sentences.isNotEmpty
                      ? sentences[currentSentenceIndex]
                      : "",
                  wrongSentence: wrongSentences.isNotEmpty
                      ? wrongSentences[currentSentenceIndex]
                      : "",
                  userSentence: speechProvider.text,
                  uid: widget.uid,
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: ReviewBottomBar(
          genre: widget.genre,
          booktitle: widget.booktitle,
          currentPage: currentSentenceIndex + 1,
          totalSentences: sentences.length,
          onSentenceChanged: (bool isNext) {
            if (isNext) {
              goToNextSentence();
            } else {
              goToPreviousSentence();
            }
          },
        ),
        // Firestore에 저장할 데이터 전달
        floatingActionButton: Consumer<SpeechToTextProvider>(
          builder: (context, speechProvider, child) {
            // sentenceNum으로 currentSentence를 전달
            String sentenceNum =
                sentences.isNotEmpty ? sentences[currentSentenceIndex] : "";

            return ReviewRecordBtn(
              bookTitle: widget.booktitle,
              genre: widget.genre,
              currentSentence:
                  sentences.isNotEmpty ? sentences[currentSentenceIndex] : "",
              userSentence: speechProvider.text,
              uid: widget.uid,
              currentPage: currentSentenceIndex,
            );
          },
        ),
      ),
    );
  }
}
