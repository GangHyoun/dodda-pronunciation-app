import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/02_SignUpPages/SignUp_06.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage_05 extends StatefulWidget {
  const SignUpPage_05({super.key, required this.userName, required this.email});

  final String userName;
  final String email;

  @override
  State<SignUpPage_05> createState() => _SignUpPage_05State();
}

class _SignUpPage_05State extends State<SignUpPage_05> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isButtonPressed = false;
  String _validationMessage = '';

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_clearMessage);
    _confirmPasswordController.addListener(_clearMessage);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_clearMessage);
    _confirmPasswordController.removeListener(_clearMessage);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    if (_passwordController.text.length < 6) {
      setState(() {
        _validationMessage = '비밀번호는 6자리 이상이어야 합니다';
      });
    } else if (_passwordController.text == _confirmPasswordController.text) {
      setState(() {
        _validationMessage = '비밀번호가 확인되었습니다';
      });
    } else {
      setState(() {
        _validationMessage = '다시 확인하세요';
      });
    }
  }

  void _clearMessage() {
    if (_isButtonPressed) {
      setState(() {
        _isButtonPressed = false;
      });
    }
  }

  void _navigateToNextPage() {
    setState(() {
      _isButtonPressed = true;
    });
    _validatePasswords();

    if (_validationMessage == '비밀번호가 확인되었습니다') {
      _registerUser();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('비밀번호를 다시 확인해주세요.')));
    }
  }

//-----------가입
  Future<void> _registerUser() async {
    try {
      // 사용자 계정 생성
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: widget.email, password: _passwordController.text);

      // Firestore에 사용자 이름과 이메일 저장
      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid);

      await userDocRef
          .set({'userName': widget.userName, 'email': widget.email});

      await userDocRef.collection('Book').add({'initial': 'data'});

      // 해당 사용자 문서 내에 'Setting' 서브 컬렉션을 생성하고 'Settings' 문서에 'fontsize' 설정
      await userDocRef
          .collection('Setting')
          .doc('Settings')
          .set({'fontsize': 18});

      // 회원가입 페이지로 이동
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SignUpPage_06()));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('오류: ${e.message}')));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('알 수 없는 오류가 발생했습니다. 자세한 정보: ${e.toString()}')));
    }
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
                    Container(
                      width: 300,
                      height: 420,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFFFDF4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
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
                                const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                                    child: Text(
                                      '비밀번호',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                  child: TextField(
                                    //---------------------------------------------비밀번호 텍필
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: '비밀번호',
                                      hintText: '비밀번호',
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
                                const Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 20, 0, 0),
                                    child: Text(
                                      '비밀번호 확인',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                  child: TextField(
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      labelText: '비밀번호 확인',
                                      hintText: '비밀번호 확인',
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
                                if (_isButtonPressed)
                                  Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          30, 5, 0, 0),
                                      child: Text(
                                        _validationMessage,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF888888),
                                        ),
                                      ),
                                    ),
                                  ),
                                Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                    child: ButtonTheme(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      minWidth: 90,
                                      height: 27,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _isButtonPressed = true;
                                          });
                                          _validatePasswords();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFF6B74),
                                            minimumSize: Size(80, 27)),
                                        child: const Text(
                                          '확인',
                                          style: TextStyle(
                                            color: Color(0xFFFFFDF4),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minWidth: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: _navigateToNextPage,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF6B74),
                                    minimumSize: Size(300, 40)),
                                child: const Text(
                                  '가입완료',
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
            ),
          ],
        )
        
      ),
    );
  }
}
