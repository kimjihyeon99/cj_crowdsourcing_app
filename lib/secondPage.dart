import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'worklist.dart';
import 'deliverlist.dart';

class SecondWidget extends StatefulWidget {
  SecondWidget({Key? key}) : super(key: key);

  @override
  _SecondWidget createState() => _SecondWidget();
}

//업무목록 및 배송목록
class _SecondWidget extends State<SecondWidget> {
  final choices = ['업무 목록', '배송 목록'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          //뒤로가기 없애기
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: choices.map((String choice) {
              return Tab(text: choice);
            }).toList(),
          ),
        ),
        body: TabBarView(children: [
          //업무 신청, 진행중 업무, 종료된 업무
          Worklist(),
          Diliverlist(), //배송 목록 화면
        ]),
      ),
    );
  }
}
