
import 'package:flutter/material.dart';

class SignUpPage_04 extends StatefulWidget {
  const SignUpPage_04({super.key});

  @override
  State<SignUpPage_04> createState() => _SignUpPage_04State();
}

class _SignUpPage_04State extends State<SignUpPage_04> {
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: const Text(
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
                                Text(
                                    '앞의 이메일로 인증코드를 보내드렸어요!'
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '인증코드가 오지 않았나요?',
                                        style: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: (){},
                                        child: Text(
                                          '재전송',
                                          style: TextStyle(
                                            color: Color(0xFF6299F3),
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                                    child: Text(
                                      '인증코드',
                                    ),
                                  ),
                                ),
                            
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 5),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: '인증코드',
                                      //labelStyle: ,
                                      hintText: '인증코드',
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
                                Align(
                                  alignment: AlignmentDirectional(1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                                    child: ButtonTheme(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:  BorderRadius.circular(20),
                                      ),
                                      minWidth: 90,
                                      height: 27,
                                      child: ElevatedButton(
                                        onPressed: (){},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFF6B74),
                                          minimumSize: Size(80, 27)
                                        ),
                                        child: Text(
                                          '확인',
                                          style: TextStyle(
                                            color: Color(0xFFFFFDF4),
                                          ),
                                        ),
                                      ),
                                    ),
                                   
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                  child: Text(
                                    '올바른 코드 입니다.',
                                    style: TextStyle(
                                      color: Color(0xFF888888),
                                    ),
                                  )
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
                                  
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF6B74),
                                  minimumSize: Size(300, 40)
                                ),
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