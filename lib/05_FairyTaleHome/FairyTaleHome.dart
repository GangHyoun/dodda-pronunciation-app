import 'package:ddd_02/05_FairyTaleHome/BookActivityItem.dart';
import 'package:ddd_02/05_FairyTaleHome/BookListView.dart';
import 'package:ddd_02/05_FairyTaleHome/BookSearchBar.dart';
import 'package:ddd_02/05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/05_FairyTaleHome/ReviewBtn.dart';
import 'package:flutter/material.dart';

class FairyTaleHome extends StatefulWidget {
  const FairyTaleHome({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<FairyTaleHome> createState() => _FairyTaleHomeState();
}

final

class _FairyTaleHomeState extends State<FairyTaleHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(       
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child:FairyTaleAppbar(appbarTitle: '도서 읽기', color: const Color(0xFFFF9C4D),)
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 20),
                child: ReviewBtn(uid: widget.uid ),
              ),
              BookSearchBar(uid: widget.uid,),//--------------------------------------검색창
              BookActivityItem(genre: 'ForeignFable', title: '세계명작', item: BookListView(genre: 'ForeignFable', uid: widget.uid,), uid: widget.uid ),
              BookActivityItem(genre: 'KoreanFable', title: '전래고전', item: BookListView(genre: 'KoreanFable', uid: widget.uid,), uid: widget.uid),
            ],
          ),
        )
      ),
    );
  }
}