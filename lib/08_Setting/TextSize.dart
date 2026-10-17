import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextSize extends StatefulWidget {
  const TextSize({super.key, required this.uid, required this.onSave});
  final String uid;
  final void Function(String?) onSave;



  @override
  _TextSizeState createState() => _TextSizeState();
}

class _TextSizeState extends State<TextSize> {
  String? selectedSize; // 초기값 설정을 제거
  bool isLoading = true;  // 로딩 상태 추가

  @override
  void initState() {
    super.initState();
    loadUserFontSize();
  }

Future<void> loadUserFontSize() async {
  setState(() {
    isLoading = true;  // 로딩 상태 시작
  });

  try {
    // Firestore에서 사용자 설정 문서에 접근
    DocumentSnapshot settingsDocument = await FirebaseFirestore.instance
        .collection('users')               // 'users' 컬렉션
        .doc(widget.uid)                   // 사용자의 uid 문서
        .collection('Setting')             // 'Setting' 서브컬렉션
        .doc('Settings')                   // 'Settings' 문서
        .get();

    // 데이터를 Map<String, dynamic>으로 캐스팅
    Map<String, dynamic> settingsData = settingsDocument.data() as Map<String, dynamic>;

    // 'fontsize' 필드 값 읽기
    var fontSize = settingsData['fontsize'].toString();

    if (fontSize != null) {
      setState(() {
        selectedSize = fontSize;  // 폰트 크기 설정
        isLoading = false;        // 데이터 로딩 완료
      });
    } else {
      // fontsize 필드가 없는 경우
      setState(() {
        isLoading = false;
      });
      print("Error: 'fontsize' field is not found.");
    }
  } catch (e) {
    // 오류 처리
    print("Error loading settings: $e");
    setState(() {
      isLoading = false;  // 예외 발생 시 로딩 상태 해제
    });
  }
}


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {'value': '36', 'text': '가나다 (36px)', 'size': 36.0},
      {'value': '24', 'text': '가나다 (24px)', 'size': 24.0},
      {'value': '18', 'text': '가나다 (18px)', 'size': 18.0},
      {'value': '14', 'text': '가나다 (14px)', 'size': 14.0},
    ];

    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
          selectedSize = value;
        });
        widget.onSave(selectedSize);
      },
      itemBuilder: (BuildContext context) => items.map((item) {
        return PopupMenuItem<String>(
          value: item['value'],
          child: Text(item['text'], style: TextStyle(fontSize: item['size'])),
        );
      }).toList(),
      child: ListTile(
        title: Text(
          items.firstWhere((item) => item['value'] == selectedSize, orElse: () => items[0])['text'],
          style: TextStyle(fontSize: 16),
        ),
        trailing: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}
