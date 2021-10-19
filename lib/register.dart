import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'startpage.dart';

class SelfCertificationPage extends StatefulWidget {
  SelfCertificationPage({Key? key}) : super(key: key);

  @override
  _SelfCertificationPageState createState() => _SelfCertificationPageState();
}

class _SelfCertificationPageState extends State<SelfCertificationPage> {
  @override
  Widget build(BuildContext context) {
    String phoneNumber;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 3,
            ),
            // status bar
            Row(
              children: [
                SizedBox(
                  width: 86,
                ),
                Text("본인인증"),
              ],
            ),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 300.0,
              lineHeight: 15.0,
              percent: 0.33,
              progressColor: Colors.green,
            ),
            Spacer(
              flex: 3,
            ),
            // phone number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "핸드폰 번호"),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => phoneNumber = value,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text('인증'),
                  ),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            // phone authentication number
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "인증 번호"),
                keyboardType: TextInputType.number,
                onChanged: (value) => phoneNumber = value,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            // name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '이름',
                      ),
                    )),
                SizedBox(
                  width: 200,
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            // Resident Registration Number
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 140,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '주민번호',
                      ),
                      keyboardType: TextInputType.number,
                    )),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 2,
                  width: 10,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                    width: 140,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ))
              ],
            ),
            Spacer(
              flex: 1,
            ),
            // authentication button
            ElevatedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text('실명 인증'),
            ),
            Spacer(
              flex: 3,
            ),
            // prev, next button
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('이전'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreationAccountPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('다음'),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class CreationAccountPage extends StatefulWidget {
  CreationAccountPage({Key? key}) : super(key: key);

  @override
  _CreationAccountPageState createState() => _CreationAccountPageState();
}

class _CreationAccountPageState extends State<CreationAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(
              flex: 3,
            ),
            // status bar
            Row(
              children: [
                SizedBox(
                  width: 186,
                ),
                Text("계정생성"),
              ],
            ),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 300.0,
              lineHeight: 15.0,
              percent: 0.66,
              progressColor: Colors.green,
            ),
            Spacer(
              flex: 3,
            ),
            // id
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "아이디"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text('중복 확인'),
                  ),
                )
              ],
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
            // password re-confirmation
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호 확인',
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            // prev, next button
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('이전'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtherInformationPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('다음'),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class OtherInformationPage extends StatefulWidget {
  OtherInformationPage({Key? key}) : super(key: key);

  @override
  _OtherInformationPageState createState() => _OtherInformationPageState();
}

class _OtherInformationPageState extends State<OtherInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 3,),
            // status bar
            Row(
              children: [
                SizedBox(
                  width: 286,
                ),
                Text("기타정보"),
              ],
            ),
            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 300.0,
              lineHeight: 15.0,
              percent: 1,
              progressColor: Colors.green,
            ),
            Spacer(flex: 2,),
            // sub title
            SizedBox(
              width: 300,
              child: Text(
                "차량정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Spacer(flex: 1,),
            // car info
            SizedBox(
              width: 300,
              child: TextField(
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '차량정보 (예시: 모닝)',
              )),
            ),
            Spacer(flex: 1,),
            // car number
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '차량번호 (예시 : 11가 1234)',
                ),
              ),
            ),
            Spacer(flex: 1,),
            // car license plate color
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Text("차량 번호판 색상"),
                  SizedBox(width: 20,),
                  DropdownButton(
                    value: '흰색',
                    items: ['흰색', '노란색'].map(
                      (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            Spacer(flex: 2,),
            // sub title
            SizedBox(
              width: 300,
              child: Text(
                "정산정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Spacer(flex: 1,),
            // bank
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Text("은행"),
                  SizedBox(width: 20,),
                  DropdownButton(
                    value: '카카오뱅크',
                    items: ['카카오뱅크', '케이뱅크'].map(
                          (value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1,),
            // account number
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '계좌번호',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Spacer(flex: 2,),
            // prev, next button
            SizedBox(
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('이전'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Startpage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 15.0,
                    ),
                    child: Text('완료'),
                  ),
                ],
              ),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
