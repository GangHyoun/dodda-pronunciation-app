import 'package:ddd_02/05_FairyTaleExplain/FairyTaleExplain.dart';
import 'package:ddd_02/05_FairyTalePractice/FairyTalePractice.dart';
import 'package:flutter/material.dart';

import '../06_ReviewPage/ReviewPage.dart';

class ReviewBookBtn extends StatelessWidget {
  const ReviewBookBtn({
    super.key,
    required this.color,
    required this.icon, //파베에서 url 받아야해. coverImg 
    required this.booktitle,
    required this.genre,
    required this.uid

  });

  final Color color;
  final String icon;
  final String booktitle;
  final String genre;
  final String uid;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: ElevatedButton(
        onPressed: (){//-----------------------------------------------------페이지 이동할 때
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReviewPage(genre: genre, booktitle: booktitle, uid: uid,))
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
          fixedSize: Size(120, 130)
        ),
        child: 
        Column(
          children: [
            Container(
              width: 120,
              height: 60,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xFFFFF7E2)
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 5),
                child: Align(
                  alignment: AlignmentDirectional(1, 1),
                  child: ClipRRect(
                    child: Image.network(
                      icon,
                      width: 40,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 120,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                color: color
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                child: Text(
                  booktitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}