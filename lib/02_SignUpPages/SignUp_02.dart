import 'package:ddd_02/02_SignUpPages/signUp_03.dart';
import 'package:flutter/material.dart';

class SignUpPage_02 extends StatefulWidget {
  const SignUpPage_02({super.key});

  @override
  State<SignUpPage_02> createState() => _SignUpPage_02State();
}

class _SignUpPage_02State extends State<SignUpPage_02> {
  // 텍스트 입력을 관리할 컨트롤러
  final TextEditingController _nameController = TextEditingController();
  // 경고 텍스트의 표시 여부를 결정할 불리언 변수
  bool _showWarningText = false;
  String userName ='';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 화면 어디든 클릭하면 키보드가 내려갑니다.
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
                            offset: Offset(0,2),
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
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                                    child: Text('이름'),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                                  child: TextField(//-----------------------------------------------------텍스트필드
                                    onChanged: (value) {//----------------텍스트값 다음 페이지에 넘겨야하니까 값 받아오기
                                      userName = value;
                                    },
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      labelText: '이름',
                                      hintText: '이름',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: const BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: _showWarningText,
                                  child: Align(
                                    alignment: AlignmentDirectional(-1, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(30, 5, 0, 0),
                                      child: Text(
                                        '이름을 입력하세요.',
                                        style: TextStyle(
                                          color: Color(0xFF888888),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minWidth: double.infinity,
                              height: 40,
                              child: ElevatedButton(//-----------------------------------------------------------다음페이지 넘기는 버튼
                                onPressed: () {
                                  // 버튼을 누를 때 이름 입력 여부를 확인합니다.
                                  if (_nameController.text.isEmpty) {
                                    setState(() {
                                      _showWarningText = true;
                                    });
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SignUpPage_03(userName: _nameController.text))
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF6B74),
                                  minimumSize: Size(300, 40)
                                ),
                                child: const Text(
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
