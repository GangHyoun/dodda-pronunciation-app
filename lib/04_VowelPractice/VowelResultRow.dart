import 'package:flutter/material.dart';
import 'package:ddd_02/STT/compareText.dart';

class VowelResultRow extends StatefulWidget {
  const VowelResultRow(
      {super.key,
      required this.result,
      required this.compareWord //사용자 발음, 읽을 단어
      });

  final String result; //       사용자 발음
  final String compareWord; //  사용자가 읽은 단어

  @override
  State<VowelResultRow> createState() => _VowelResultRowState();
}

class _VowelResultRowState extends State<VowelResultRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      //가로 배치
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          //이미지
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/05.png',
            width: 90,
            height: 80,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          //여백 맞추기용 상자
          width: 20,
        ),
        Container(
            //하늘색 컨테이너
            width: 200,
            height: 70,
            decoration: BoxDecoration(
                //컨테이너 꾸미기
                color: Color(0xFF86DCEC),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 0,
                    blurRadius: 2.0,
                    offset: Offset(0, 5),
                  )
                ]),
            //child = 하늘색 컨테이너 안에 들어갈 거
            child: Align(
              //정렬 , 배치
              alignment: AlignmentDirectional(0, 0),
              child: buildComparisonText(
                  widget.result, widget.compareWord), //발음 비교
            )),
      ],
    );
  }
}
