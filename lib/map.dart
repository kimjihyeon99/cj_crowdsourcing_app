import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng currentLatLng = new LatLng(0, 0);
  int numOfDoing = 1; // 배송 중인 건수
  int numOfDone = 1; // 배송완료된 건수
  List<Marker> _markers = [
    Marker(
        markerId: MarkerId("doing_1"),
        position: LatLng(36.362925, 127.348352),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "배송 정보", snippet: "수취인 : 김아영")),
    Marker(
        markerId: MarkerId("done_1"),
        position: LatLng(36.362583, 127.349973),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: "배송 정보", snippet: "수취인 : 김지현")),
  ];

  @override
  void initState() {
    super.initState();
    // 지도 위치를 현재 위치로 설정
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        currentLatLng =
            new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
    // 진행 중인 배송과 완료된 배송의 주소를 불러와 마커로 표시 -> 추후
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: currentLatLng.latitude == 0 && currentLatLng.longitude == 0
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition:
                        CameraPosition(target: currentLatLng, zoom: 15),
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
                      width: 150,
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
