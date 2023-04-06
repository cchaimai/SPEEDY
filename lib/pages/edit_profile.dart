import 'dart:io';

import 'package:chat_test/pages/show_profile.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:chat_test/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
      setState(() {
        firstName = showfirstName!;
        lastName = showlastName!;
        email = showemail;
        phoneNumber = showephoneNumber;
        profilePic = showprofilePic;
        firstnameController.text = showfirstName;
        lastnameController.text = showlastName;
        emailController.text = showemail;
        phoneController.text = showephoneNumber;
      });
    }
  }

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void updateProfile(String newfirstName, String newlastName, String newEmail,
      String newphoneNumber) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('mUsers').doc(userId).update({
      'firstName': newfirstName,
      'lastName': newlastName,
      'email': newEmail,
      "phoneNumber": newphoneNumber
    });
  }

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final picker = ImagePicker();
  File? _imageFile;
  String? _imageUrl;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _uploadImage(File file) async {
    User user = FirebaseAuth.instance.currentUser!;
    String _uid = user.uid;
    final Reference storageRef =
        FirebaseStorage.instance.ref().child(DateTime.now().toString());
    final UploadTask uploadTask = storageRef.putFile(file);
    final TaskSnapshot downloadUrl = await uploadTask;
    final String url = await downloadUrl.ref.getDownloadURL();

    setState(() {
      _imageUrl = url;
      print('upload success');
    });
    final String driverCardUrl =
        await storeFileDataToStorage("profilePic/$_uid", file);

    await FirebaseFirestore.instance.collection('mUsers').doc(_uid).set(
        {
          'profilePic': driverCardUrl,
        },
        SetOptions(
            merge:
                true)); // ใช้ SetOptions(merge: true) เพื่อไม่ลบฟิลด์ที่มีอยู่แล้วในเอกสาร
  }

  Future<String> storeFileDataToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แก้ไขโปรไฟล์',
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true, //กลาง
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(23.0))),
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
                                ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final pickedFile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _imageFile = File(pickedFile.path);
                              _uploadImage(
                                  _imageFile!); // กำหนดค่าให้กับ _imageFile
                            });
                          }
                        },
                        child: const CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: firstnameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: "First Name",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: firstName,
                      hintStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
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
                    controller: lastnameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: "Last Name",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: lastName,
                      hintStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: "เบอร์โทรศัพท์",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: phoneNumber,
                      hintStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
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
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: "Email",
                      labelStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: email,
                      hintStyle: GoogleFonts.prompt(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF989898)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateProfile(
                          firstnameController.text,
                          lastnameController.text,
                          emailController.text,
                          phoneController.text,
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowProfile()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF3BB54A)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(horizontal: 150),
                        ),
                      ),
                      child: Text(
                        "ยืนยัน",
                        style: GoogleFonts.prompt(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
