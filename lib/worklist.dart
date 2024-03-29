import 'dart:convert' as convert;
import 'package:cj_crowdsourcing_app/startpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'model/diliver.dart';

class Worklist extends StatefulWidget {
  String id;
  List<Diliver> titems;
  List<Diliver> items;
  int state;
  int wstate;
  String isqr;

  Worklist(
      {Key? key,
      required this.id,
      required this.titems,
      required this.items,
      required this.state,
      required this.wstate,
      required this.isqr})
      : super(key: key);

  @override
  _WorklistPageState createState() => _WorklistPageState();
}

int workingState = 0;
int workApplyState = 0;

class _WorklistPageState extends State<Worklist> {
  String _scanBarcode = 'Unknown';
  List<List<dynamic>> data = [];
  List<Diliver> items = [];

  //업무 목록 탭바 선택시
  final workList = ['업무 신청', '진행중 업무', '종료된 업무'];

  Set<int> tempsmlist = Set(); //택배기사 집합
  Set<String> barlist = Set(); //바코드 찍은 리스트
  List<int> smlist = []; //택배기사 리스트
  List smcount = []; //택배 기사마다 물품개수

  Future _loadjson() async {
    var result = await rootBundle.loadString('assets/mytest.json');
    var response = convert.json.decode(result);

    var jr = response;
    jr = jr.cast<Map<String, dynamic>>();
    List<Diliver> data =
        jr.map<Diliver>((json) => Diliver.fromJson(json)).toList();
    items.addAll(data.where(
        (element) => element.date.compareTo("2021-05-31 00:00:00") == 0));
  }

  int initialIndexInWorklist = 0;

  String isqr = "qr scan";

  @override
  void initState() {
    super.initState();
    workApplyState = widget.state;
    workingState = widget.wstate; //0은 업무진행 전, 1은 업무 진행 중
    if (widget.isqr != "") {
      isqr = widget.isqr;
    }
    //스캔 기능
    _scanCode();
  }

  //초기화
  workDetail wd =
      new workDetail(smname: 0, location: "", date: "", deliveryCount: 0);

  //qr 찍고난 후 결과 값
  String _output = 'Empty Scan Code';
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      isqr = "barcode scan";
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      //중복이 안되면, 리스트 하나씩 증가 set에 넣으면 될듯
      barlist.add(barcodeScanRes);
      if (barlist.length == wd.deliveryCount) {
        isqr = "배송목록보기";
      }
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: workList.length,
          initialIndex: initialIndexInWorklist,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(physics: ClampingScrollPhysics(),
                  // backgroundColor: Colors.red,
                  // unselectedBackgroundColor: Colors.grey[300],
                  // unselectedLabelStyle: TextStyle(color: Colors.black),
                  // labelStyle:
                  // TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: workList[0],
                      icon: Icon(CupertinoIcons.add_circled),
                    ),
                    Tab(
                      text: workList[1],
                      icon: Icon(CupertinoIcons.check_mark_circled),
                    ),
                    Tab(
                      text: workList[2],
                      icon: Icon(CupertinoIcons.check_mark_circled_solid),
                    )
                  ]),
              Expanded(
                  child: TabBarView(
                children: <Widget>[
                  //업무 신청
                  Align(
                    alignment: Alignment.center,
                    child: showWorkList(workApplyState, context),
                  ),
                  //진행중 업무
                  Align(
                    alignment: Alignment.center,
                    child: showWorkingContent(workingState, context),
                  ),
                  //종료된 업무
                  Align(
                    alignment: Alignment.center,
                    child: showWorkedList(),
                  ),
                ],
              ))
            ],
          )),
    );
  }

  //업무신청
  showWorkList(int state, BuildContext context) {
    //업무 신청 전
    if (state == 0) {
      return Center(
        child: CupertinoButton(
            child: Text("+ 업무 신청"),
            color: Colors.blueAccent,
            onPressed: () async {
              await _loadjson();

              setState(() {
                //업무 신청 상태 바꾸기
                workApplyState = 1;
                //csv파일 읽으면서, db에 넣기
                items.forEach((element) {
                  tempsmlist.add(element.SMname);
                });
                smlist = tempsmlist.toList();
                smlist.forEach((element) {
                  smcount.add(items
                      .where((c) => element.compareTo(c.SMname) == 0)
                      .toList()
                      .length);
                });
              });
            }),
      );
    }
    //업무 신청 후
    if (state == 1) {
      if (widget.titems.length != 0) {
        items = widget.titems;

        items.forEach((element) {
          tempsmlist.add(element.SMname);
        });
        smlist = tempsmlist.toList();
        smlist.forEach((element) {
          smcount.add(items
              .where((c) => element.compareTo(c.SMname) == 0)
              .toList()
              .length);
        });
      }

      //위치 받아오기
      String currentLocation = "대전시 유성구 145-1번길";
      //오늘 날짜
      String today = "5월 31일";
      //업무 수 받아오기
      int workCount = smlist.length;

      //업무 내용 임시 저장
      String destination = "대전시 유성구 145";
      String time = today + "12:50~18:00"; //업무시간

      if (workCount == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            //현재 위치
            Text("현재 위치 : $currentLocation "),
            SizedBox(
              height: 10,
            ),
            //진행 가능 업무 수
            Text("진행 가능 업무 수 : $workCount"),
            //진행 가능 업무 수에 따른 업무 박스
            SizedBox(
              height: 200,
            ),
            Text("진행 가능한 업무가 없습니다"),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                //다시 조회하기 -> 위치랑 업무수 다시 받아오기
              },
            )
          ],
        );
      }
      //진행가능 업무 있을 때
      else {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            //현재 위치
            Text("현재 위치 : $currentLocation "),
            SizedBox(
              height: 10,
            ),
            //현재 위치
            Text("날짜 : $today "),
            SizedBox(
              height: 10,
            ),
            //진행 가능 업무 수
            Text("진행 가능 업무 수 : $workCount"),
            //진행 가능 업무 수에 따른 업무 박스
            Container(
                height: 605,
                child: ListView.builder(
                  itemCount: smlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    int count = index + 1;
                    //진행 가능 업무 없을 경우
                    return Card(
                      child: ListTile(
                        minLeadingWidth: 10,
                        leading: Text("$count"),
                        title: Text("택배기사명: " + smlist[index].toString()),
                        //값 받아오기
                        subtitle: Text('\n배송시간 : $time \n물품 수 :' +
                            smcount[index].toString()),
                        trailing: ElevatedButton(
                          child: Text("수락"),
                          onPressed: () {
                            //수락 누르면 경고 띄우기
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                // title: const Text('AlertDialog Title'),
                                content:
                                    const Text('배송 취소는 불가능합니다.\n신중히 결정해주세요.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, '취소'),
                                    child: const Text('취소'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      int clickindex = index;
                                      int smname = smlist[clickindex];
                                      int clickcount = smcount[clickindex];
                                      setState(() {
                                        //업무 신청 상태 변경
                                        workApplyState = 2;
                                        workingState = 1;
                                        //업무 수락후 진행중 업무 페이지 ㄱㄱ
                                        initialIndexInWorklist = 1;
                                        //업무 내용 넣기
                                        wd = workDetail(
                                            smname: smname,
                                            location: destination,
                                            date: time,
                                            deliveryCount: clickcount);
                                      });
                                      Navigator.pop(context, '수락');
                                    },
                                    child: const Text('수락'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ))
          ],
        );
      }
    }
    if (state == 2) {
      return Center(
        child: Text("업무 진행 중입니다. \n 새로운 업무는 진행 중인 업무를 끝내고 받을 수 있습니다."),
      );
    }
  }

  //업무 진행중일때
  showWorkingContent(int working, BuildContext context) {
    if (working == 0) {
      return Center(
        child: Text("진행중인 업무가 없습니다.\n업무 신청을 해주세요"),
      );
    } else {
      if (widget.items.length != 0) {
        wd = workDetail(
            smname: widget.items[0].SMname,
            location: "대전시 유성구 145-1번길",
            date: "2021년 05월 31일",
            deliveryCount: widget.items.length);
      }

      //완료업무 개수
      int completeWorkList = 0;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //column 내용물에 따라 알아서 맞춰짐
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //오늘 날짜
              Text(
                  "${DateFormat('yyyy년 MM월 dd일').format(DateTime.now()).toString()}"),
              Text("오늘 완료 업무 : $completeWorkList 개"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "진행 업무 상세 정보",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(30),
            alignment: Alignment.centerLeft,
            //위치 내용에 자동으로 맞추기
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "배달 장소 : ${wd.location}",
                  style: TextStyle(fontSize: 20),
                ),
                Text("시간 : ${wd.date}", style: TextStyle(fontSize: 20)),
                Text("배달 품목 수 : ${wd.deliveryCount}",
                    style: TextStyle(fontSize: 20)),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        if (isqr.compareTo("qr scan") == 0) {
                          scanQR();
                        } else if (isqr.compareTo("barcode scan") == 0) {
                          scanBarcodeNormal();
                        } else {
                          //items 필요한거 추출
                          List<Diliver> pitem = [];
                          items.forEach((element) {
                            if (element.SMname == wd.smname) {
                              pitem.add(element);
                            }
                          });
                          items.removeWhere(
                              (element) => element.SMname == wd.smname);
                          print(pitem);
                          //배송목록화면 넘어가기
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Startpage(
                                      id: widget.id,
                                      page: 1,
                                      items: pitem,
                                      titems: items,
                                      state: workApplyState,
                                      wstate: workingState,
                                      isqr: isqr)));
                        }
                      },
                      child: Text(isqr)),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  //종료된 업무 보여주기
  showWorkedList() {
    //임시 종료된 업무 객체
    workDetail wd1 = new workDetail(
        smname: 10,
        location: "대전시 유성구 123-1",
        date: "2021년 07월 1일",
        deliveryCount: 100);
    workDetail wd2 = new workDetail(
        smname: 11,
        location: "대전시 유성구 123-2",
        date: "2021년 07월 4일",
        deliveryCount: 40);

    //종료된 업무개수 받기
    int workedCount = 20;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //column 내용물에 따라 알아서 맞춰짐
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //오늘 날짜
            Text(
                "${DateFormat('yyyy년 MM월 dd일').format(DateTime.now()).toString()}"),
            Text("오늘 완료 업무 : $workedCount 개"),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "종료된 업무",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          margin: EdgeInsets.all(10),
          //하단 네비게이션 바 위로 위치 다시 잡기.....ㅠㅠ
          height: MediaQuery.of(context).size.height - 220,
          child: ListView.builder(
            itemCount: workedCount,
            itemBuilder: (BuildContext context, int index) {
              //진행 가능 업무 없을 경우
              return Card(
                child: ListTile(
                  //가지고 있는 완료 정보 가져와야함 -> db에서 가져오면 되긴하는데 아직 없어서 임시방편으로 값 만듦
                  title: Text("${wd1.location}"),
                  //값 받아오기
                  subtitle:
                      Text("배송시간 : ${wd1.date} \n물품 수 : ${wd1.deliveryCount}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

//진행중인 업무 객체 만들기
class workDetail {
  //주소, 시간, 품목, 배달품목 수
  int smname;
  String location;
  String date;
  int deliveryCount;

  workDetail(
      {required this.smname,
      required this.location,
      required this.date,
      required this.deliveryCount});
}
