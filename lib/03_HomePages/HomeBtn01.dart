import 'package:flutter/material.dart';

class HomeBtn01 extends StatelessWidget {
  const HomeBtn01({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: const AlignmentDirectional(0, 1),
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
          child: ButtonTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minWidth: double.infinity,
            height: 75,
            child: ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B74),
                minimumSize: const Size(double.infinity, 75)
              ),
              child: const Text(
                '도서 읽기',
                style: TextStyle(
                  color: Color(0xFFFFFDF4),
                  fontSize: 18,
                )
              ),
            ),
          ),          
        ),
        Align(
          alignment: const Alignment(-1, 1),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(13, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(            
                'https://picsum.photos/seed/412/600',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          )
        ),
      ],
    );
  }
}