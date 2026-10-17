import 'package:ddd_02/02_SignUpPages/signUp_02.dart';
import 'package:flutter/material.dart';

class SignUpPage01 extends StatefulWidget {
  const SignUpPage01({super.key});

  @override
  State<SignUpPage01> createState() => _SignUpPage01State();
}

class _SignUpPage01State extends State<SignUpPage01> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: 
      Scaffold(
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
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                            offset: const Offset(0,2), //그림자 방향 지정
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
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                  child: Text(
                                    '반가워요! 우리 만난 적이 있나요?',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(30, 10, 30, 0),
                                  child: Image.asset(
                                    'assets/images/08.png',
                                    width: 300,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                
                              ],
                            ),
    
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>const SignUpPage_02()) 
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF6B74),
                                  minimumSize: const Size(300, 40)
                                ),
                                child: const Text(
                                  '회원가입',
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