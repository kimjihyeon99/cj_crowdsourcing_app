import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Startpage extends StatefulWidget {
  Startpage({Key? key}) : super(key: key);
  @override
  _StartpageState createState() => _StartpageState();
}
class FirstWidget extends StatelessWidget {
  // index가 0인 페이지 먼저 보여줌
  final PageController pageController = PageController( initialPage: 1, );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('지도'),
        ),
        body:Column(

        )
    );
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

class ThirdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('더보기'),
      ),
      body:Column(
        
      )
    );
  }
}


class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.map), title: Text("지도")),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet), title: Text("업무목록")),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.ellipsis), title: Text("더보기"))
    ];

    return
      CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: items),
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
        }
    );
  }


}