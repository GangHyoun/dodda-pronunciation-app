import 'package:flutter/material.dart';

import 'HomeActivityList.dart';
import 'HomeAppBar.dart';
import 'HomeDrawer.dart';
import 'HomeTitle.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userName,
    required this.uid
  });
  final String userName;
  final String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child:  Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40), // 앱바 높이 알아서 바꾸셈
          child: HomeAppBar(),
        ),
        drawer: HomeDrawer(uid: widget.uid,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeTitle(name: widget.userName),
              HomeActivityList(uid: widget.uid,),
              
            ],
          ),
        )       
      )
    );
    
  }
}

