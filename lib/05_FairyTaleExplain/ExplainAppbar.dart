import 'package:flutter/material.dart';

class ExplainAppbar extends StatelessWidget {
  const ExplainAppbar({
    super.key,
    required this.icon
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      //borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      elevation: 2, 
      // Match the elevation of AppBar for consistent shadow
      child: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color(0xFFFF9C4D),
        iconTheme: const IconThemeData(
          color: Colors.white,//색변경
        ),
        flexibleSpace: FlexibleSpaceBar(
          background: ClipRRect(
            borderRadius: BorderRadius.circular(8), // This is for image inside
            child: Image.network(
              icon,
              fit: BoxFit.contain,
            ),
          ),
        ),
        centerTitle: false,
      ),
    );
  }
}
