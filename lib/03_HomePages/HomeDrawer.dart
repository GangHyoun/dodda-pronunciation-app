import 'package:ddd_02/01_LoginPages/Login.dart';
import 'package:ddd_02/08_Setting/Setting.dart';
import 'package:ddd_02/09_LearningHistory/LearningHistory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFFDF4),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 237,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Text('홈'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('설정'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting(uid: uid,))
                    );
                  },
                ),
                ListTile(
                  title: Text('나의 학습 내역'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LearningHistory(uid: uid,))
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('로그아웃'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              // 로그아웃 후 로그인 페이지로 이동
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => LoginPage())
              );
            },
          ),
        ],
      ),
    );
  }
}
