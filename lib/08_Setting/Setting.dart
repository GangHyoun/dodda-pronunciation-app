import 'package:ddd_02/05_FairyTaleHome/FairyTaleAppbar.dart';
import 'package:ddd_02/08_Setting/SettingItem.dart';
import 'package:ddd_02/08_Setting/TextSize.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Setting extends StatefulWidget {
  const Setting({super.key, required this.uid});
  final String uid;

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String? currentFontSize;
  bool _isEdited = false;  // 사용자가 설정을 변경했는지 추적하는 플래그

  void showSaveConfirmation() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('저장하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('아니오'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);  // AlertDialog 닫기
            },
            child: Text('예'),
          ),
        ],
      ),
    );

    if (result == true) {
      saveFontSize();
    }
  }

  void saveFontSize() async {
    if (currentFontSize != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .collection('Setting')
          .doc('Settings')
          .update({'fontsize': int.parse(currentFontSize!)});
      setState(() {
        _isEdited = false;  // 저장 후 변경 플래그 초기화
      });
      Navigator.of(context).pop();  // 홈 화면으로 이동
    }
  }

  Future<bool> _onWillPop() async {
    if (_isEdited) {
      return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('변경사항이 저장되지 않았습니다. 나가시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('아니오'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);  // AlertDialog 닫기
                Navigator.of(context).pop();      // 홈 화면으로 이동
              },
              child: Text('예'),
            ),
          ],
        ),
      )) ?? false;  // showDialog가 null을 반환할 경우 false를 반환
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: FairyTaleAppbar(appbarTitle: '설정', color: Color(0xFF528DD7)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SettingItem(title: '글씨 크기', item: TextSize(
              uid: widget.uid,
              onSave: (size) {
                setState(() {
                  _isEdited = true;  // 사용자가 설정을 변경함
                  currentFontSize = size;
                });
              },
            ),),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 50, 50),
              child: ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minWidth: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: showSaveConfirmation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF528DD7),
                    minimumSize: const Size(300, 40)
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(
                      color: Color(0xFFFFFDF4),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
