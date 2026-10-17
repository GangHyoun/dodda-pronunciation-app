import 'package:flutter/material.dart';

class ReviewBottomBar extends StatefulWidget {
  final String booktitle;
  final String genre;
  final int currentPage; // 현재 페이지 번호
  final int totalSentences; // 전체 문장 수
  final Function(bool) onSentenceChanged; // 문장 변경을 위한 콜백 함수 추가

  const ReviewBottomBar({
    super.key,
    required this.booktitle,
    required this.genre,
    required this.onSentenceChanged,
    required this.currentPage,
    required this.totalSentences,
  });

  @override
  State<ReviewBottomBar> createState() => _ReviewBottomBarState();
}

class _ReviewBottomBarState extends State<ReviewBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: const Color(0xFF00BFBA),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => widget.onSentenceChanged(false), // 이전 문장으로 이동
            icon: const Icon(Icons.navigate_before),
            color: const Color(0xFFFFFDF4),
          ),
          Text( // 현재 페이지와 전체 페이지를 표시
            '${widget.currentPage} / ${widget.totalSentences}',
            style: TextStyle(
              color: Color(0xFFFFFDF4),
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: () => widget.onSentenceChanged(true), // 다음 문장으로 이동
            icon: const Icon(Icons.navigate_next),
            color: const Color(0xFFFFFDF4),
          ),
        ],
      ),
    );
  }
}

