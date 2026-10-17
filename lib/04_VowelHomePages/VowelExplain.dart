import 'package:ddd_02/04_VowelHomePages/VowelContainers.dart';
import 'package:flutter/material.dart';

class VowelExplain extends StatelessWidget {
  const VowelExplain({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return VowelContainers(
      stHeight: screenSize.height/5.8,
      color: Color(0xFFFF6B74),
      title: "이중 모음이란?",
      cHeight: screenSize.height/8,
      item: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: Text(
          '발음할 때 혀나 입술이 일정한 상태에 있지 않고 움직여서 음색이 한 번 변하는 모음을 뜻해요',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 20
          ),
        ),
      )
      
    );
  }
}