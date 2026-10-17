import 'package:ddd_02/04_VowelPractice/VowelPractice.dart';
import 'package:flutter/material.dart';

class VowelDataGridBtn extends StatelessWidget {
  const VowelDataGridBtn({
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
    return ElevatedButton(
      onPressed: (){//-------------------------------------onPressed
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => VowelPractice(vowel: vowel, uid: uid,))
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0.5, 0),
      ),
      child: Text(
        vowel,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 36,
        ),
      )
    );
  }
}