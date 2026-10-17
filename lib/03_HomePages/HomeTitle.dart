import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 185,
      decoration: const BoxDecoration(
        color:  Color(0xFFFFF7E2),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 30),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,     
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name + '!',
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                const Text(
                  '오늘 따라읽기 할 준비가 되었나요?',
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),         
              ],
            ),
            Image.asset(
              'assets/images/07.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            )
          ],
        )
      ),
    );

  }
}