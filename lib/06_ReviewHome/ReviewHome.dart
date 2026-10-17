import 'package:ddd_02/05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/06_ReviewHome/ReviewDataGridView.dart';
import 'package:flutter/material.dart';

class ReviewHome extends StatefulWidget {
  const ReviewHome({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<ReviewHome> createState() => _ReviewHomeState();
}

class _ReviewHomeState extends State<ReviewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child:FairyTaleAppbar(appbarTitle: '틀린 문장 다시 읽기', color:  Color(0xFF86DCEC),)
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
        child: ReviewDataGridView(uid: widget.uid),
      )
        
    );
  }
}