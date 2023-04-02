import 'package:chat_test/pages/show_profile.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  AuthService authService = AuthService();

  String userName = "";
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
      final firstName = data['firstName'] as String?;
      final lastName = data['lastName'] as String?;
      final showemail = data['email'];
      final showephoneNumber = data['phoneNumber'];
      final showprofilePic = data['profilePic'].toString();
      final showName = '$firstName $lastName';
      setState(() {
        userName = showName;
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
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true, //กลาง
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(23.0))),
        ),
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child:
              Consumer<ProfileController>(builder: (context, Provider, child) {
            return Container(
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
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      profilePic,
                                    ),
                                    fit: BoxFit
                                        .cover //กำหนดให้แสดงคลุมเต็มพื้นที่รูปจะโดน crop ไปบ้าง
                                    ),
                                //image: DecorationImage(
                                //fit: BoxFit
                                //.cover, // กำหนดให้แสดงคลุมเต็มพื้นที่รูปจะโดน crop ไปบ้าง
                                //image:
                                //AssetImage("assets/images/Profile Pic.png"))
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Provider.pickImage(context);
                            },
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          /*Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: Colors.white),
                            color: Colors.black,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))*/
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFD9D9D9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: "Name",
                          labelStyle: GoogleFonts.prompt(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "$userName",
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowProfile()),
                            );
                          },
                          child: Text(
                            "ยืนยัน",
                            style: GoogleFonts.prompt(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF3BB54A)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 150),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}

class ProfileController with ChangeNotifier {
  final picker = ImagePicker();

  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
    ;
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
    }
    ;
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.camera, color: Colors.black),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.image, color: Colors.black),
                    title: Text("Gallery"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
