import 'package:carousel_slider/carousel_slider.dart';
import 'package:ddd_02/05_FairyTaleExplain/FairyTaleExplain.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class HomeActivityCarousel extends StatefulWidget {
  const HomeActivityCarousel({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  State<HomeActivityCarousel> createState() => _HomeActivityCarouselState();
}

class _HomeActivityCarouselState extends State<HomeActivityCarousel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, String>> texts = [];
  final List<Color> colors = [
    Color(0xFF528DD7),
    Color(0xFFFFD664),
    Color(0xFFFF6B74),
    Color(0xFF00BFBA),
    Color(0xFFBCA5D4)
  ];
  int _current = 0;  // Current index of the carousel

  @override
  void initState() {
    super.initState();
    fetchRandomDocuments();
  }

  void fetchRandomDocuments() async {
    try {
      var foreignFable = await _firestore.collection('Book').doc('ForeignFable').collection('fable').get();
      var koreanFable = await _firestore.collection('Book').doc('KoreanFable').collection('fable').get();
      
      List<Map<String, String>> allDocuments = [
        ...foreignFable.docs.map((doc) => {'id': doc.id, 'genre': 'ForeignFable'}),
        ...koreanFable.docs.map((doc) => {'id': doc.id, 'genre': 'KoreanFable'})
      ];

      // Randomly pick 5 documents
      Random random = Random();
      while (texts.length < 5) {
        int randomIndex = random.nextInt(allDocuments.length);
        Map<String, String> randomText = allDocuments[randomIndex];
        if (!texts.contains(randomText)) {
          texts.add(randomText);
          allDocuments.removeAt(randomIndex);  // Avoid duplicates in display
        }
      }

      setState(() {});
    } catch (e) {
      debugPrint('Error fetching documents: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
          items: texts.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, String> text = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FairyTaleExplain(booktitle: text['id']!, genre: text['genre']!, uid: widget.uid),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: colors[idx % colors.length],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(text['id']!, style: TextStyle(fontSize: 25.0, color: Colors.white)),
                        SizedBox(width: 10),
                        Image.asset(
                          'assets/images/06.png',
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: screenSize.height / 5,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: texts.asMap().entries.map((entry) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == entry.key ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
