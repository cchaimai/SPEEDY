import 'dart:io';

import 'package:chat_test/pages/auth/register/register.speedy.finish.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:chat_test/widgets/user.model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:chat_test/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login.social.dart';

class RegisterInformation extends StatefulWidget {
  const RegisterInformation({super.key, required this.phone});
  final String phone;

  @override
  State<RegisterInformation> createState() => _RegisterInformationState();
}

class _RegisterInformationState extends State<RegisterInformation> {
  File? image;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
  }

  //for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthService>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreenReplace(context, const LoginSocial());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          "Sign up",
          style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.language,
              )),
        ],
        toolbarHeight: 80,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            color: Color.fromARGB(255, 31, 31, 31),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 350,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 60,
                                          ),
                                          Text(
                                            'ข้อตกลง',
                                            style: GoogleFonts.prompt(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.horizontal_rule,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 60,
                                          ),
                                          Text(
                                            'ยืนยันตัวตน',
                                            style: GoogleFonts.prompt(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.horizontal_rule,
                                        color: Colors.green,
                                        size: 25,
                                      ),
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 60,
                                          ),
                                          Text(
                                            'กรอกข้อมูล',
                                            style: GoogleFonts.prompt(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Icon(
                                        Icons.horizontal_rule,
                                        color: Colors.grey,
                                        size: 25,
                                      ),
                                      Column(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.grey,
                                            size: 60,
                                          ),
                                          Text(
                                            'สำเร็จ',
                                            style: GoogleFonts.prompt(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () => selectImage(),
                                      child: image == null
                                          ? const CircleAvatar(
                                              backgroundColor: Colors.grey,
                                              radius: 50,
                                              child: Icon(
                                                Icons.account_circle,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundImage:
                                                  FileImage(image!),
                                              radius: 50,
                                            ),
                                    ),
                                    TextButton(
                                      onPressed: () => selectImage(),
                                      child: Text(
                                        'เพิ่มรูปภาพ',
                                        style: GoogleFonts.prompt(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 350,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'ชื่อ',
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            cursorColor: Colors.green,
                                            controller: firstNameController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.prompt(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'First Name',
                                              labelStyle: GoogleFonts.prompt(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey),
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'กรุณากรอกชื่อจริง';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Text(
                                                'นามสกุล',
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            cursorColor: Colors.green,
                                            controller: lastNameController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.prompt(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'Last Name',
                                              labelStyle: GoogleFonts.prompt(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey),
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'กรุณากรอกนามสกุล';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            children: [
                                              Text(
                                                'อีเมล์',
                                                style: GoogleFonts.prompt(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          TextFormField(
                                            cursorColor: Colors.green,
                                            controller: emailController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.prompt(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                              labelText: 'example@gmail.com',
                                              labelStyle: GoogleFonts.prompt(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey),
                                              border:
                                                  const OutlineInputBorder(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              errorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'กรุณากรอกอีเมล์';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    InkWell(
                                      onTap: () => storeData(),
                                      child: Center(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          width: 340,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'ลงทะเบียน',
                                            style: GoogleFonts.prompt(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthService>(context, listen: false);
    List<String> cards = [];
    List<String> events = [];
    List<String> coupon = [];
    UserModel userModel = UserModel(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      profilePic: "",
      uid: "",
      phoneNumber: "",
      chat: "",
      cards: [],
      events: [],
      coupon: [],
    );
    if (image != null && formKey.currentState!.validate()) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) =>
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterFinish()),
                  (route) => false)));
        },
        cards: cards.toList(),
        events: events.toList(),
        coupon: coupon.toList(),
      );
    } else if (image == null) {
      Fluttertoast.showToast(msg: "Please upload your profile photo");
    }
  }
}
