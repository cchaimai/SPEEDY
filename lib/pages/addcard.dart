import 'package:chat_test/pages/bank_page.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/helper_function.dart';
import '../service/database_service.dart';
import 'home_page.dart';
import '../widgets/widgets.dart';

class AddCard extends StatefulWidget {
  final String userId;
  const AddCard({super.key, required this.userId});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  String userName = "";
  String email = "";

  String _fname = '';
  String _lname = '';
  String _cardNum = '';
  String _valid = '';
  String _cvv = '';

  final userId = FirebaseAuth.instance.currentUser!.uid;
  AuthService authService = AuthService();
  Stream? cards;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    //gettingUserData();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _cardCollection =
      FirebaseFirestore.instance.collection("cards");

  // gettingUserData() async {
  //   await HelperFunction.getUserEmailFromSF().then((value) {
  //     setState(() {
  //       email = value!;
  //     });
  //   });
  //   await HelperFunction.getUserNameFromSF().then((val) {
  //     setState(() {
  //       userName = val!;
  //     });
  //   });
  //   // getting the list of snapshots in our stream
  //   await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //       .getUserGroups()
  //       .then((snapshot) {
  //     setState(() {
  //       cards = snapshot;
  //     });
  //   });
  // }

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
          child: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      nextScreenReplace(
                          context,
                          const BankPage(
                            userId: '',
                          ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(30, 20, 10, 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Text("เพิ่มบัตร",
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 10, 10),
                      child: Text(
                        "ชื่อบนบัตร",
                        style: GoogleFonts.prompt(
                            fontSize: 18,
                            color: const Color.fromRGBO(152, 152, 152, 1)),
                      )),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(40, 50, 10, 10),
                    ),
                    SizedBox(
                        width: 135,
                        child: TextFormField(
                          onSaved: (val) {
                            _fname = val!;
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "name cannot be empty";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "ชื่อจริง",
                            hintStyle:
                                GoogleFonts.prompt(color: Colors.grey.shade400),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                          ),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                        width: 135,
                        child: TextFormField(
                          onSaved: (val) {
                            _lname = val!;
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "lastname cannot be empty";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "นามสกุล",
                            hintStyle:
                                GoogleFonts.prompt(color: Colors.grey.shade400),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                          ),
                        )),
                  ],
                )
              ]),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(50, 20, 10, 10),
                      child: Text(
                        "หมายเลขบัตร",
                        style: GoogleFonts.prompt(
                            fontSize: 18,
                            color: const Color.fromRGBO(152, 152, 152, 1)),
                      )),
                ],
              ),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    onSaved: (val) {
                      _cardNum = val!;
                    },
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      } else {
                        return "card number cannot be empty";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "หมายเลขบนบัตร",
                      hintStyle:
                          GoogleFonts.prompt(color: Colors.grey.shade400),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  )),
              Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(40, 50, 10, 10),
                        ),
                        Text(
                          "วันหมดอายุ (ดด/ปป)",
                          style: GoogleFonts.prompt(
                              fontSize: 18,
                              color: const Color.fromRGBO(152, 152, 152, 1)),
                        ),
                        const SizedBox(
                          width: 35,
                        ),
                        Text(
                          "CVV",
                          style: GoogleFonts.prompt(
                              fontSize: 18,
                              color: const Color.fromRGBO(152, 152, 152, 1)),
                        )
                      ],
                    )
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(40, 50, 10, 10),
                        ),
                        SizedBox(
                            width: 170,
                            child: TextFormField(
                              onSaved: (val) {
                                _valid = val!;
                              },
                              decoration: InputDecoration(
                                hintText: "ดด/ปป",
                                hintStyle: GoogleFonts.prompt(
                                    color: Colors.grey.shade400),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            )),
                        const SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                            width: 100,
                            child: TextFormField(
                              onSaved: (val) {
                                _cvv = val!;
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "cannot be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "cvv",
                                hintStyle: GoogleFonts.prompt(
                                    color: Colors.grey.shade400),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green)),
                              ),
                            )),
                      ],
                    )
                  ]),
                ],
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25),
                  ),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: Text(
                      "ระบบจะมีการหักเงินจากบัตรของคุณเป็นจำนวน 5 บาทเพื่อเป็นการยืนยันตัวตนของคุณโดยคุณจะได้รับเงินจำนวนนี้คืนภายใน 14 วัน",
                      style: GoogleFonts.prompt(
                          color: const Color.fromRGBO(152, 152, 152, 1),
                          fontSize: 14),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      height: 70,
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          "ยืนยัน",
                          style: GoogleFonts.prompt(
                              color: Colors.white, fontSize: 20),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      formkey.currentState!.save();
      await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
          .createCard("$_fname $_lname", FirebaseAuth.instance.currentUser!.uid,
              _cardNum, _fname, _lname, _valid, _cvv)
          .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
        showSnackbar(context, Colors.green, "Card created successfully.");
        nextScreenReplace(
            context,
            BankPage(
              userId: userId,
            ));
      });
    }
  }
}
