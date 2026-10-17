import 'package:ddd_02/05_FairyTaleHome/BookSearchBar.dart';
import 'package:ddd_02/05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/05_FairyTaleListPage/FairyTaleDataGridView.dart';
import 'package:flutter/material.dart';

class FairyTaleList extends StatefulWidget {
  const FairyTaleList({
    super.key,
    required this.title,
    required this.genre,
    required this.uid
  });
  final String title;
  final String genre;
  final String uid;

  @override
  State<FairyTaleList> createState() => _FairyTaleListState();
}

class _FairyTaleListState extends State<FairyTaleList> {
  @override
  
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child:FairyTaleAppbar(appbarTitle: '도서 읽기', color:  Color(0xFFFF9C4D),)
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(//------------------------------------------------------중앙에 장르 명칭 텍스트
              widget.title,
              style: TextStyle(
                fontSize: 30
              ),
            ),
           
            Padding(
              padding:  EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
              child: FairyTaleDataGridView(genre: widget.genre, uid: widget.uid,)
            )
            
          ],
        )
        
      ),
    );
  }
}