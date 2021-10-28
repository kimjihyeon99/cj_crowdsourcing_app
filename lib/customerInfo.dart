import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'completeCamera.dart';
import 'package:camera/camera.dart';

import 'dart:io';

class Customerinfo extends StatefulWidget {
  final String name;
  final int type;

  const Customerinfo({
    Key? key,
    required this.name,
    required this.type,
  }) : super(key: key);

  @override
  _CustomerpageState createState() => _CustomerpageState();
}

class _CustomerpageState extends State<Customerinfo> {
  File? returnImage;
  CameraController? _cameraController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.type==0){//진행중
      return Scaffold(
          appBar: AppBar(
            title: Text("${widget.name} 고객님"),
          ),
          body: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Text("현관 비밀번호"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    returnImage == null
                        ? Center(
                      child: Container(
                        width: size.width*0.8,
                        height: size.width*0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 3),
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "사진 업로드 하세요",
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                        : Container(
                      width: size.width*0.8,
                      height: size.width*0.8,
                      child: ClipRect(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: SizedBox(
                            width: size.width*0.8,
                            child: AspectRatio(
                              aspectRatio:
                              1 / _cameraController!.value.aspectRatio,
                              child: Container(
                                width: size.width*0.8,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                      MemoryImage(returnImage!.readAsBytesSync()),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width*0.8,
                      child: CupertinoButton(
                          color: Colors.lightBlue,
                          child: Text("사진 업로드"),
                          onPressed: () async {
                            final uploadImage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Completecamera()));

                            setState(() {
                              returnImage = uploadImage[0];
                              _cameraController = uploadImage[1];
                            });
                          }),
                    ),

                  ],
                ),
              )),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: Colors.lightBlue,
                  child: Text("배송완료"),
                  onPressed: () {
                    //배송완료 처리
                    if (returnImage != null)
                      Navigator.pop(context, 1);
                    else
                      Navigator.pop(context, 0);
                  },
                ),
              )
            ],
          ));
    }else {//완료
      return Scaffold(
          appBar: AppBar(
            title: Text("${widget.name} 고객님"),
          ),
          body: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      child: Text("현관 비밀번호"),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ))
            ],
          ));
    }
  }
}
