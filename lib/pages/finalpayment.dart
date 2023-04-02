import 'package:chat_test/pages/map.dart';
import 'package:chat_test/pages/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Fpayment extends StatefulWidget {
  const Fpayment({super.key});

  @override
  State<Fpayment> createState() => _FpaymentState();
}

Future<void> _getstatus() async {
  print("earth na heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
  DocumentReference requestDocumentReference =
      await FirebaseFirestore.instance.collection('requests').add({
    'status': 'Wait',
  });
}

class _FpaymentState extends State<Fpayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายการชำระเงิน',
              style: GoogleFonts.prompt(
                  fontSize: 25, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromARGB(255, 31, 31, 31),
          toolbarHeight: 84,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(23.0))),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MapSample()));
              // ฟังก์ชันที่จะทำงานเมื่อกดปุ่มย้อนกลับ
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 31, 31),
        body: Column(children: [
          SizedBox(
            width: 450,
            height: 120,
            child: Center(
              child: Text(
                "CHARGE",
                style: GoogleFonts.prompt(
                    color: const Color.fromARGB(255, 41, 41, 41),
                    fontSize: 80,
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo_long.png',
                              fit: BoxFit.contain,
                              height: 60,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "no.",
                                    style: GoogleFonts.prompt(fontSize: 12),
                                  ),
                                  Text(
                                    "workID",
                                    // snapshot.data!.docs.singleWhere((doc) =>
                                    //     doc.id == widget.workID)['workID'],
                                    style: GoogleFonts.prompt(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 340,
                height: 420,
                decoration: const BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: Color.fromRGBO(17, 53, 102, 1),
                          height: 50,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/payment_logo.png',
                            fit: BoxFit.contain,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "500",
                          style: GoogleFonts.prompt(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '฿',
                          style: GoogleFonts.prompt(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
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
                                    decoration:
                                        BoxDecoration(color: Colors.grey),
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
                        Image.asset(
                          'assets/SpeedyQR.png',
                          fit: BoxFit.contain,
                          height: 180,
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
                                    _getstatus();
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.green),
                                    child: Center(
                                      child: Text(
                                        "ยืนยัน",
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
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
