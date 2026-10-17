import 'package:ddd_02/04_VowelPractice/VowelPractice.dart';
import 'package:flutter/material.dart';

class VowelListBtn extends StatelessWidget {
  const VowelListBtn({
    super.key,
    required this.color,
    required this.vowel,
    required this.uid
  });

  final Color color;
  final String vowel;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
        child: ElevatedButton(
        onPressed: (){//-------------------------------------onPressed
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => VowelPractice(vowel:vowel, uid: uid))
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
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0,
                      blurRadius: 2.0,
                      offset: Offset(-5, 0),
                    )
                  ]
                ),     
              ),
            ),
            Align(
              alignment:  AlignmentDirectional(-1, 0),
              child:Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(      
                    color: Color(0xFFFFFDF4),
                    shape: BoxShape.circle,
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    vowel,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 70, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ),
          ],
        ),
      )
    ); 
  }
}