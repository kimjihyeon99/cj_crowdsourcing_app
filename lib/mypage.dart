import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class MyPage extends StatefulWidget {
  String id;
  MyPage({Key? key, required this.id}) : super(key: key);

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
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "아이디",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.id)],
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
              height: 300,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
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
