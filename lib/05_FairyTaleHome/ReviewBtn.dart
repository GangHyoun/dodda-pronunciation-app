import 'package:ddd_02/06_ReviewHome/ReviewHome.dart';
import 'package:flutter/material.dart';

class ReviewBtn extends StatelessWidget {
  const ReviewBtn({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReviewHome(uid: uid,))
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFF7E2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.zero,
        fixedSize: Size(double.infinity, 120)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/05.png',
              width: 90,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '다 읽어본 책도 다시 한 번!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16
                ),
              ),
              Text(
                '틀린 문장 다시 읽기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}