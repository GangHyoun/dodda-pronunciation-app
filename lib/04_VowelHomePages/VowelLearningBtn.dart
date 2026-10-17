import 'package:ddd_02/04_VowelListPages/VowelList.dart';
import 'package:flutter/material.dart';

class VowelLearningBtn extends StatelessWidget {
  const VowelLearningBtn({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 16, 30),
      child: ButtonTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minWidth: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: (){//---------------------------------------------------이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VowelList(uid: uid))
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color(0xFF528DD7),
            minimumSize: const Size(double.infinity, 55)
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '학습하러 가기',              
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),        
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          ),
          
          
        )
      )
    );
    
  }
}