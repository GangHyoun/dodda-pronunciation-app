import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../05_FairyTaleHome/FairyTaleAppbar.dart';

class LearningHistory extends StatefulWidget {
  const LearningHistory({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<LearningHistory> createState() => _LearningHistoryState();
}

class _LearningHistoryState extends State<LearningHistory> {
  late Future<List<Map<String, String>>> _bookData;

  @override
  void initState() {
    super.initState();
    _bookData = _fetchBookData();
  }

  Future<List<Map<String, String>>> _fetchBookData() async {
    List<Map<String, String>> bookData = [];
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('Book')
          .get();
      
      for (var doc in snapshot.docs) {
        // Assuming ForeignFable or KoreanFable is the document ID
        var foreignFableSnapshot = await FirebaseFirestore.instance
            .collection('Book')
            .doc('ForeignFable')
            .collection('fable')
            .doc(doc.id)
            .get();
        
        var koreanFableSnapshot = await FirebaseFirestore.instance
            .collection('Book')
            .doc('KoreanFable')
            .collection('fable')
            .doc(doc.id)
            .get();

        if (foreignFableSnapshot.exists) {
          var data = foreignFableSnapshot.data()!;
          var coverImg = data['coverImg'] as String;
          var bookTitle = foreignFableSnapshot.id;
          bookData.add({
            'title': bookTitle,
            'coverImg': coverImg,
          });
        } else if (koreanFableSnapshot.exists) {
          var data = koreanFableSnapshot.data()!;
          var coverImg = data['coverImg'] as String;
          var bookTitle = koreanFableSnapshot.id;
          bookData.add({
            'title': bookTitle,
            'coverImg': coverImg,
          });
        }
      }
    } catch (e) {
      print("Error fetching book data: $e");
    }
    return bookData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: FairyTaleAppbar(appbarTitle: '나의 학습 도서', color: Color(0xFFFF6B74),)
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _bookData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No books found.'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var book = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Image.network(
                      book['coverImg']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      book['title']!,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
