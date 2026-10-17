import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTaleHome/BookBtn.dart';
import 'package:flutter/material.dart';

class BookListView extends StatelessWidget {
  const BookListView({
    super.key,
    required this.genre,
    required this.uid
  });
  final String genre;
  final String uid;

  @override
  Widget build(BuildContext context) {
    // 문서의 ID와 coverImg URL을 가져오는 함수
    Future<List<Map<String, dynamic>>> fetchBooks() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference genreDoc = firestore.collection('Book').doc(genre);
      CollectionReference fables = genreDoc.collection('fable');
      QuerySnapshot querySnapshot = await fables.get();

      // 각 문서의 ID와 coverImg URL을 리스트로 반환
      return querySnapshot.docs.map((doc) => {
        'id': doc.id,
        'coverImg': doc['coverImg'],  // coverImg 필드 값을 가져옵니다
      }).toList();
    }

    final List<Color> colors = [
      Color(0xFF528DD7),
      Color(0xFFFFD664),
      Color(0xFFFF6B74),
      Color(0xFF00BFBA),
      Color(0xFFBCA5D4)
    ];

    return Container(
      width: double.infinity,
      height: 150,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return BookBtn(
                  color: colors[index % colors.length],
                  booktitle: book['id'],  // 문서 ID를 제목으로 사용
                  icon: book['coverImg'],  // 각 책의 coverImg URL을 아이콘으로 사용
                  genre: genre,
                  uid: uid,
                );
              },
            );
          } else {
            return Text('No data found');
          }
        },
      ),
    );
  }
}
