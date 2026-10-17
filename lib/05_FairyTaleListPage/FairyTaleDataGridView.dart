import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTaleHome/BookBtn.dart';
import 'package:flutter/material.dart';

class FairyTaleDataGridView extends StatelessWidget {
  const FairyTaleDataGridView({
    super.key,
    required this.genre,
    required this.uid
  });
  final String genre;
  final String uid;

  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> fetchBooks() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference genreDoc = firestore.collection('Book').doc(genre);
      CollectionReference fables = genreDoc.collection('fable');
      QuerySnapshot querySnapshot = await fables.get();
      // Return a list of maps containing both the document ID and the cover image URL
      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'coverImg': doc['coverImg']  // Assume 'coverImg' is stored in each document
        };
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
      height: 520,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('오류: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return BookBtn(
                  color: colors[index % colors.length],
                  booktitle: book['id'], // You might want to adjust this if you store titles differently
                  icon: book['coverImg'], // Now using the image URL from Firestore
                  genre: genre,
                  uid: uid,
                );
              },
            );
          } else {
            return Center(child: Text('사용 가능한 데이터가 없습니다'));
          }
        },
      ),
    );
  }
}
