import 'package:flutter/material.dart';

class VowelWordBtn extends StatelessWidget {
  const VowelWordBtn({
    super.key,
    required this.color, //버튼 바탕 색깔 지정 속성
    required this.icon, // 버튼 아이콘 지정 속성
    required this.title //버튼 텍스트 지정 속성
  });

  final Color color; 
  final Icon icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: (){//-----------------------------------------버튼 눌렀을때 

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(screenSize.width/2, 80)
      ),
      child: Column(//세로 배치
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [//Column안에 들어간 위젯들
          icon,
            //아까 아이콘
          Text( //그리고 텍스트
            title, //title 
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }
}