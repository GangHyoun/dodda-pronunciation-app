import 'package:ddd_02/04_VowelHomePages/VowelHome.dart';
import 'package:ddd_02/05_FairyTaleHome/FairyTaleHome.dart';
import 'package:flutter/material.dart';

import 'HomeActivityCarousel.dart';
import 'HomeActivityItem.dart';
import 'HomeActivityButton.dart';

class HomeActivityList extends StatelessWidget {
  const HomeActivityList({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 710,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDF4),
        boxShadow: [
          BoxShadow(blurRadius: 4,
          color: Color(0x33000000),
          offset: Offset(0, -4)
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(12),
        ),
      ),
      child:  Column(   
        children: [
          HomeActivityItem(title: "학습 활동", item: Column(
            children: [
              HomeActivityButton(
                title: "도서 읽기",
                color: Color(0xFFFF6B74),
                icon: 'assets/images/03.png',
                route: (uid) => FairyTaleHome(uid: uid),
                uid: uid,
              ),
              SizedBox(
                height: 20,
              ),
              HomeActivityButton(
                title: "이중 모음",
                color: Color(0xFF86DCEC),
                icon: 'assets/images/04.png',
                route: (uid) => VowelHome(uid: uid),
                uid: uid,
              )
            ]
          )),
          HomeActivityItem(title: "추천 도서", item: HomeActivityCarousel(uid: uid,))
        ],
      )
    );
  }
}