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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/face.jpg'),
                  radius: 40,
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text("이름", style: TextStyle(fontWeight: FontWeight.bold),), Text("아이디", style: TextStyle(fontWeight: FontWeight.bold),)],
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("이름"), Text("아이디")],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "정보확인",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(
                "정산내역",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(
                "로그아웃",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
