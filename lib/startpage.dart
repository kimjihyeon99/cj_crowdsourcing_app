import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'worklist.dart';
import 'deliverlist.dart';
import 'map.dart';
import 'mypage.dart';


class Startpage extends StatefulWidget {
  String id;
  Startpage({Key? key, required this.id}) : super(key: key);

  @override
  _StartpageState createState() => _StartpageState(id: id);
}


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
        body: TabBarView(
            children: [
              //업무 신청, 진행중 업무, 종료된 업무
              Worklist(),
              Diliverlist(), //배송 목록 화면
            ]
        ),
      ),
    );
  }

}

class _StartpageState extends State<Startpage> {
  String id;

  _StartpageState({required this.id});

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.map), label: '지도',),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet), label:"업무목록"),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled), label:"마이페이지")
    ];

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: items,
          currentIndex: 1,//첫번째 페이지를 업무목록 위젯으로 설정함
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return MapPage();
            case 1:
              return SecondWidget();
            case 2:
              return MyPage(id: id);
            default:
              return SecondWidget();

          }
        });
  }
}
