import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'customerInfo.dart';

Map people = {"김지현": 0,"홍길동":0, "김아영": 1, "송현진": 2};

class Diliverlist extends StatefulWidget {
  Diliverlist({Key? key}) : super(key: key);

  @override
  _DiliverlistPageState createState() => _DiliverlistPageState();
}

class _DiliverlistPageState extends State<Diliverlist> {
  final titlelist = ["진행", "완료", "미완"];

  @override
  Widget build(BuildContext context) {
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
        children:mylist
            .map((val) => ListTile(
            title:
            new Column(children: [Text("수취인 ${val}"), Text("배송주소")]),
            onTap: () async {
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Customerinfo(name: val)));

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
