import 'package:chat_test/pages/cardpayment.dart';
import 'package:chat_test/pages/couponpayment.dart';
import 'package:chat_test/pages/finalpayment.dart';
import 'package:chat_test/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

import 'auth/profile_beam.dart';
import 'change_test.dart';
import 'check_main.dart';
import 'home_page.dart';

class Payment extends StatefulWidget {
  const Payment(
      {super.key,
      required this.price,
      required this.ID,
      required this.dis,
      required this.couponID});
  final String price;
  final String ID;
  final num dis;
  final String couponID;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final Completer<GoogleMapController> mapcontroller = Completer();

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

    _locationSubscription = location.onLocationChanged.listen(
      (newloc) {
        currentLocation = newloc;

        setState(() {});
      },
    );
  }

  String totalprice = '';

  Future<void> discount() async {
    if (widget.dis >= 1) {
      totalprice = (num.parse(widget.price) - widget.dis).toString();
    } else {
      totalprice =
          (num.parse(widget.price) - (num.parse(widget.price) * widget.dis))
              .toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _locationSubscription?.cancel();
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    getCurrentLocation();
    discount();

    super.initState();
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
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 190,
                  width: 320,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              nextScreenReplace(
                                  context,
                                  Fpayment(
                                    price: widget.price,
                                    ID: widget.ID,
                                    totalprice: totalprice,
                                    couponID: widget.couponID,
                                  ));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.payments_outlined,
                                  size: 30,
                                ),
                                Text(
                                  'คิวอาร์โค้ด',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 1.0,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('--------------บัตร--------------------');
                              nextScreen(
                                  context,
                                  Cardpayment(
                                    price: widget.price,
                                    ID: widget.ID,
                                    totalprice: totalprice,
                                    couponID: widget.couponID,
                                  ));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.add_card_outlined,
                                  size: 30,
                                ),
                                Text(
                                  'บัตรเครดิต/เดบิต',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            width: 1.0,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print(
                                  '--------------โค้ดส่วนลด--------------------');
                              nextScreen(
                                  context,
                                  Couponpayment(
                                      price: widget.price, ID: widget.ID));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.sell_outlined,
                                  size: 30,
                                ),
                                Text(
                                  'โค้ดส่วนลด',
                                  style: GoogleFonts.prompt(
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 0,
                        thickness: 1,
                        color: Colors.black,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Text(
                        '$totalprice฿',
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                            fontSize: 38,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {},
            child: Icon(
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
