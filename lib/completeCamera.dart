import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class Completecamera extends StatefulWidget {
  @override
  _CompletepageState createState() => _CompletepageState();
}

class _CompletepageState extends State<Completecamera> {
  CameraController? _cameraController;
  Future<void>? _initCameraControllerFuture;
  int cameraIndex = 0;

  bool isCapture = false;
  File? captureImage;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController =
    new CameraController(cameras[cameraIndex], ResolutionPreset.veryHigh);
    _initCameraControllerFuture = _cameraController!.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("사진 촬영"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: isCapture
          ? Column(
        children: [
          /// 촬영 된 이미지 출력
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: Container(
              width: size.width,
              height: size.width,
              child: ClipRect(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: SizedBox(
                    width: size.width,
                    child: AspectRatio(
                      aspectRatio:
                      1 / _cameraController!.value.aspectRatio,
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(
                                  captureImage!.readAsBytesSync()),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(child: Text("재촬영",style:TextStyle(color:Colors.lightBlue)), color:Colors.white,onPressed: (){
                  /// 재촬영 선택시 카메라 삭제 및 상태 변경
                  captureImage!.delete();
                  captureImage = null;
                  setState(() {
                    isCapture = false;
                  });
                }),
                CupertinoButton(child: Text("업로드",style:TextStyle(color:Colors.white)),color:Colors.lightBlue, onPressed: (){
                  //이전 화면으로 넘어가면서 사진 가져가기
                  //사진을 fiabase에 업로드하고, 업로드된 사진을 이전화면에서 가져와 보여주기, 사용자 uid 필요함, 나중에 재구현
                  Navigator.pop(context, [captureImage,_cameraController]);
                })
              ],
            )
          ),
        ],
      )
          : Column(
        children: [
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: FutureBuilder<void>(
              future: _initCameraControllerFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: size.width,
                    height: size.width,
                    child: ClipRect(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: SizedBox(
                          width: size.width,
                          child: AspectRatio(
                              aspectRatio: 1 /
                                  _cameraController!.value.aspectRatio,
                              child: CameraPreview(_cameraController!)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _cameraController!
                            .takePicture()
                            .then((value) {
                          captureImage = File(value.path);
                        });

                        /// 화면 상태 변경 및 이미지 저장
                        setState(() {
                          isCapture = true;
                        });
                      } catch (e) {
                        print("$e");
                      }
                    },
                    child: Container(
                      height: 80.0,
                      width: 80.0,
                      padding: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: Colors.black, width: 1.0),
                        color: Colors.white,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                          Border.all(color: Colors.black, width: 3.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        /// 후면 카메라 <-> 전면 카메라 변경
                        cameraIndex = cameraIndex == 0 ? 1 : 0;
                        await _initCamera();
                      },
                      icon: Icon(
                        CupertinoIcons.camera_rotate,
                        color: Colors.white,
                        size: 34.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
