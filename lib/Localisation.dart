import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'findDevices.dart';
import 'deviceScreen.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class LocalisationPage extends StatefulWidget {
  const LocalisationPage({Key key}) : super(key: key);

  @override
  State<LocalisationPage> createState() => _LocalisationPageState();
}

class _LocalisationPageState extends State<LocalisationPage> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  int _selectedIndex = 0;
  Color selectedColor = Color.fromARGB(255, 12, 46, 106);
  Color unSelectedColor = Colors.grey;
  DeviceScreen device = DeviceScreen();
  Geolocator geo = Geolocator();

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    var lat = position.latitude;
    var longt = position.longitude;
    GeoPoint point = GeoPoint(lat, longt);

    FirebaseFirestore.instance.collection('data').add({
      'deviceID': 'test',
      'geopoint': point,
    });
  }

  void _onTap(int tapIndex) {
    setState(() {
      _selectedIndex = tapIndex;
    });
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                height: 60.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0)),
                    color: Colors.white),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FindDevicesScreen(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(Icons.search,
                                color: _selectedIndex == 1
                                    ? selectedColor
                                    : unSelectedColor),
                            Text("Find",
                                style: TextStyle(
                                    color: _selectedIndex == 1
                                        ? selectedColor
                                        : unSelectedColor))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => _onTap(1),
                        child: Column(
                          children: [
                            Icon(Icons.location_on,
                                color: _selectedIndex == 0
                                    ? selectedColor
                                    : unSelectedColor),
                            Text("Location",
                                style: TextStyle(
                                    color: _selectedIndex == 0
                                        ? selectedColor
                                        : unSelectedColor))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Icon(Icons.settings,
                                color: _selectedIndex == 2
                                    ? selectedColor
                                    : unSelectedColor),
                            Text("Settings",
                                style: TextStyle(
                                    color: _selectedIndex == 2
                                        ? selectedColor
                                        : unSelectedColor))
                          ],
                        ),
                      ),
                    ])),
          ],
        ),
      ),
    );
  }
}
