import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_test/pages/change_queue.dart';
import 'package:chat_test/pages/profile_beam.dart';
import 'package:chat_test/pages/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/helper_function.dart';
import '../service/auth_service.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  Stream? groups;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    fetchCarouselImages();
    gettingUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('mUsers').doc(uid);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data()!;
      final firstName = data['firstName'] as String?;
      final showName = '$firstName';
      setState(() {
        userName = showName;
      });
    }
  }

  // gettingUserData() async {
  //   final phone = await HelperFunction.getUserPhoneFromSF();
  //   if (phone != null) {
  //     setState(() {
  //       userName = phone;
  //     });
  //   }
  // }

  gettingAnonData() async {
    final userUid = await HelperFunction.getUserUidFromSF();
    if (userUid != null) {
      setState(() {
        userName = userUid;
      });
      // print('User uid: $userUid');
    }
  }

  final List<String> _carouselImages = [];
  var _dotPosition = 0;

  fetchCarouselImages() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestoreInstance.collection("banners").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["image"],
        );
      }
    });
    return qn.docs;
  }

  // getUsername() async {
  //   var firestoreInstance = FirebaseFirestore.instance;
  //   DocumentSnapshot userDoc =
  //       await firestoreInstance.collection("mUsers").doc(userId).get();
  //   String? val = userDoc['fisrtName'];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_active)),
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, ProfileScreen());
              },
              icon: const Icon(
                Icons.account_circle,
                size: 30,
              )),
        ],
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo white.png',
              fit: BoxFit.contain,
              height: 80,
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            color: Color.fromARGB(255, 31, 31, 31),
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SafeArea(
                child: GestureDetector(
                    child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CarouselSlider(
                        items: _carouselImages
                            .map((item) => Padding(
                                  padding:
                                      const EdgeInsets.only(left: 3, right: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(item),
                                            fit: BoxFit.fitWidth)),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            viewportFraction: 0.8,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (val, carouselPageChangedReason) {
                              setState(() {
                                _dotPosition = val;
                              });
                            })),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                DotsIndicator(
                  dotsCount:
                      _carouselImages.isEmpty ? 1 : _carouselImages.length,
                  position: _dotPosition.toDouble(),
                  decorator: const DotsDecorator(
                    activeColor: Colors.green,
                    color: Colors.grey,
                    spacing: EdgeInsets.all(2),
                    activeSize: Size(8, 8),
                    size: Size(6, 8),
                  ),
                ),
                Expanded(
                    child: Stack(children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 395,
                      height: 420,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 217, 217, 217),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      alignment: const AlignmentDirectional(0, 0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-0.8, -0.65),
                            child: GestureDetector(
                              onTap: () {
                                print(userName);
                              },
                              child: SizedBox(
                                width: 160,
                                height: 170,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.bolt,
                                        size: 70,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "CHARGE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-0.8, 0.85),
                            child: GestureDetector(
                              onTap: () {
                                nextScreenReplace(context, const testPage());
                              },
                              child: SizedBox(
                                width: 160,
                                height: 170,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.task,
                                        size: 55,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "CHECK",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.8, -0.65),
                            child: GestureDetector(
                              onTap: () {
                                nextScreenReplace(context, const changeQueue());
                              },
                              child: SizedBox(
                                width: 160,
                                height: 170,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(
                                        Icons.change_circle_rounded,
                                        size: 55,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "CHANGE",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.8, 0.85),
                            child: SizedBox(
                              width: 160,
                              height: 170,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(
                                      Icons.electric_car,
                                      size: 55,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      "MY CAR",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(-0.75, -0.95),
                            child: Text("สวัสดี, คุณ $userName!",
                                style: GoogleFonts.prompt(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))
              ],
            )));
          }),
    );
  }
}
