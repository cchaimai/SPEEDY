import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as Lo;
import 'package:uuid/uuid.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart' as Im;

class DriverInfo extends StatefulWidget {
  const DriverInfo({super.key});

  @override
  State<DriverInfo> createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  final Completer<GoogleMapController> mapcontroller = Completer();
  static const LatLng sourceLocation = LatLng(13.120465, 100.918712);
  static const LatLng destination = LatLng(13.114072, 100.926349);

  List<LatLng> polyLinecoordinates = [];
  Lo.LocationData? currentLocation;
  StreamSubscription<Lo.LocationData>? _locationSubscription;

  Future<void> getCurrentLocation() async {
    Lo.Location location = Lo.Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await mapcontroller.future;

    location.onLocationChanged.listen(
      (newloc) {
        currentLocation = newloc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 15,
              target: LatLng(
                newloc.latitude!,
                newloc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  void getPolyPoint() async {
    PolylinePoints polylinePoint = PolylinePoints();

    PolylineResult result = await polylinePoint.getRouteBetweenCoordinates(
      'AIzaSyBw4oNuCPipSEZZWT10Zq3uhLCvzNx2o1I',
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLinecoordinates.add(LatLng(point.latitude, point.longitude)));
      setState(() {});
    }
  }

  Future<void> _sendLocation() async {
    Lo.Location location = Lo.Location();
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((currentLocation) async {
      await FirebaseFirestore.instance.collection('ULocation').doc('user1').set(
          {
            'latitude': currentLocation.latitude,
            'longitude': currentLocation.longitude
          },
          SetOptions(merge: true));
    });
  }

  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoint();
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }

    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String Place_api_key = 'AIzaSyBw4oNuCPipSEZZWT10Zq3uhLCvzNx2o1I';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$Place_api_key&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString;
    print(response);

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['prediction'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: currentLocation == null
          ? const Center(
              child: Text("Loading"),
            )
          : Stack(children: <Widget>[
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 14.5),
                polylines: {
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: polyLinecoordinates,
                    color: Colors.green,
                    width: 5,
                  ),
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("CurrentLocation"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                  Marker(
                    markerId: MarkerId("Source"),
                    position: sourceLocation,
                  ),
                  Marker(
                    markerId: MarkerId("Destination"),
                    position: destination,
                  ),
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            offset: Offset.zero),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'เสร็จสิ้น',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 45,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Text(
                        'ธนวัฒน์ ช้างขนุน',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Text(
                        'ทะเบียน: ??',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        'ระยะทาง: ??',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       size: 30,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       size: 30,
                      //     ),
                      //     Icon(
                      //       Icons.star_border,
                      //       size: 30,
                      //     ),
                      //     Icon(
                      //       Icons.star_border,
                      //       size: 30,
                      //     ),
                      //     Icon(
                      //       Icons.star_border,
                      //       size: 30,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.34),
                child: CircleAvatar(
                  // backgroundImage: AssetImage('assets/images/Image3.png'),
                  backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                  radius: 40,
                  child: Icon(
                    Icons.account_circle,
                    size: 70,
                    color: Colors.black,
                  ),
                ),
              ),
            ]),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _sendLocation();
            },
            child: Icon(
              Icons.bolt,
              size: 35,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color.fromARGB(255, 31, 31, 31),
        notchMargin: 5,
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.house_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'หน้าหลัก',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fact_check_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เช็ค',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Charge',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.change_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เปลี่ยน',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'โปรไฟล์',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
