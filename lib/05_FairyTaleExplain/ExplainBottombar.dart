import 'package:flutter/material.dart';
import 'package:ddd_02/05_FairyTalePractice/FairyTalePractice.dart';

class ExplainBottombar extends StatelessWidget {
  final String booktitle;
  final String genre;
  final String uid;

  ExplainBottombar({
    required this.booktitle,
    required this.genre,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FairyTalePractice(booktitle: booktitle, genre: genre, uid: uid)),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(double.infinity, 100), // Bottom bar height
            painter: ParabolicPainter(),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
            child:Text(
              '도서 읽기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          
        ],
      ),
    );
  }
}


class ParabolicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF528DD7)
      ..style = PaintingStyle.fill;

    double startY = size.height * 0.5;

    Path path = Path();
    path.moveTo(0, startY);
    path.quadraticBezierTo(
      size.width * 0.5,
      0,
      size.width,
      startY,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
