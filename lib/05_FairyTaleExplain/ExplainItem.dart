import 'package:flutter/material.dart';

class ExplainItem extends StatelessWidget {
  const ExplainItem({
    super.key,
    required this.title,//도서 제목
    required this.type,//도서 장르
    required this.input// 도서 설명
  });

  final String title;
  final String type;
  final String input;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(//------------------------------도서 제목
          alignment: const  AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 40, 0, 5),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 34
              ),
            ),
          )        
        ),
        Align(//--------------------------도서 장르
          alignment: const  AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 15),
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 20
              ),
            ),
          )        
        ),
        Text(//----------------------도서 설명란
          input,
          style: const TextStyle(
            fontSize: 25
          ),
        )
        
        
      ],
    );
  }
}