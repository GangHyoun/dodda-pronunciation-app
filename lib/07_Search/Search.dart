import 'package:ddd_02/05_FairyTaleHome/BookSearchBar.dart';
import 'package:ddd_02/05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/07_Search/ResearchBar.dart';
import 'package:ddd_02/07_Search/SearchDataGridView.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.query, required this.uid});
  final String query;
  final String uid;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String currentQuery;

  @override
  void initState() {
    super.initState();
    currentQuery = widget.query; // 초기 query 설정
  }

  void updateQuery(String newQuery) {
    setState(() {
      currentQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child:
              FairyTaleAppbar(appbarTitle: '도서 검색', color: Color(0xFFFF9C4D)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15), //위 여백용
              ResearchBar(
                uid: widget.uid,
                query: widget.query,
                onSearch: updateQuery,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 20),
                child: SearchDataGridView(uid: widget.uid, query: currentQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
