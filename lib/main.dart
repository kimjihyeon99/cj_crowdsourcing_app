import 'package:cj_crowdsourcing_app/startpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'startpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crowd Sourcing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(
              flex: 10,
            ),
            // logo
            Image.network(
              "https://mblogthumb-phinf.pstatic.net/MjAyMDA5MjdfMjky/MDAxNjAxMjEwNzA4MzU2.fsdz9sAALwhaR1ot0emkfk5SxkthtfFhiQVfaUCVVewg.ndi0Hk1FqHllVImNaXvmNH7NmWvKZV0lVd9H4vc9M8gg.PNG.xuni1021/SE-777d059f-62e3-4d55-9906-529c3c556c80.png?type=w800",
              width: 200,
              height: 100,
            ),
            Spacer(
              flex: 7,
            ),
            // id
            SizedBox(
              width: 300,
              child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디',
                  )),
            ),
            Spacer(
              flex: 1,
            ),
            // password
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호',
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            // register, login button
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelfCertificationPage()));
                    },
                    child: Text("회원가입"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Startpage()));
                    },
                    child: Text('로그인'),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}
