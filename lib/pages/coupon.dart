import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouPon extends StatelessWidget {
  const CouPon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('โค้ดส่วนลด',
            style:
                GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.w500)),
        backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
        toolbarHeight: 84, //ความสูง bar บน
        centerTitle: true, //กลาง
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23.0))),
      ),
    );
  }
}
