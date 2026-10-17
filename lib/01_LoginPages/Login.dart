import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/02_SignUpPages/SignUp_01.dart';
import 'package:ddd_02/03_HomePages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = userCredential.user;
      if (user != null) {
        final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final doc = await docRef.get();
        if (doc.exists) {
          final userName = doc.data()?['userName'] ?? 'No Name';
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(userName: userName, uid: user.uid))
          );
        } else {
          print('No user data available');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in with Email & Password'),
      ));
      print(e);
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
        backgroundColor: const Color(0xFFFFF7E2),
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
                    //앵무새 이미지
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Image.asset(
                        'assets/images/01.png',
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
      
                    
                    //-----------------------------------------------------------------------------------입력란 컨테이너 박스
                    Container(
                      width: 300,
                      height: 350,               
                      decoration: BoxDecoration( //------------------------------------------------------입력란 컨테이너 박스 모서리 둥글게
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFFFFDF4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0,2), //그림자 방향 지정
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            '로그인',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          //--------------------------------------------------------------------------------아이디 입력란
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: '아이디',
                                //labelStyle: ,
                                hintText: '아이디',
                                //hintStyle: ,
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const  Color(0xFFFF6B74),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),     
                          //--------------------------------------------------------------------------------비밀번호 입력란
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: '비밀번호',
                                //labelStyle: ,
                                hintText: '비밀번호',
                                //hintStyle: ,
                                //border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const  Color(0xFFFF6B74),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                    //color: const Color(0xFFFFFDF4),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const  EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                            child: ButtonTheme(
                               //버튼 둥글게 만들기 용
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minWidth: double.infinity,
                              height: 40,
                              child: ElevatedButton(//--------------------------
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF6B74),
                                  minimumSize: Size(300, 40)
                                ),
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: Color(0xFFFFFDF4),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '아직 계정이 없으신가요?',
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context)=> const SignUpPage01())
                                        );
                                      }, 
                                      child: Text(
                                        '회원가입',
                                        style: TextStyle(
                                          color: Color(0xFF6299F3),
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ]
                                ),
                              ),
                              /*
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '계정을 잊으셨나요?',
                                      style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:(){}, 
                                      child: Text(
                                        '계정 찾기',
                                        style: TextStyle(
                                          color: Color(0xFF6299F3),
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ]
                                ),
                              ),
                              */
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),      
            ),
          ],
        ),
        
      ),
    );
  }
}