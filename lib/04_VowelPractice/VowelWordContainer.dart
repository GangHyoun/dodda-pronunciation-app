import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ddd_02/04_VowelPractice/VowelWordText.dart';

class VowelWordContainer extends StatelessWidget {
  const VowelWordContainer({
    Key? key,
    required this.word,
    required this.vowel,
  }) : super(key: key);

  final String word;
  final String vowel;

  void fetchVideoIdAndShowDialog(BuildContext context) async {
    String videoId = await FirebaseFirestore.instance
      .collection('DiphthongWord')
      .doc(vowel)
      .collection('word')
      .doc(word)
      .get()
      .then((doc) {
        if (doc.exists && doc.data()!.containsKey('wordVid')) {
          return doc.data()!['wordVid'] as String;
        } else {
          throw Exception('Video ID not found');
        }
      });

    showVideoDialog(context, videoId);
  }

  void showVideoDialog(BuildContext context, String videoId) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        loop: true
      ),
    );

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  _controller.addListener(() {});
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _controller.dispose();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 280,
      decoration: BoxDecoration(
        color: Color(0xFFFFF7E2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 0,
            blurRadius: 2.0,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 30, 0, 0),
            child: VowelWordText(word: word),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => fetchVideoIdAndShowDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD664),
                  fixedSize: Size(screenSize.width / 2.18, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Color(0xFFFFFDF4)),
                    Text(
                      '발음 영상보기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // 발음 촬영 기능 구현 위치
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9C4D),
                  fixedSize: Size(screenSize.width / 2.18, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.camera, color: Color(0xFFFFFDF4)),
                    Text(
                      '발음 촬영하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
