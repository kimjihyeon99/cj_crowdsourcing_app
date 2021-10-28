import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:translator/translator.dart';

import 'package:cj_crowdsourcing_app/model/diliver.dart';

class MapPage extends StatefulWidget {
  List<Diliver> items;

  MapPage({Key? key, required this.items}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentLatLng = new LatLng(0, 0);
  int numOfDone = 0; // 배송완료된 건수
  int numOfDoing = 0; // 배송 중인 건수
  List<Marker> _markers = []; // 마커 목록

  @override
  void initState() {
    super.initState();
    // 처음 지도의 위치를 현재 위치로 설정
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });

    // 진행 중인 배송과 완료된 배송의 주소를 불러와 마커로 표시
    widget.items.forEach((element) {
      numOfDoing++;
      GoogleTranslator()
          .translate(element.address, from: 'ko', to: 'en')
          .then((value) => {
                locationFromAddress(value.text).then((value) => {
                      _markers.add(
                        Marker(
                            markerId:
                                MarkerId("doing_" + numOfDoing.toString()),
                            position:
                                LatLng(value[0].latitude, value[0].longitude),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed),
                            infoWindow: InfoWindow(
                                title: "배송 정보",
                                snippet:
                                    "배송지 : " + element.address.toString())),
                      )
                    })
              });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: currentLatLng.latitude == 0 &&
              currentLatLng.longitude == 0 &&
              _markers.length != widget.items.length
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: currentLatLng, zoom: 15),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: _markers.toSet(),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    child: Container(
                      width: 200,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "배송중(red) : " + numOfDoing.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(""),
                          Text(
                            "배송완료(blue) : " + numOfDone.toString(),
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.6)),
                    ),
                  ),
                ],
              )),
    );
  }
}
