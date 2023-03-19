// ignore_for_file: prefer_const_constructors

import 'package:chat_test/pages/auth/register/register.speedy.agreement.dart';
import 'package:chat_test/pages/auth/register/register.speedy.info.dart';
import 'package:chat_test/pages/auth/register/register.speedy.number.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId, required this.phone})
      : super(key: key);
  final String phone;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthService>(context, listen: true).isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreenReplace(context, const RegisterNumber());
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
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: SafeArea(
              child: isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    )
                  : Column(
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
                                  Icon(
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'กรอกรหัส OTP ที่ส่งไปยังหมายเลข ',
                                    style: GoogleFonts.prompt(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  // Text()
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 35),
                        Pinput(
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                            width: 50,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.green.shade800,
                              ),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          onCompleted: (value) {
                            setState(() {
                              otpCode = value;
                            });
                          },
                        ),
                        const SizedBox(height: 35),
                        InkWell(
                          onTap: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterInformation(
                                          phone: widget.phone)));
                            } else {
                              print("Enter 6-Digit code");
                            }
                          },
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
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
                                'ยืนยัน',
                                style: GoogleFonts.prompt(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 350,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                'ส่งรหัส OTP อีกครั้ง',
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
            ),
          ),
        ),
      ),
    );
  }

  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthService>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        ap.checkExistingUser().then((value) async {
          if (value == true) {
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RegisterInformation(phone: widget.phone)),
                (route) => false);
          }
        });
      },
    );
  }
}
