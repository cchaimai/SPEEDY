import 'package:chat_test/pages/auth/profile_beam.dart';
import 'package:chat_test/pages/edit_profile.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProfile extends StatefulWidget {
  const ShowProfile({super.key});

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  AuthService authService = AuthService();

  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
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
      final showfirstName = data['firstName'] as String?;
      final showlastName = data['lastName'] as String?;
      final showemail = data['email'];
      final showephoneNumber = data['phoneNumber'];
      final showprofilePic = data['profilePic'].toString();
      final showName = '$firstName $lastName';
      setState(() {
        firstName = showfirstName!;
        lastName = showlastName!;
        email = showemail;
        phoneNumber = showephoneNumber;
        profilePic = showprofilePic;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขโปรไฟล์',
            style:
                GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        toolbarHeight: 84, //ความสูง bar บน
        centerTitle: true, //กลาง
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 15, top: 20, right: 15), //กำหนดค่าแต่ละด้าน
        child: GestureDetector(
          onTap: () {
            //การคลิ๊กบน ListView หรือ CheckBox
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                  profilePic,
                                ),
                                fit: BoxFit
                                    .cover //กำหนดให้แสดงคลุมเต็มพื้นที่รูปจะโดน crop ไปบ้าง
                                )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "First Name",
                    labelStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: firstName,
                    hintStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989898)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Last Name",
                    labelStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: lastName,
                    hintStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989898)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "เบอร์โทรศัพท์",
                    labelStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: phoneNumber,
                    hintStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989898)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Email",
                    labelStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: email,
                    hintStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989898)),
                    ),
                  ),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  obscureText: isPasswordTextField ? showPassword : false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFD9D9D9),
                    suffixIcon: isPasswordTextField
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "รหัสผ่าน",
                    labelStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "********",
                    hintStyle: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF989898)),
                    ),
                  ),
                ),
              ),*/
              const SizedBox(height: 30),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    child: Text(
                      "แก้ไข",
                      style: GoogleFonts.prompt(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF3BB54A)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 155),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()),
                      );
                    },
                    child: Text(
                      "ยกเลิก",
                      style: GoogleFonts.prompt(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFFF0000)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 150),
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
