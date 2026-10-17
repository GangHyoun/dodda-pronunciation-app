import 'package:flutter/material.dart';

class VowelContainers extends StatelessWidget {
  const VowelContainers({
    super.key,
    required this.stHeight,
    required this.color,
    required this.title,
    required this.cHeight,
    required this.item
  });
  final double stHeight;
  final Color color;
  final String title;
  final double cHeight;
  final Widget item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Container(
        height: stHeight,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(-1, -1),
              child: Container(
                width: 160,
                height: 65,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                alignment: const AlignmentDirectional(-1, -1),
                child: Padding(
                  padding:  const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: Container(
                width: double.infinity,
                height: cHeight,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDF4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: color,
                  ),
                ),
                alignment: AlignmentDirectional(0, 0),
                child: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}