import 'package:chat_test/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterFinish extends StatefulWidget {
  const RegisterFinish({super.key});

  @override
  State<RegisterFinish> createState() => _RegisterFinishState();
}

class _RegisterFinishState extends State<RegisterFinish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 100,
                width: 450,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 25),
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Login',
                          style: GoogleFonts.prompt(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 75),
                        Text(
                          'Sign Up',
                          style: GoogleFonts.prompt(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 100),
                        const Icon(
                          Icons.public,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
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
              const SizedBox(height: 100),
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.black,
                      size: 150,
                    ),
                    Center(
                      child: Text(
                        'ลงทะเบียนสำเร็จ',
                        style: GoogleFonts.prompt(
                          color: Color.fromARGB(255, 48, 48, 48),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 150),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 55,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Text(
                                'เสร็จสิ้น',
                                style: GoogleFonts.prompt(
                                  color: Colors.white,
                                  fontSize: 16,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
