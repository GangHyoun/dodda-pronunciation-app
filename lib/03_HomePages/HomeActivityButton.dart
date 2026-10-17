import 'package:flutter/material.dart';

class HomeActivityButton extends StatelessWidget {
  const HomeActivityButton({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.route,
    required this.uid
  });

  final String title;
  final Color color;
  final String icon;
  final Widget Function(String uid) route;
  final String uid;

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
              onPressed: (){//-------------------------------------onPressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => route(uid)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                minimumSize: const Size(double.infinity, 75)
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: const Color(0xFFFFFDF4),
                  fontSize: 30,
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
              child: Image.asset(            
                icon,
                width: 70,
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
          )
        ),
      ],
    );
  }
}