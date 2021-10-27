import 'package:cj_crowdsourcing_app/model/diliver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customerInfo.dart';
import 'dart:math';

Map people = {};
List<String> name = [];

class Diliverlist extends StatefulWidget {
  List<Diliver> items;
  Diliverlist({Key? key,required this.items}) : super(key: key);

  @override
  _DiliverlistPageState createState() => _DiliverlistPageState(items:items);
}

class _DiliverlistPageState extends State<Diliverlist> {
  List<Diliver> items;

  _DiliverlistPageState({required this.items});

  String generateRandomString(int len) {
    var r = Random();
    String randomString =String.fromCharCodes(List.generate(len, (index)=> r.nextInt(33) + 89));
    return randomString;
  }

  final titlelist = ["진행", "완료", "미완"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = List<String>.generate(items.length, (index) => generateRandomString(5) );
    for(int i=0;i<items.length;i++){
      people[name[i]] =0;
    }

  }

  @override
  Widget build(BuildContext context) {
    print(items);

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i==0){
            List processinglist =[];
            people.forEach((key, value) {
              if(value==0){
                processinglist.add(key);
              }
            });
            return mydeliverlist(processinglist,i);
          }else if(i==1) {
            List completelist =[];
            people.forEach((key, value) {
              if(value==1){
                completelist.add(key);
              }
            });
            return mydeliverlist(completelist,i);
          }else{
            List unfinishedlist =[];
            people.forEach((key, value) {
              if(value==2){
                unfinishedlist.add(key);
              }
            });
            return mydeliverlist(unfinishedlist,i);
          }

        },
        itemCount: 3,
      ),
    );
  }
  Widget mydeliverlist(List mylist, int i){

    int idx =0;
    if(mylist.length ==0){
      return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(8)),
        ),
        child: ExpansionTile(
          title: new Text(titlelist[i]+" ("+"${mylist.length})"),
          children: [
            Container(
              child: Text("해당 목록 리스트가 없습니다."),
            )
          ]
        ),
      );
    }else{
      return Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(8)),
        ),
        child: ExpansionTile(
          title: new Text(titlelist[i]+" ("+"${mylist.length})"),
          children:items
              .map((val) => ListTile(
              title:
              new Column(children: [Text("수취인 : ${mylist[idx]}"),Text("품목 : ${val.subject}"), Text("배송주소 : ${val.address}")]),
              onTap: () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Customerinfo(name: mylist[idx])));

                setState(() {
                  if (result!=null){
                    people[val] = result;
                  }

                });
              } // 클릭하면 고객정보로
          ))
              .toList(),
        ),
      );
    }

  }
}
