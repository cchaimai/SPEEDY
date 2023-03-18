import 'package:chat_test/pages/bank_page.dart';
import 'package:chat_test/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helper/helper_function.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile',
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
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const NoificaTion()),
                // );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            //รูปภาพโปรไฟล์และชื่อ
            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: AssetImage("assets/images/Profile Pic.png"))
                  ),
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("โอ เฉย",
                        style: GoogleFonts.prompt(
                            fontSize: 20, color: Colors.black))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 115, top: 10, right: 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255)),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => EditProfile()),
                      // );
                    },
                    child: const Icon(
                      Icons.navigate_next_rounded,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            //บัญชีธนาคาร
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: GoogleFonts.prompt(color: Colors.black),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFF5F6F9)),
                onPressed: () {
                  nextScreenReplace(
                      context,
                      BankPage(
                        userId: userId,
                      ));
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.account_balance_rounded,
                      size: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                        child: Text(
                      "บัญชีธนาคาร",
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
              ),
            ),
            //โค้ดส่วนลด
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: GoogleFonts.prompt(color: Colors.black),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFF5F6F9)),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const CouPon()),
                  // );
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.discount,
                      size: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                        child: Text(
                      "โค้ดส่วนลด",
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
              ),
            ),
            //ศูนย์ช่วยเหลือ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: GoogleFonts.prompt(color: Colors.black),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFF5F6F9)),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HelpCenter()),
                  // );
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.help_outline,
                      size: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                        child: Text(
                      "ศูนย์ช่วยเหลือ",
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
              ),
            ),
            //Log Out
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: GoogleFonts.prompt(color: Colors.black),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color(0xFFF5F6F9)),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LogOut()),
                  // );
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      size: 22,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                        child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.black),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
