import 'package:chat_test/pages/auth/login.social.dart';
import 'package:chat_test/pages/auth/register/register.speedy.number.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/widgets.dart';
import '../../home_page.dart';

class RegisterAgreement extends StatefulWidget {
  const RegisterAgreement({super.key});

  @override
  State<RegisterAgreement> createState() => _RegisterAgreementState();
}

class _RegisterAgreementState extends State<RegisterAgreement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreenReplace(context, const LoginSocial());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
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
          child: Center(
            child: Column(
              children: [
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'ข้อกำหนดและเงื่อนไข',
                        style: GoogleFonts.prompt(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '1. ความสัมพันธ์ในทางสัญญา',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '2. การให้บริการ',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '3. การใช้บริการของท่าน',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '4. การชำระเงิน',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '5. การกำจัดความรับผิด',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '6. บังคับใช้กฎหมาย',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '7. ข้อกำหนดอื่นๆ',
                        style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 80),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterNumber()));
                            },
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'ยอมรับ',
                                  style: GoogleFonts.prompt(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginSocial(),
                                ),
                              );
                            },
                            child: Center(
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'ยกเลิก',
                                  style: GoogleFonts.prompt(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
