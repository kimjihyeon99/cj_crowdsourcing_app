import 'deliverlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Startpage extends StatefulWidget {
  Startpage({Key? key}) : super(key: key);

  @override
  _StartpageState createState() => _StartpageState();
}

class FirstWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('지도'),
        ),
        body: Column());
  }
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
        body: TabBarView(children: [
          //순서대로 화면 만들기
          Icon(Icons.call),
          Diliverlist(), //배송 목록 화면
        ]),
      ),
    );
  }
}

class ThirdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('더보기'),
        ),
        body: Column());
  }
}

class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.map), label: '지도',),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet), label:"업무목록"),
      BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.ellipsis), label:"더보기")
    ];

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: items,
          currentIndex: 1,//첫번째 페이지를 업무목록 위젯으로 설정함
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return FirstWidget();
            case 1:
              return SecondWidget();
            case 2:
              return ThirdWidget();
            default:
              return FirstWidget();
          }
        });
  }
}
