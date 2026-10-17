import 'package:ddd_02/04_VowelHomePages/VowelContainers.dart';
import 'package:ddd_02/04_VowelHomePages/VowelDataGridBtn.dart';
import 'package:flutter/material.dart';

class VowelType extends StatelessWidget {
  const VowelType({
    super.key,
    required this.uid
  });
  final String uid;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return VowelContainers(
      stHeight: screenSize.height/2.6,//340,
      color: Color(0xFF86DCEC),
      title: "이중 모음 종류",
      cHeight: screenSize.height/3,//300,
      item: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 13, 10, 0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1
          ),
          //scrollDirection: Axis.vertical,
          children: [
            VowelDataGridBtn(color: Color(0xFF00BFBA), vowel: "ㅑ", uid: uid),//1
            VowelDataGridBtn(color: Color(0xFFFF9C4D), vowel: "ㅒ", uid: uid),//2
            VowelDataGridBtn(color: Color(0xFFFFF7E2), vowel: "ㅕ", uid: uid),//3
            VowelDataGridBtn(color: Color(0xFFFF6B74), vowel: "ㅖ", uid: uid),//4
            VowelDataGridBtn(color: Color(0xFFFFD664), vowel: "ㅘ", uid: uid),//5
            VowelDataGridBtn(color: Color(0xFFBCA5D4), vowel: "ㅙ", uid: uid),//6
            VowelDataGridBtn(color: Color(0xFF86DCEC), vowel: "ㅛ", uid: uid),//7
            VowelDataGridBtn(color: Color(0xFF00BFBA), vowel: "ㅝ", uid: uid),//8
            VowelDataGridBtn(color: Color(0xFFFFF7E2), vowel: "ㅞ", uid: uid),//9
            VowelDataGridBtn(color: Color(0xFFFF6B74), vowel: "ㅠ", uid: uid),//10
            VowelDataGridBtn(color: Color(0xFF528DD7), vowel: "ㅢ", uid: uid),//11
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/08.png',
                width: 300,
                height: 200,
                fit: BoxFit.contain,
              ),
            )
          ],
        )
      )
    );
  }
}