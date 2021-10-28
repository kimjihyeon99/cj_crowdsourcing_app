import 'package:cj_crowdsourcing_app/startpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'startpage.dart';
import 'model/info.dart';
import 'package:cj_crowdsourcing_app/db/dbHelper.dart';

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
  DBHelper dbHelper = DBHelper();

  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

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
                ),
                controller: idController,
              ),
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
                controller: pwController,
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
                      dbHelper.insertInfo(Info(id: '57', pw: 'mini'));
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Startpage(id : "123"))
                      // );
                      dbHelper
                          .getAllInfo()
                          .then((value) => value.forEach((element) {
                                if (element.id == idController.text &&
                                    element.pw == pwController.text) {
                                  //메인화면으로 전환
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Startpage(
                                              id: element.id,
                                              page: 0,
                                              items: [],
                                              titems: [],
                                              state: 0,
                                              wstate: 0,
                                              isqr: "qr scan")));
                                }
                              }));
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
