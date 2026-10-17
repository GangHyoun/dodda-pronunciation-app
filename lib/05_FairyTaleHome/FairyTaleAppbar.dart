import 'package:flutter/material.dart';

class FairyTaleAppbar extends StatelessWidget {
  const FairyTaleAppbar({
    super.key,
    required this.appbarTitle,
    required this.color
  });
  final String appbarTitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,//색변경
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), 
        ),
      ),
      title: Text(
        appbarTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24
        ),
      ),
    );
  }
}