import 'package:chat_test/pages/auth/profile_beam.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class queueScreen extends StatefulWidget {
  final String eventsId;
  final String model;
  final String carId;
  final String date;
  final String time;
  final String type;
  const queueScreen(
      {super.key,
      required this.eventsId,
      required this.model,
      required this.carId,
      required this.date,
      required this.time,
      required this.type});

  @override
  State<queueScreen> createState() => _queueScreenState();
}

class _queueScreenState extends State<queueScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292929),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const ProfileScreen()),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "การจองคิว",
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
            .collection("events")
            .where("owner", isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 800,
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: ((context, setState) {
                                            return AlertDialog(
                                              title: Text(
                                                "ยกเลิกการจองคิว",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.prompt(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        delete(snapshot.data!
                                                            .docs[index].id);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      child: Text(
                                                        "ยืนยัน",
                                                        style: GoogleFonts
                                                            .prompt(),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 40,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      child: Text(
                                                        "ยกเลิก",
                                                        style: GoogleFonts
                                                            .prompt(),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, top: 10),
                                          child: Icon(
                                            Icons.list_alt,
                                            color: Colors.black,
                                            size: 35,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]['type'],
                                          style: GoogleFonts.prompt(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24,
                                              color: Colors.black),
                                        ),
                                        const Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ('วัน/เวลา : ') +
                                            snapshot.data!.docs[index]['date'] +
                                            (' / ') +
                                            snapshot.data!.docs[index]['time'] +
                                            ('น.'),
                                        style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        ('รถ : ') +
                                            snapshot.data!.docs[index]['model'],
                                        style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        ('ทะเบียน : ') +
                                            snapshot.data!.docs[index]['carId'],
                                        style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        ('สถานะ : ') +
                                            snapshot.data!.docs[index]
                                                ['status'],
                                        style: GoogleFonts.prompt(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  delete(String uid) async {
    DocumentReference dateDocRef =
        FirebaseFirestore.instance.collection('events').doc(uid);
    DocumentSnapshot dateDocSnapshot = await dateDocRef.get();
    String dateId = dateDocSnapshot.get('date');
    String timeId = dateDocSnapshot.get('time');

    FirebaseFirestore.instance.collection('events').doc(uid).delete();
    FirebaseFirestore.instance.collection('mUsers').doc(userId).update({
      'events': FieldValue.arrayRemove([uid])
    });

    print(uid);
    FirebaseFirestore.instance.collection('date').doc(dateId).update({
      timeId: FieldValue.arrayRemove([uid])
    });
    FirebaseFirestore.instance.collection('events').doc(uid).delete();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const queueScreen(
                  eventsId: '',
                  carId: '',
                  date: '',
                  model: '',
                  time: '',
                  type: '',
                )),
        (route) => false);
  }
}
