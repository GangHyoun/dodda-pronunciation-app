import 'package:flutter/material.dart';

class VowelAppBar extends StatelessWidget {
  const VowelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF00BFBA),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,//색변경
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20), 
        ),
      ),
      title: const Text(
        '이중 모음',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24
        ),
      ),
    );
  }
}