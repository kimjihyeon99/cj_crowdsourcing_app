import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'mypage.dart';
import 'secondPage.dart';

class Startpage extends StatefulWidget {
  String id;

  Startpage({Key? key, required this.id}) : super(key: key);

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
              return SecondWidget();
            case 2:
              return MyPage(id: widget.id);
            default:
              return SecondWidget();
          }
        });
  }
}
