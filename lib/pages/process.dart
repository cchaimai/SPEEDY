import 'dart:math';

import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/widgets/widgets.dart';
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

import 'driverinfo.dart';

class Waiting extends StatefulWidget {
  const Waiting({super.key, required this.uid});
  final String uid;
  @override
  State<Waiting> createState() => WaitingState();
}

class WaitingState extends State<Waiting> {
  final Completer<GoogleMapController> mapcontroller = Completer();
  static const LatLng sourceLocation = LatLng(13.120465, 100.918712);
  static const LatLng destination = LatLng(13.114072, 100.926349);

  List<LatLng> polyLinecoordinates = [];
  Lo.LocationData? currentLocation;
  StreamSubscription<Lo.LocationData>? _locationSubscription;

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

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

  var uuid = const Uuid();
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
    print(
        '----------------------------------${widget.uid}----------------------------------');
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

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('requests').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final status = snapshot.data!.docs
                .singleWhere((doc) => doc.id == widget.uid)['status'];
            if (status == 'Accepted') {
              return currentLocation == null
                  ? Center(
                      child: Text(snapshot.data!.docs
                          .singleWhere((doc) => doc.id == widget.uid)['dName']),
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
                            position: LatLng(
                              snapshot.data!.docs.singleWhere(
                                  (doc) => doc.id == widget.uid)['dlatitude'],
                              snapshot.data!.docs.singleWhere(
                                  (doc) => doc.id == widget.uid)['dlongitude'],
                            ),
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
                          height: 190,
                          width: 340,
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
                                snapshot.data!.docs.singleWhere(
                                    (doc) => doc.id == widget.uid)['dName'],
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Text(
                                'ทะเบียน: ${snapshot.data!.docs.singleWhere((doc) => doc.id == widget.uid)['dCarID']}',
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Text(
                                'ระยะทาง: ${calculateDistance(currentLocation!.latitude!, currentLocation!.longitude!, snapshot.data!.docs.singleWhere((doc) => doc.id == widget.uid)['dlatitude'], snapshot.data!.docs.singleWhere((doc) => doc.id == widget.uid)['dlongitude']).toStringAsFixed(2)} กม.',
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
                        alignment: Alignment(0, 0.52),
                        child:
                            // Container(
                            //   height: 70,
                            //   width: 70,
                            //   margin: const EdgeInsets.only(left: 30, right: 30),
                            //   decoration: const BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       image: DecorationImage(
                            //           fit: BoxFit.cover,
                            //           image:
                            //               AssetImage("user_map/assets/images/Image3.png"))),
                            // ),

                            CircleAvatar(
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
                    ]);
              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   Navigator.of(context).pushReplacement(
              //     MaterialPageRoute(builder: (context) => const DriverInfo()),
              //   );
              //});
            } else if (status == 'Done') {
              return currentLocation == null
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
                          height: 220,
                          width: 340,
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
                                    fontSize: 42,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Text(
                                snapshot.data!.docs.singleWhere(
                                    (doc) => doc.id == widget.uid)['dName'],
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Text(
                                'ทะเบียน: ${snapshot.data!.docs.singleWhere((doc) => doc.id == widget.uid)['dCarID']}',
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
                        alignment: Alignment(0, 0.42),
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
                    ]);
            }
            return currentLocation == null
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
                          polylineId: const PolylineId("route"),
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
                        const Marker(
                          markerId: MarkerId("Source"),
                          position: sourceLocation,
                        ),
                        const Marker(
                          markerId: MarkerId("Destination"),
                          position: destination,
                        ),
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 190,
                        width: 340,
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
                              'กำลังดำเนินการ',
                              style: GoogleFonts.prompt(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text(
                              'โปรดรอสักครู่...',
                              style: GoogleFonts.prompt(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.52),
                      child:
                          // Container(
                          //   height: 70,
                          //   width: 70,
                          //   margin: const EdgeInsets.only(left: 30, right: 30),
                          //   decoration: const BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image:
                          //               AssetImage("user_map/assets/images/Image3.png"))),
                          // ),

                          CircleAvatar(
                        // backgroundImage: AssetImage('assets/images/Image3.png'),
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        radius: 40,
                        child: Icon(
                          Icons.update,
                          size: 70,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.79, 0.53),
                      child: InkWell(
                        onTap: () {
                          print('Earth na hee');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                backgroundColor: Colors.black,
                                title: Center(
                                  child: Text(
                                    'คุณต้องการที่จะยกเลิก?',
                                    style: GoogleFonts.prompt(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff3BB54A),
                                          fixedSize: const Size(100, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Text(
                                          "ยืนยัน",
                                          style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          fixedSize: const Size(100, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Text(
                                          "ยกเลิก",
                                          style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            if (value == true) {
                              // ทำงานเมื่อผู้ใช้กด "Yes"
                            } else {
                              // ทำงานเมื่อผู้ใช้กด "No" หรือปิด pop-up
                            }
                          });
                        },
                        child: Text(
                          'ยกเลิก',
                          style: GoogleFonts.prompt(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ]);
          }),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {},
            child: const Icon(
              Icons.bolt,
              size: 35,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 31, 31, 31),
        notchMargin: 5,
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  nextScreenReplace(context, const HomePage());
                },
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.house_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'หน้าหลัก',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
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
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เช็ค',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Charge',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
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
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.change_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เปลี่ยน',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
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
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'โปรไฟล์',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
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
