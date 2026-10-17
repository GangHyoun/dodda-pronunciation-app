import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTalePractice/BookPracticeAppbar.dart';
import 'package:ddd_02/05_FairyTalePractice/FairyTaleBodyContainer.dart';
import 'package:ddd_02/05_FairyTalePractice/FairyTaleBottomBar.dart';
import 'package:ddd_02/05_FairyTalePractice/FairyTaleRecordBtn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddd_02/STT/stt.dart';
import 'package:ddd_02/03_HomePages/Home.dart';

class FairyTalePractice extends StatefulWidget {
  const FairyTalePractice(
      {super.key,
      required this.booktitle,
      required this.genre,
      required this.uid});

  final String genre;
  final String booktitle;
  final String uid;

  @override
  State<FairyTalePractice> createState() => _FairyTalePracticeState();
}

class _FairyTalePracticeState extends State<FairyTalePractice> {
  int currentSentenceIndex = 0;
  List<String> sentences = [];
  String backgroundImgUrl = ''; // State variable to store the image URL
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchDescriptionsAndImage().then((data) {
      setState(() {
        sentences = data['descriptions'] as List<String>;
        backgroundImgUrl =
            data['backgroundImg'] as String; // Update the URL state
      });
    });

    fetchUserName(); // Fetch user name
  }

  // Fetch descriptions and background image URL from Firestore
  Future<Map<String, dynamic>> fetchDescriptionsAndImage() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference bookRef = firestore
        .collection('Book')
        .doc(widget.genre)
        .collection('fable')
        .doc(widget.booktitle);

    DocumentSnapshot snapshot = await bookRef.get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (snapshot.exists && data != null) {
      List<dynamic> descriptions = data['description'] as List<dynamic>;
      String backgroundImg =
          data['backgroundImg'] ?? ''; // Get the background image URL
      return {
        'descriptions': descriptions.map((e) => e.toString()).toList(),
        'backgroundImg': backgroundImg
      };
    } else {
      return {
        'descriptions': ["해당 문서가 존재하지 않거나 설명 데이터가 없습니다."],
        'backgroundImg': '' // Default or placeholder image URL
      };
    }
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

      await fetchLearnedPage();
    }
  }

  // 학습한 페이지 정보 불러오기
  Future<void> fetchLearnedPage() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference bookRef = firestore
        .collection('users')
        .doc(widget.uid)
        .collection('Book')
        .doc(widget.booktitle);

    DocumentSnapshot snapshot = await bookRef.get();
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (snapshot.exists && data != null) {
      int learnedPage = data['learnedPage'] as int;
      bool checkLearned = data['checkLearned'] as bool? ?? false;

      //checkLearned : true, learnedPage : null인 상태에서
      //0 page를 학습한 경우 null로 뜸-> 해결 필요
      if (learnedPage == sentences.length - 1) {
        await bookRef.update({
          'checkLearned': true,
          'learnedPage': learnedPage == 0 ? 0 : null,
        });
        if (checkLearned) {
          setState(() {
            currentSentenceIndex = 0;
          });
          return;
        }
      } else {
        if (!checkLearned) {
          await bookRef.update({'checkLearned': false});
        }
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("알림"),
              content: Text("학습하던 페이지가 있습니다. 해당 페이지부터 학습하시겠습니까?"),
              actions: [
                TextButton(
                  child: Text("확인"),
                  onPressed: () {
                    setState(() {
                      currentSentenceIndex = learnedPage + 1;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("취소"),
                  onPressed: () {
                    setState(() {
                      currentSentenceIndex = 0;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        currentSentenceIndex = 0;
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
          child: BookPracticeAppbar(title: widget.booktitle),
        ),
        body: Container(
          //---------------------------------------------
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(backgroundImgUrl), // 이 부분을 실제 이미지 URL로 변경
              fit: BoxFit.fill, // 이미지를 컨테이너에 맞게 조절
            ),
          ),

          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Consumer<SpeechToTextProvider>(
              builder: (context, speechProvider, child) {
                return FairyTaleBodyContainer(
                  genre: widget.genre,
                  booktitle: widget.booktitle,
                  currentSentence: sentences.isNotEmpty
                      ? sentences[currentSentenceIndex]
                      : "",
                  userSentence: speechProvider.text,
                  uid: widget.uid,
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: FairyTaleBottomBar(
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
            return FairyTaleRecordBtn(
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
