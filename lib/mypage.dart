import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Image(
                image: AssetImage('assets/face.jpg'),
                height: 50,
                width: 50,
              ),
              Column(
                children: [
                  Text("이름"),
                  Text("아이디")
                ],
              )
            ],
          ),
          Divider( thickness: 3, color: Colors.grey, ),
          Text("정보확인", style: TextStyle(fontWeight: FontWeight.bold),),
          Text("정산내역"),
          Text("로그아웃", style: TextStyle(color: Colors.blue),)
        ],
      ),
    );
  }


}