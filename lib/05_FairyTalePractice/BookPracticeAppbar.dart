import 'package:flutter/material.dart';

class BookPracticeAppbar extends StatelessWidget {
  const BookPracticeAppbar({
    super.key,
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFF9C4D),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,//색변경
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), 
        ),
      ),
      title: Text( //앱바의 도서 제목
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24
        ),
      ),
    );
  }
}