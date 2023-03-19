import 'dart:io';

import 'package:chat_test/pages/auth/register/register.speedy.finish.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:chat_test/widgets/user.model.dart';
import 'package:flutter/material.dart';
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
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
      body: SafeArea(
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
                                            backgroundImage: FileImage(image!),
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
                                        textFeld(
                                          hintText: "First Name",
                                          icon: Icons.account_circle_outlined,
                                          inputType: TextInputType.name,
                                          maxLines: 1,
                                          controller: fnameController,
                                        ),
                                        textFeld(
                                          hintText: "Last Name",
                                          icon: Icons.account_circle_outlined,
                                          inputType: TextInputType.name,
                                          maxLines: 1,
                                          controller: lnameController,
                                        ),
                                        textFeld(
                                            hintText: "abc@mail.com",
                                            icon: Icons.email_outlined,
                                            inputType: TextInputType.name,
                                            maxLines: 1,
                                            controller: emailController),
                                        textFeld(
                                            hintText: "Passwrd",
                                            icon: Icons.password_outlined,
                                            inputType: TextInputType.name,
                                            maxLines: 1,
                                            controller: passwordController),
                                        textFeld(
                                            hintText: "Confirm Passwrd",
                                            icon: Icons.password_outlined,
                                            inputType: TextInputType.name,
                                            maxLines: 1,
                                            controller: passwordController),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
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
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          'ลงทะเบียน',
                                          style: GoogleFonts.prompt(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        cursorColor: Colors.green,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthService>(context, listen: false);
    UserModel userModel = UserModel(
      fisrtName: fnameController.text.trim(),
      lastName: lnameController.text.trim(),
      email: emailController.text.trim(),
      profilePic: "",
      uid: "",
      phoneNumber: "",
      createAt: "",
    );
    if (image != null) {
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
          });
    } else {
      print("Please upload your profile photo");
    }
  }
}
