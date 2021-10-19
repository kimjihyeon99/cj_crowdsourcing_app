import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'mypage.dart';

class Startpage extends StatefulWidget {
  Startpage({Key? key}) : super(key: key);
  @override
  _StartpageState createState() => _StartpageState();
}

class SecondWidget extends StatelessWidget {
  final choices = ['업무 목록', '배송 목록'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: choices.map((String choice) {
              return Tab(text: choice);
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: [
            //순서대로 화면 만들기
            Icon(Icons.call),
            Icon(Icons.account_box),
          ]
        ),
      ),
    );
  }
}

class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), title: Text("지도")),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet), title: Text("업무목록")),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text("마이페이지"))
    ];

    return
      CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return MapPage();
            case 1:
              return SecondWidget();
            case 2:
              return MyPage();
            default:
              return SecondWidget();
          }
        }
    );
  }


}