import 'package:ddd_02/04_VowelHomePages/VowelAppbar.dart';
import 'package:ddd_02/04_VowelHomePages/VowelExplain.dart';
import 'package:ddd_02/04_VowelHomePages/VowelLearningBtn.dart';
import 'package:ddd_02/04_VowelHomePages/VowelType.dart';
import 'package:flutter/material.dart';

class VowelHome extends StatefulWidget {
  const VowelHome({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<VowelHome> createState() => _VowelHomeState();
}

class _VowelHomeState extends State<VowelHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color(0xFFFFFDF4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: VowelAppBar()
      ),
      body: Column(
        children: [
          VowelLearningBtn(uid: widget.uid),
          VowelExplain(),
          SizedBox(
            height: 40,
          ),
          VowelType(uid: widget.uid)
        ],
      )

    );
  }
}