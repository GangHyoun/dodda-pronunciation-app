import 'package:flutter/material.dart';

class ResearchBar extends StatefulWidget {
  const ResearchBar({
    super.key,
    required this.uid,
    required this.query,
    required this.onSearch,
  });

  final String uid;
  final String query;
  final Function(String) onSearch;

  @override
  _ResearchBarState createState() => _ResearchBarState();
}

class _ResearchBarState extends State<ResearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // TextEditingController를 초기화할 때 widget.query로 초기값을 설정합니다.
    _controller = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(covariant ResearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // widget.query가 변경될 때 TextEditingController를 업데이트합니다.
    if (oldWidget.query != widget.query) {
      _controller.text = widget.query;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: TextField(
        controller: _controller, // TextField에 컨트롤러 할당
        decoration: InputDecoration(
          hintText: '찾으시는 도서를 검색해보세요.',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFF528DD7), // 검색 아이콘 색상
            ),
            onPressed: () {
              // 검색 아이콘을 클릭하면 실행될 기능
              widget.onSearch(_controller.text);
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Color(0xFFFFFDF4), width: 3),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
