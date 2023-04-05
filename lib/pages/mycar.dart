import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_test/pages/addcar.dart';
import 'package:chat_test/pages/auth/profile_beam.dart';
import 'package:chat_test/pages/change_test.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'check_main.dart';

class myCarScreen extends StatefulWidget {
  const myCarScreen({super.key});

  @override
  State<myCarScreen> createState() => _myCarScreenState();
}

class _myCarScreenState extends State<myCarScreen> {
  final List<Map<String, dynamic>> _car = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292929),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const HomePage()),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "รถของฉัน",
          style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.bold),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("car")
            .where("owner", isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      alignment: Alignment.center,
                      height: 430,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ยังไม่ได้เพิ่มรถ",
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "กรุณาเพิ่มรถของคุณ",
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      nextScreen(context, const addCarScreen());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 480,
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.fromLTRB(35, 10, 10, 10),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Delete!",
                                                style: GoogleFonts.prompt(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            content: Text(
                                                "Are you sure you want to delete this car?",
                                                style: GoogleFonts.prompt(
                                                    fontSize: 16)),
                                            actions: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  FirebaseFirestore.instance
                                                      .collection('car')
                                                      .doc(snapshot
                                                          .data!.docs[index].id)
                                                      .delete();
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const myCarScreen()),
                                                          (route) => false);
                                                },
                                                icon: const Icon(
                                                  Icons.done,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  "assets/images/car.png",
                                  width: 260,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['brand'] +
                                          snapshot.data!.docs[index]['model'],
                                      style: GoogleFonts.prompt(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['carId'],
                                      style: GoogleFonts.prompt(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 24,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['provinces'],
                                      style: GoogleFonts.prompt(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, const addCarScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {},
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
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Container(
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
                  nextScreenReplace(
                      context, const checkScreen(carId: '', car: ''));
                },
                child: Container(
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
                  nextScreenReplace(
                      context, const changeTest(carId: '', car: ''));
                },
                child: Container(
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
                  nextScreenReplace(context, const ProfileScreen());
                },
                child: Container(
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
