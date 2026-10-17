import 'package:ddd_02/01_LoginPages/Login.dart';
import 'package:flutter/material.dart';

class SignUpPage_06 extends StatefulWidget {
  const SignUpPage_06({super.key});

  @override
  State<SignUpPage_06> createState() => _SignUpPage_06State();
}

class _SignUpPage_06State extends State<SignUpPage_06> {
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
                      decoration: BoxDecoration( //---------------------------------------------------입력란 컨테이너 박스 모서리 둥글게
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFFFFFDF4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0,2), //그림자 방향 지정
                          )
                        ]
                      ),   
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              '환영합니다!',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/08.png',
                            width: 180,
                            height: 290,
                            fit: BoxFit.contain,
                          ),
    
    
    
                          Padding(
                            padding: const  EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
                            child: ButtonTheme(
                               //버튼 둥글게 만들기 용
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minWidth: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context)=> LoginPage()),
                                    (route) => false
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF6B74),
                                  minimumSize: Size(300, 40)
                                ),
                                child: Text(
                                  '로그인 창으로',
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