import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:chat_test/pages/chargedetail.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/pages/process.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'dart:developer';

import '../widgets/widgets.dart';
import 'auth/profile_beam.dart';
import 'change_test.dart';
import 'check_main.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> mapcontroller = Completer();

  static const LatLng sourceLocation = LatLng(13.120465, 100.918712);
  static const LatLng destination = LatLng(13.114072, 100.926349);

  Lo.LocationData? currentLocation;
  StreamSubscription<Lo.LocationData>? _locationSubscription;

  Future<void> getCurrentLocation() async {
    Lo.Location location = Lo.Location();

    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );

    _locationSubscription = location.onLocationChanged.listen(
      (newloc) {
        currentLocation = newloc;
        setState(() {});
      },
    );
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  String name = '';
  String phone = "";

  Future<void> getUserData() async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('mUsers').doc(userId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    name = userDocSnapshot.get('firstName');
    phone = userDocSnapshot.get('phoneNumber');
    setState(() {});
  }

  String? workID;

  Future<String> _getLocation() async {
    Lo.Location location = Lo.Location();
    final Lo.LocationData _locationResult = await location.getLocation();
    workID = (Random().nextInt(900000) + 100000).toString();

    DocumentReference requestDocumentReference =
        await FirebaseFirestore.instance.collection('requests').add({
      'Ulatitude': _locationResult.latitude,
      'Ulongitude': _locationResult.longitude,
      'Uname': '$name',
      'Uphone': '$phone',
      'reId': '',
      'workID': '$workID',
      'UPhone': phone,
    });
    await requestDocumentReference.update({
      "reId": requestDocumentReference.id,
    });
    return requestDocumentReference.id.toString();
  }

  @override
  void initState() {
    getUserData();
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                markers: {
                  Marker(
                    markerId: const MarkerId("CurrentLocation"),
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                },
              ),
              // Padding(
              //   padding: EdgeInsets.all(defaultPadding),
              //   child: TextFormField(
              //     onChanged: (value) {},
              //     textInputAction: TextInputAction.search,
              //     decoration: InputDecoration(
              //       hintText: 'Search Your Location',
              //       prefixIcon: Icon(Icons.search),
              //     ),
              //   ),
              // )
            ]),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {
              _getLocation().then((value) {
                print(value);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChargeDetail(
                              ID: value,
                            )));
              });
            },
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
                  nextScreenReplace(context, checkScreen(carId: '', car: ''));
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
                  nextScreenReplace(context, changeTest(carId: '', car: ''));
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
                  nextScreenReplace(context, ProfileScreen());
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
