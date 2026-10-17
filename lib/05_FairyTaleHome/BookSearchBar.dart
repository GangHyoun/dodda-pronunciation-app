import 'package:ddd_02/07_Search/Search.dart';
import 'package:flutter/material.dart';

class BookSearchBar extends StatelessWidget {
  const BookSearchBar({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  Widget build(BuildContext context) {

    // TextEditingController를 생성하여 텍스트 필드의 현재 값을 추적합니다.
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: TextField(
        controller: _controller, // TextField에 컨트롤러 할당
        decoration: InputDecoration(
          hintText: '찾으시는 도서를 검색해보세요.',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFFFF6B74),
            ),
            onPressed: () {
              // 검색 아이콘을 클릭하면 실행될 기능
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search(query: _controller.text, uid: uid,)),
              );
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