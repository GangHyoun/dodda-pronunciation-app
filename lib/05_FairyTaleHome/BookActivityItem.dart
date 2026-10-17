import 'package:ddd_02/05_FairyTaleListPage/FairyTaleList.dart';
import 'package:flutter/material.dart';

class BookActivityItem extends StatelessWidget {
  const BookActivityItem({
    super.key,
    required this.title,
    required this.item,
    required this.genre,
    required this.uid
  });

  final String title;
  final Widget item;
  final String genre;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: const  AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 0, 15),
            child: TextButton(//--------------------------------------------------텍스트 버튼
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FairyTaleList(title: title, genre: genre, uid: uid ))
                );
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
            ),
          )        
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 16),
          child: item,
        )
        
      ],
    );
  }
}