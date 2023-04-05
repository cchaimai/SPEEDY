import 'package:chat_test/pages/map.dart';
import 'package:chat_test/pages/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'addcar.dart';
import 'auth/profile_beam.dart';
import 'change_test.dart';
import 'check_main.dart';
import 'home_page.dart';
import 'mycar.dart';

class ChargeDetail extends StatefulWidget {
  const ChargeDetail({
    super.key,
    required this.ID,
  });
  final String ID;
  @override
  State<ChargeDetail> createState() => _ChargeDetailState();
}

final energyController = TextEditingController();
num? energy;
num? price;

Future<void> _getchargedetail(String cartype, String UcarID, String chargetype,
    String province, String ID) async {
  energy = num.parse(energyController.text);
  price = 10 * energy!;

  await FirebaseFirestore.instance.collection('requests').doc(ID).set({
    'chargetype': chargetype,
    'energy': energyController.text,
    'price': price,
    'cartype': cartype,
    'UcarID': UcarID,
    'province': province,
  }, SetOptions(merge: true));
}

class _ChargeDetailState extends State<ChargeDetail> {
  final List<Map<String, dynamic>> _car = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff292929),
      appBar: AppBar(
        title: Text('Charge',
            style:
                GoogleFonts.prompt(fontSize: 25, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
        toolbarHeight: 84,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
            // ฟังก์ชันที่จะทำงานเมื่อกดปุ่มย้อนกลับ
          },
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
                      height: 490,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "ยังไม่ได้เพิ่มรถ\nกรุณาเพิ่มรถของคุณ",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
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
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SizedBox(
                  height: 490,
                  child: ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/images/car.png",
                                    width: 260,
                                  ),
                                ],
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
                                            fontSize: 20,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 25),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      child: TextFormField(
                                        controller: energyController,
                                        cursorColor: Colors.green,
                                        decoration: InputDecoration(
                                          hintText:
                                              "${snapshot.data!.docs[index]['battery']}",
                                          hintStyle: GoogleFonts.prompt(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                          labelText:
                                              "โปรดกรอกพลังงานที่ต้องการเติม (kWh)",
                                          labelStyle: GoogleFonts.prompt(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                          border: const OutlineInputBorder(),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 6,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff3BB54A),
                                            fixedSize: const Size(70, 35),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  backgroundColor: Colors.black,
                                                  title: Center(
                                                    child: Text(
                                                      'คุณต้องการเติม ${energyController.text} kWh?',
                                                      style: GoogleFonts.prompt(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            _getchargedetail(
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'brand'],
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'carId'],
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'chargeType'],
                                                                    snapshot.data!
                                                                            .docs[index]
                                                                        [
                                                                        'provinces'],
                                                                    widget.ID)
                                                                .then((value) =>
                                                                    nextScreen(
                                                                        context,
                                                                        Payment(
                                                                          price:
                                                                              price.toString(),
                                                                          ID: widget
                                                                              .ID,
                                                                          dis:
                                                                              0,
                                                                          couponID:
                                                                              '',
                                                                        )));
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xff3BB54A),
                                                            fixedSize:
                                                                const Size(
                                                                    100, 30),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                          child: Text(
                                                            "ยืนยัน",
                                                            style: GoogleFonts
                                                                .prompt(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            fixedSize:
                                                                const Size(
                                                                    100, 30),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                          ),
                                                          child: Text(
                                                            "ยกเลิก",
                                                            style: GoogleFonts
                                                                .prompt(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'ยืนยัน',
                                            style: GoogleFonts.prompt(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     nextScreenReplace(context, const addCarScreen());
                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 50,
                //     width: 200,
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     child: Text(
                //       'ยืนยัน',
                //       style: GoogleFonts.prompt(
                //           fontWeight: FontWeight.w400,
                //           fontSize: 16,
                //           color: Colors.black),
                //     ),
                //   ),
                // ),
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
