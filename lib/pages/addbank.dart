import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'home_page.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                nextScreenReplace(context, const HomePage());
              },
              icon: const Icon(Icons.home)),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.green,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("เพิ่มบัญชีธนาคาร",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 10, 10),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/K-bank.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารกสิกรไทย",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/SCB.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารไทยพาณิชย์",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/krungthai.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารกรุงไทย",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/krungthep.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารกรุงเทพ",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/krungsri.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารกรุงศรีอยุธยา",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset("assets/Aomsin.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารออมสิน",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 5, 5),
                      child: SizedBox(
                          height: 40,
                          width: 60,
                          child: Image.asset("assets/ttb.png")),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "ธนาคารทีเอมบีธนชาต",
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
