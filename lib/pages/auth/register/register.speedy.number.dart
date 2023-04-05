import 'package:chat_test/pages/auth/register/register.speedy.agreement.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/widgets.dart';
import '../login.social.dart';

class RegisterNumber extends StatefulWidget {
  const RegisterNumber({super.key});

  @override
  State<RegisterNumber> createState() => _RegisterNumberState();
}

class _RegisterNumberState extends State<RegisterNumber> {
  final TextEditingController phoneController = TextEditingController();

  Country country = Country(
    phoneCode: "66",
    countryCode: "TH",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Thailand",
    example: "Thailand",
    displayName: "Thailand",
    displayNameNoCountryCode: "TH",
    e164Key: "",
  );

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreenReplace(context, const RegisterAgreement());
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ยืนยันหมายเลขโทรศัพท์',
                          style: GoogleFonts.prompt(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'เพื่อความปลอดภัยของบัญชีของคุณ เราจำเป็นต้องให้คุณยืนยันตัวตน กรุณากรอกหมายเลขโทรศัพท์มือถือ เราจะส่งรหัสผ่านแบบครั้งเดียว (OTP) ไปยังหมายเลขโทรศัพท์มือถือของคุณ',
                          style: GoogleFonts.prompt(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            setState(() {
                              phoneController.text = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your phone number',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {
                                  showCountryPicker(
                                    context: context,
                                    countryListTheme:
                                        const CountryListThemeData(
                                            bottomSheetHeight: 600),
                                    showPhoneCode: true,
                                    onSelect: (Country country) {
                                      setState(
                                        () {
                                          this.country = country;
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  '${country.flagEmoji} +${country.phoneCode}', // Display country flag
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: phoneController.text.length > 9
                                ? Container(
                                    height: 15,
                                    width: 15,
                                    margin: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 45),
                        InkWell(
                          onTap: () {
                            String phoneNumber = phoneController.text.trim();
                            if (phoneNumber.length < 10) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        "กรุณากรอกเบอร์ให้ถูกต้อง",
                                        style: GoogleFonts.prompt(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      Center(
                                        child: TextButton(
                                          child: Text(
                                            "ตกลง",
                                            style: GoogleFonts.prompt(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            } else if (phoneNumber.length >= 10) {
                              sendPhoneNumber();
                            }
                          },
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                'ส่งรหัส OTP',
                                style: GoogleFonts.prompt(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber() async {
    final ap = Provider.of<AuthService>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }

    bool isUsed = await ap.isPhoneUsed("+${country.phoneCode}$phoneNumber");
    if (isUsed) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "เบอร์โทรศัพท์นี้เคยใช้งานไปแล้ว",
              style: GoogleFonts.prompt(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Text(
              "กรุณาเปลี่ยนเบอร์โทรศัพท์ของคุณ",
              style: GoogleFonts.prompt(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            actions: [
              Center(
                child: TextButton(
                  child: Text(
                    "ตกลง",
                    style: GoogleFonts.prompt(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        },
      );
    } else {
      ap.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
    }
  }
}
