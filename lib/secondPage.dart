import 'package:cj_crowdsourcing_app/model/diliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'worklist.dart';
import 'deliverlist.dart';

class SecondWidget extends StatefulWidget {
  String id;
  int page;
  List<Diliver> items;
  List<Diliver> titems;
  int state;
  int wstate;

  SecondWidget(
      {Key? key,
      required this.id,
      required this.page,
      required this.items,
      required this.titems,
      required this.state,
      required this.wstate})
      : super(key: key);

  @override
  _SecondWidget createState() => _SecondWidget();
}

//업무목록 및 배송목록
class _SecondWidget extends State<SecondWidget> {
  final choices = ['업무 목록', '배송 목록'];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.page == 1) {
      index = widget.page;
    }
    // TODO: implement build
    return DefaultTabController(
      initialIndex: index,
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
          Worklist(
              id: widget.id,
              titems: widget.titems,
              items: widget.items,
              state: widget.state,
              wstate: widget.wstate),
          Diliverlist(
            items: widget.items,
          ), //배송 목록 화면
        ]),
      ),
    );
  }
}
