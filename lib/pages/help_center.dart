import 'package:chat_test/pages/auth/profile_beam.dart';
import 'package:chat_test/service/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ศูนย์ช่วยเหลือ',
            style:
                GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        toolbarHeight: 84, //ความสูง bar บน
        centerTitle: true, //กลาง
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),

        actions: <Widget>[
          //แจ้งเตือน
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 25, top: 35, right: 25), //กำหนดค่าแต่ละด้าน
        child: GestureDetector(
          onTap: () {
            //การคลิ๊กบน ListView หรือ CheckBox
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              //กล่องสีดำ มีประโยชน์กับคุณมากที่สุด
              Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                    width: 380,
                    height: 396,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40)),
                        color: Color.fromRGBO(31, 31, 31, 1)),
                  )),
                  //มีประโยชน์กับคุณมากที่สุด
                  Positioned(
                      top: 31,
                      left: 12,
                      child: Text("มีประโยชน์กับคุณมากที่สุด",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.bold,
                              height: 1))),
                  //รายงานอุบัติเหตุและความปลอดภัย
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 80, right: 25),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        fixedSize: const Size(130, 130),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Accident()),
                        );
                      },
                      child: Text("รายงานอุบัติเหตุและความปลอดภัย",
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //ข้อเสนอถึงผู้ให้บริการ
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 190, top: 80, right: 25),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        fixedSize: const Size(130, 130),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Offer()),
                        );
                      },
                      child: Text("ข้อเสนอถึงผู้ให้บริการ",
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //ปัญหาแผนที่/ตำแหน่งที่ตั้ง
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 230, right: 25),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        fixedSize: const Size(130, 130),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Problem()),
                        );
                      },
                      child: Text("ปัญหาแผนที่/ตำแหน่งที่ตั้ง",
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //หัวข้ออื่นๆ
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 190, top: 230, right: 25),
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        fixedSize: const Size(130, 130),
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Other()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Icon(Icons.help),
                          Text("หัวข้ออื่นๆ",
                              style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //ความช่วยเหลือเร่งด่วน
              Center(
                child: Column(children: <Widget>[
                  const SizedBox(height: 20),
                  Container(
                    height: 43,
                    width: 222,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFFC700), width: 3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dangerous_rounded, color: Color(0xFFFFC700)),
                        SizedBox(width: 8),
                        Text(
                          "ความช่วยเหลือเร่งด่วน",
                          style:
                              GoogleFonts.prompt(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.dangerous_rounded, color: Color(0xFFFFC700)),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "ต้องการความช่วยเหลือเพิ่มเติม",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: " ติดต่อเรา",
                        style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3BB54A),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'ช่องทางการติดต่อ',
                                          style: GoogleFonts.prompt(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text('เบอร์โทรติดต่อ : 0816290242',
                                            style: GoogleFonts.prompt(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                      ),
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

class Accident extends StatelessWidget {
  const Accident({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ศูนย์ช่วยเหลือ',
            style:
                GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        toolbarHeight: 84, //ความสูง bar บน
        centerTitle: true, //กลาง
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),
        actions: <Widget>[
          //แจ้งเตือน
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 25, top: 35, right: 25), //กำหนดค่าแต่ละด้าน
        child: GestureDetector(
          onTap: () {
            //การคลิ๊กบน ListView หรือ CheckBox
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "รายงานอุบัติเหตุและการทุจริต",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "ปุ่มฉุกเฉิน",
                          style: GoogleFonts.prompt(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF626262)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "ฉันได้รับการแจ้งเตือนเหตุฉุกเฉิน",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "ทำอย่างไรเมื่อรู้สึกไม่ปลอดภัย",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "ทำไมฉันได้รับแต้งเตือนหยุดกลางคัน",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "นโยบายความปลอดภัย",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "ศูนย์ความปลอยภัยคืออะไร",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "รายชื่อผู้ติดต่อฉุกเฉินคืออะไร",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "วิธีการแชร์เที่ยวการเดินทาง",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "ฟีเจอร์ปกปิดเบอร์โทรศัพท์ คืออะไร",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "การอัปเดตเกี่ยวกับโควิด-19",
                          style: GoogleFonts.prompt(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF626262)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "แนวทางและวิธีการป้องกันไวรัสโควิด-19",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "รายงานอุบัติเหตุ",
                          style: GoogleFonts.prompt(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF626262)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "รายงานอุบัติเหตุและกรณีฉุกเฉิน",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  final wordController = TextEditingController();
  final emailController = TextEditingController();

  Future<void> _getOffer() async {
    DocumentReference requestDocumentReference =
        await FirebaseFirestore.instance.collection('help').add({
      'Uword': wordController.text,
      'Uemail': uemail,
      'type': 'user',
    });
  }

  final userId = FirebaseAuth.instance.currentUser!.uid;
  String uemail = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('mUsers').doc(userId);

    DocumentSnapshot userDocSnapshot = await userDocRef.get();
    uemail = userDocSnapshot.get('email');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ศูนย์ช่วยเหลือ',
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true, //กลาง
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(23.0))),
          actions: <Widget>[
            //แจ้งเตือน
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
            padding: const EdgeInsets.only(
                left: 25, top: 10, right: 25), //กำหนดค่าแต่ละด้าน
            child: GestureDetector(
                onTap: () {
                  //การคลิ๊กบน ListView หรือ CheckBox
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Row(
                            children: [
                              Text(
                                "ข้อเสนอถึงผู้ให้บริการ",
                                style: GoogleFonts.prompt(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: TextField(
                            controller: wordController,
                            maxLines: null,
                            minLines: 1,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFFD9D9D9),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 90),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              hintText: "เขียนข้อเสนอของคุณที่นี้",
                              hintStyle: GoogleFonts.prompt(
                                fontSize: 16,
                                color: const Color(0xFF989898),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await _getOffer();
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  'ส่งคำร้องสำเร็จ',
                                  style: GoogleFonts.prompt(),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigate back to HelpCenter page
                                      Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HelpCenter()),
                                      );
                                    },
                                    child: Text(
                                      'ตกลง',
                                      style: GoogleFonts.prompt(),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF3BB54A),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF3BB54A),
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text("ส่ง",
                              style: GoogleFonts.prompt(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ))));
  }
}

class Problem extends StatelessWidget {
  const Problem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ศูนย์ช่วยเหลือ',
            style:
                GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        toolbarHeight: 84, //ความสูง bar บน
        centerTitle: true, //กลาง
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),
        actions: <Widget>[
          //แจ้งเตือน
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 25, top: 35, right: 25), //กำหนดค่าแต่ละด้าน
        child: GestureDetector(
          onTap: () {
            //การคลิ๊กบน ListView หรือ CheckBox
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "ปัญญาแผนที่/ตำแหน่งที่ตั้ง",
                          style: GoogleFonts.prompt(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "ปัญญาทางเนคนิค",
                          style: GoogleFonts.prompt(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF626262)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "วิธีรายงานปัญญาผ่านศูนย์ช่วยเหลือ",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "แอปพลิเคชั่น SPEEDY Driver มีปัญหา",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "วิธีสำรองข้อมูลและเรียกคืนข้อมูลโทรศัพท์",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Row(
                      children: [
                        Text(
                          "รายงานปัญหาเกี่ยวกับแผนที่ และสถานที่",
                          style: GoogleFonts.prompt(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF626262)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "รายงานปัญหาเกี่ยวกับสถานที่",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "รายงานปัญหาแผนที่และการนำทางหน้าแอป",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF25ABD1)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Other extends StatelessWidget {
  const Other({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ศูนย์ช่วยเหลือ',
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true, //กลาง
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(23.0))),
          actions: <Widget>[
            //แจ้งเตือน
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Stack(children: <Widget>[
            Positioned(
                top: 40,
                left: 30,
                child: Text("หัวข้ออื่นๆ",
                    style: GoogleFonts.prompt(
                        fontSize: 20, fontWeight: FontWeight.bold))),
          ]),
        ));
  }
}
