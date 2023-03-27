import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'home_page.dart';
import 'dart:developer';

class cancelChange extends StatefulWidget {
  final String eventsId;
  final String model;
  final String carId;
  final String date;
  final String time;
  final String type;
  const cancelChange(
      {super.key,
      required this.eventsId,
      required this.model,
      required this.carId,
      required this.date,
      required this.time,
      required this.type});

  @override
  State<cancelChange> createState() => _cancelChangeState();
}

// ignore: camel_case_types
class _cancelChangeState extends State<cancelChange> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool _deleteDate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const HomePage()),
          icon: const Icon(
            Icons.home_outlined,
            size: 35,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "คิว",
          style: GoogleFonts.prompt(fontSize: 26, fontWeight: FontWeight.bold),
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
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: Column(children: [
        SizedBox(
          width: 500,
          height: 200,
          child: Center(
            child: Text(
              "CHECK",
              style: GoogleFonts.prompt(
                  color: const Color.fromARGB(255, 41, 41, 41),
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 187, 186, 186),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/logo_long.png',
                        fit: BoxFit.contain,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 340,
              height: 310,
              decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Icon(
                    Icons.battery_charging_full_rounded,
                    color: Colors.red,
                    size: 45,
                  ),
                ),
                Text(
                  "ยกเลิกเสร็จสิ้น",
                  style: GoogleFonts.prompt(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.model,
                  style: GoogleFonts.prompt(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.carId,
                  style: GoogleFonts.prompt(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 30,
                      width: 15,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Color.fromARGB(255, 41, 41, 41),
                        ),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            (constraints.constrainWidth() / 10).floor(),
                            (index) => const SizedBox(
                              height: 1,
                              width: 5,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 30,
                      width: 15,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: Color(0xff292929),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text(
                              widget.date,
                              style: GoogleFonts.prompt(),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text(widget.time, style: GoogleFonts.prompt())
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text(
                              widget.type,
                              style: GoogleFonts.prompt(),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                delete();
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 41, 41, 41)),
                                child: Center(
                                  child: Text(
                                    "หน้าหลัก",
                                    style: GoogleFonts.prompt(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
            )
          ],
        )
      ]),
    );
  }

  delete() async {
    DocumentReference dateDocRef =
        FirebaseFirestore.instance.collection('events').doc(widget.eventsId);
    DocumentSnapshot dateDocSnapshot = await dateDocRef.get();
    String dateId = dateDocSnapshot.get('date');

    FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventsId)
        .delete();
    FirebaseFirestore.instance.collection('mUsers').doc(userId).update({
      'events': FieldValue.arrayRemove([widget.eventsId])
    });
    FirebaseFirestore.instance.collection('date').doc(dateId).update({
      'time': FieldValue.arrayRemove([widget.eventsId])
    });
    nextScreenReplace(context, HomePage());
  }
}
