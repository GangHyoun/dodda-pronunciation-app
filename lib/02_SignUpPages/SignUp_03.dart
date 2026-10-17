import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/02_SignUpPages/SignUp_05.dart';
import 'package:ddd_02/02_SignUpPages/signUp_04.dart';
import 'package:flutter/material.dart';

class SignUpPage_03 extends StatefulWidget {
  SignUpPage_03({super.key, required this.userName});
  final String userName;

  @override
  State<SignUpPage_03> createState() => _SignUpPage_03State();
}

class _SignUpPage_03State extends State<SignUpPage_03> {
  bool _isEmailAvailable = false; // 메시지 가시성을 제어하기 위한 변수
  String _emailMessage = ''; // 이메일 검증 메시지를 저장할 변수
  final TextEditingController _emailController =
      TextEditingController(); // 이메일 입력을 관리하는 컨트롤러
  final FocusNode _emailFocusNode = FocusNode(); // FocusNode 추가

  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange); // 리스너 추가
  }

  void _onFocusChange() {
    if (_emailFocusNode.hasFocus) {
      setState(() {
        _emailMessage = ''; // 포커스가 있을 때 메시지를 비웁니다.
      });
    }
  }

  void _verifyEmail() async {
    String email = _emailController.text.trim(); // 입력된 이메일을 가져옵니다.
    if (email.isEmpty) {
      setState(() {
        _emailMessage = '이메일을 입력해주세요';
        _isEmailAvailable = false;
      });
      return;
    }

    // 여기에 Firebase 이메일 검증 로직을 추가하세요
    bool isDuplicate = false; // 이메일 중복 검사 결과를 시뮬레이션
    try {
      var collection = FirebaseFirestore.instance.collection('users');
      var duplicate_email =
          await collection.get().then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          print(doc["email"]);
          if (email == doc["email"]) {
            isDuplicate = true;
          }
        });
      });
    } catch (e) {
      print(e);
      isDuplicate = false;
    }
    setState(() {
      if (isDuplicate) {
        _emailMessage = '이미 사용중인 이메일입니다.';
        _isEmailAvailable = false;
      } else {
        _emailMessage = '사용 가능한 이메일 입니다.';
        _isEmailAvailable = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFFFF7E2),
          body: Stack(
            children: [
              Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              )
            ),
            SafeArea(
              top: true,
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Image.asset(
                        'assets/images/05.png',
                        width: 160,
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                    //--------------------------------------------------------------------------------입력란 컨테이너 박스
                    Container(
                      width: 300,
                      height: 420,
                      decoration: BoxDecoration(
                          //---------------------------------------------------입력란 컨테이너 박스 모서리 둥글게
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFFFDF4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 2), //그림자 방향 지정
                            )
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '회원가입',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 280,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 0, 0, 0),
                                    child: Text(
                                      '이메일',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 0, 30, 0),
                                  child: TextField(
                                    //----------------------------------------------------텍스트 필드
                                    focusNode: _emailFocusNode,
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: '이메일',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 40, 0),
                                    child: ButtonTheme(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      minWidth: 90,
                                      height: 27,
                                      child: ElevatedButton(
                                        onPressed: _verifyEmail,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFF6B74),
                                            minimumSize: Size(80, 27)),
                                        child: const Text(
                                          '중복확인',
                                          style: TextStyle(
                                            color: Color(0xFFFFFDF4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_emailMessage.isNotEmpty)
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 30, 0, 0),
                                      child: Text(
                                        _emailMessage,
                                        style: TextStyle(
                                          color: Color(0xFF888888),
                                        ),
                                      )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30, 0, 30, 20),
                            child: ButtonTheme(
                              //버튼 둥글게 만들기 용
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minWidth: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _isEmailAvailable
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpPage_05(
                                                      userName: widget.userName,
                                                      email:
                                                          _emailController.text,
                                                    )));
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF6B74),
                                    minimumSize: Size(300, 40)),
                                child: Text(
                                  '계속하기',
                                  style: TextStyle(
                                    color: Color(0xFFFFFDF4),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

            ],
          )

          
        ),
    );
  }
}
