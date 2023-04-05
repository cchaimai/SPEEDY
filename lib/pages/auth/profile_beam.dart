import 'package:chat_test/pages/auth/login.social.dart';
import 'package:chat_test/pages/bank_page.dart';
import 'package:chat_test/pages/help_center.dart';
import 'package:chat_test/pages/mycoupon.dart';
import 'package:chat_test/pages/show_profile.dart';

import 'package:chat_test/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../service/auth_service.dart';
import '../home_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  AuthService authService = AuthService();
  final FirebaseStorage storage = FirebaseStorage.instance;

  String userName = "";
  String profilePic = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('mUsers').doc(uid);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data()!;
      final firstName = data['firstName'] as String?;
      final lastName = data['lastName'] as String?;
      final showprofilePic = data['profilePic'].toString();
      final showName = '$firstName $lastName';
      setState(() {
        userName = showName;
        profilePic = showprofilePic;
      });
    }
  }

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
          leading: IconButton(
              onPressed: () {
                nextScreenReplace(context, const HomePage());
              },
              icon: const Icon(Icons.home)),
          actions: <Widget>[
            //แจ้งเตือน
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            //รูปภาพโปรไฟล์และชื่อ
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(left: 30, right: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            profilePic,
                          ),
                          fit: BoxFit.cover)),
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    // ignore: unnecessary_string_interpolations
                    Text("$userName",
                        style: GoogleFonts.prompt(
                            fontSize: 20, color: Colors.black))
                  ],
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowProfile()),
                    );
                  },
                  child: const Icon(
                    Icons.navigate_next_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            //บัญชีธนาคาร
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.prompt(color: Colors.black),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.prompt(color: Colors.black),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CouPonScreen()),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyCoupon()),
                  );
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.prompt(color: Colors.black),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpCenter()),
                  );
                },
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.help_outline,
                        size: 22,
                        color: Colors.black,
                      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: GoogleFonts.prompt(color: Colors.black),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {},
                child: GestureDetector(
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
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
                                  await authService.signOut();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginSocial()),
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
            ),
          ],
        ));
  }
}
