import 'package:cj_crowdsourcing_app/model/diliver.dart';
import 'package:cj_crowdsourcing_app/worklist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'mypage.dart';
import 'secondPage.dart';

class Startpage extends StatefulWidget {
  String id;
  int page;
  List<Diliver> items;
  List<Diliver> titems;
  int state;
  int wstate;

  Startpage(
      {Key? key,
      required this.id,
      required this.page,
      required this.items,
      required this.titems,
      required this.state,
      required this.wstate})
      : super(key: key);

  @override
  _StartpageState createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.map),
        label: '지도',
      ),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet), label: "업무목록"),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled), label: "마이페이지")
    ];

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: items,
          currentIndex: 1, //첫번째 페이지를 업무목록 위젯으로 설정함
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return MapPage();
            case 1:
              return SecondWidget(
                  id: widget.id,
                  page: widget.page,
                  items: widget.items,
                  titems: widget.titems,
                  state: widget.state,
                  wstate: widget.wstate);
            case 2:
              return MyPage(id: widget.id);
            default:
              return SecondWidget(
                  id: widget.id,
                  page: widget.page,
                  items: widget.items,
                  titems: widget.titems,
                  state: widget.state,
                  wstate: widget.wstate);
          }
        });
  }
}
