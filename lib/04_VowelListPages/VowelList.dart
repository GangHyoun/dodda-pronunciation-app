import 'package:ddd_02/04_VowelHomePages/VowelAppbar.dart';
import 'package:ddd_02/04_VowelListPages/VowelListBtn.dart';
import 'package:flutter/material.dart';

class VowelList extends StatefulWidget {
  const VowelList({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<VowelList> createState() => _VowelListState();
}

class _VowelListState extends State<VowelList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFDF4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: VowelAppBar()
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              VowelListBtn(color: Color(0xFF00BFBA), vowel: 'ㅑ', uid: widget.uid),//1
              VowelListBtn(color: Color(0xFFFF9C4D), vowel: 'ㅒ', uid: widget.uid),//2
              VowelListBtn(color: Color(0xFF86DCEC), vowel: 'ㅕ', uid: widget.uid),//3
              VowelListBtn(color: Color(0xFFFF6B74), vowel: 'ㅖ', uid: widget.uid),//4
              VowelListBtn(color: Color(0xFFFFD664), vowel: 'ㅘ', uid: widget.uid),//5
              VowelListBtn(color: Color(0xFFBCA5D4), vowel: 'ㅙ', uid: widget.uid),//6
              VowelListBtn(color: Color(0xFF86DCEC), vowel: 'ㅛ', uid: widget.uid),//7
              VowelListBtn(color: Color(0xFF00BFBA), vowel: 'ㅝ', uid: widget.uid),//8
              VowelListBtn(color: Color(0xFFFF9C4D), vowel: 'ㅞ', uid: widget.uid),//9
              VowelListBtn(color: Color(0xFFFF6B74), vowel: 'ㅠ', uid: widget.uid),//10
              VowelListBtn(color: Color(0xFF528DD7), vowel: 'ㅢ', uid: widget.uid),//11
 
            ],
          ),
        )
      )
    );
  }
}