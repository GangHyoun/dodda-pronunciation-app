import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.item
  });

  final String title;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: const  AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 40, 0, 15),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20
              ),
            ),
          )        
        ),
        
        item
      ],
    );
  }
}