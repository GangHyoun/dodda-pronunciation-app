import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTaleHome/BookBtn.dart';
import 'package:flutter/material.dart';
import 'ReviewBookBtn.dart';

class ReviewDataGridView extends StatelessWidget {
  const ReviewDataGridView({
    super.key,
    required this.uid,
  });

  final String uid;

  Future<Map<String, dynamic>> fetchCoverImg(String bookId) async {
    DocumentSnapshot foreignFableDoc = await FirebaseFirestore.instance
        .collection('Book')
        .doc('ForeignFable')
        .collection('fable')
        .doc(bookId)
        .get();

    if (foreignFableDoc.exists && foreignFableDoc.data() != null) {
      return foreignFableDoc.data() as Map<String, dynamic>;
    } else {
      DocumentSnapshot koreanFableDoc = await FirebaseFirestore.instance
          .collection('Book')
          .doc('KoreanFable')
          .collection('fable')
          .doc(bookId)
          .get();

      if (koreanFableDoc.exists && koreanFableDoc.data() != null) {
        return koreanFableDoc.data() as Map<String, dynamic>;
      }
    }

    return {};
  }

  Future<List<Map<String, dynamic>>> fetchReviewBooks() async {
    List<Map<String, dynamic>> bookList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('Book')
        .get();

    for (var doc in querySnapshot.docs) {
      // Check if the learned collection is not empty
      QuerySnapshot learnedSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Book')
          .doc(doc.id)
          .collection('learned')
          .get();

      if (learnedSnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> coverData = await fetchCoverImg(doc.id);
        bookList.add({
          'id': doc.id,
          'coverImg': coverData['coverImg'] ?? 'assets/images/default.png', // default image if coverImg is not available
          'genre': data['genre'] ?? 'Unknown', // default genre if not available
        });
      }
    }
    return bookList;
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [
      Color(0xFF528DD7),
      Color(0xFFFFD664),
      Color(0xFFFF6B74),
      Color(0xFF00BFBA),
      Color(0xFFBCA5D4)
    ];
    Size screenSize = MediaQuery.of(context).size;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchReviewBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No books found'));
        } else {
          List<Map<String, dynamic>> books = snapshot.data!;
          return Container(
            width: double.infinity,
            height: screenSize.height,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final color = colors[index % colors.length];
                return ReviewBookBtn(
                  color: color,
                  icon: book['coverImg'],
                  booktitle: book['id'],
                  genre: book['genre'],
                  uid: uid,
                );
              },
            ),
          );
        }
      },
    );
  }
}
