import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTaleHome/BookBtn.dart';
import 'package:flutter/material.dart';

class SearchDataGridView extends StatelessWidget {
  const SearchDataGridView({super.key, required this.uid, required this.query});

  final String uid;
  final String query;

  @override
  Widget build(BuildContext context) {
    // 버튼 색상 리스트
    final List<Color> colors = [
      Color(0xFF528DD7),
      Color(0xFFFFD664),
      Color(0xFFFF6B74),
      Color(0xFF00BFBA),
      Color(0xFFBCA5D4)
    ];
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: searchDocuments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No results found'));
          }

          final searchResults = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              var data = searchResults[index];
              return BookBtn(
                color: colors[index % colors.length], // 색상 리스트에서 순환하여 사용
                icon: data['data']['coverImg'] ?? '', // 아이콘 경로
                booktitle: data['title'] ?? 'Unknown Title', // 문서 이름을 제목으로 사용
                genre: data['genre'] ?? 'Unknown Genre', // 상위 문서의 ID를 genre로 사용
                uid: uid,
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> searchDocuments() async {
    // 상위 컬렉션 Book의 모든 문서 가져오기
    QuerySnapshot bookSnapshot =
        await FirebaseFirestore.instance.collection('Book').get();
    List<Map<String, dynamic>> results = [];

    // 각 문서의 하위 컬렉션 Details 검색
    for (var bookDoc in bookSnapshot.docs) {
      var bookId = bookDoc.id; // 상위 문서의 ID

      QuerySnapshot detailsSnapshot =
          await bookDoc.reference.collection('fable').get();
      for (var detailsDoc in detailsSnapshot.docs) {
        var data = detailsDoc.data() as Map<String, dynamic>;
        if (detailsDoc.id.contains(query) ||
            data.values.any(
                (value) => containsWholeWord(value?.toString() ?? '', query))) {
          results.add({
            'title': detailsDoc.id,
            'data': data,
            'genre': bookId, // 상위 문서의 ID를 genre로 사용
          });
        }
      }
    }
    return results;
  }

  // 문자열에 특정 단어가 전체 단어로 포함되어 있는지 확인하는 함수
  bool containsWholeWord(String text, String word) {
    final pattern = RegExp(r'\b' + RegExp.escape(word) + r'\b');
    return pattern.hasMatch(text);
  }
}
