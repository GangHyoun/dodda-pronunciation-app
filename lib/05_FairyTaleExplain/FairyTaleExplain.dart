import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ddd_02/05_FairyTaleExplain/ExplainAppbar.dart';
import 'package:ddd_02/05_FairyTaleExplain/ExplainBottombar.dart';
import 'package:ddd_02/05_FairyTaleExplain/ExplainItem.dart';
import 'package:flutter/material.dart';

class FairyTaleExplain extends StatefulWidget {
  const FairyTaleExplain({
    super.key,
    required this.booktitle,
    required this.genre,
    required this.uid,
  });

  final String genre;
  final String booktitle;
  final String uid;

  @override
  State<FairyTaleExplain> createState() => _FairyTaleExplainState();
}

class _FairyTaleExplainState extends State<FairyTaleExplain> {
  Future<Map<String, dynamic>> _fetchFableData() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('Book').doc('ForeignFable')
      .collection('fable').doc(widget.booktitle).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;
      return {
        'explain': data['explain'], 
        'genreLabel': '세계명작',
        'coverImg': data['coverImg'], // Add this line
      };
    } else {
      docSnapshot = await FirebaseFirestore.instance
        .collection('Book').doc('KoreanFable')
        .collection('fable').doc(widget.booktitle).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()! as Map<String, dynamic>;
        return {
          'explain': data['explain'], 
          'genreLabel': '전래고전',
          'coverImg': data['coverImg'], // Add this line
        };
      }
    }

    return {}; // Return empty if no data found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(360),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchFableData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error fetching data");
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ExplainAppbar(icon: snapshot.data!['coverImg']);
            }
            return Text("No data found");
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchFableData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching data"));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 5, 16, 0),
              child: Column(
                children: [
                  ExplainItem(title: widget.booktitle, type: snapshot.data!['genreLabel'], input: snapshot.data!['explain']),
                ],
              ),
            );
          }
          return Center(child: Text("No data found"));
        },
      ),
      bottomNavigationBar: ExplainBottombar(booktitle: widget.booktitle, genre: widget.genre, uid: widget.uid),
    );
  }
}
