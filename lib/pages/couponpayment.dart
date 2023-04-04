import 'package:chat_test/pages/auth/profile_beam.dart';
import 'package:chat_test/pages/payment.dart';
import 'package:chat_test/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Couponpayment extends StatefulWidget {
  const Couponpayment({super.key, required this.price, required this.ID});
  final String price;
  final String ID;
  @override
  State<Couponpayment> createState() => _CouponpaymentState();
}

class _CouponpaymentState extends State<Couponpayment> {
  @override
  final List<Map<String, dynamic>> coupon = [];
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("mUsers");
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final textController = TextEditingController();

  Future<void> fetchUserCoupon() async {
    // Get the current user's data
    final userRef = FirebaseFirestore.instance.collection('mUsers').doc(uid);
    final userData = await userRef.get();

    // Get the array of card document names from the user's data
    final couponIds = userData.get('coupon') as List<dynamic>;

    // Loop through each card ID and fetch the corresponding card document
    for (final couponId in couponIds) {
      final couponRef =
          FirebaseFirestore.instance.collection('coupon').doc(couponId);

      // Check if the card document exists before fetching the data
      final couponData = await couponRef.get();
      if (couponData.exists) {
        setState(() {
          coupon.add(couponData.data()!);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserCoupon();
  }

  String totalprice = '';

  Future<void> discount(num dis) async {
    if (dis >= 1) {
      totalprice = (num.parse(widget.price) - dis).toString();
    } else {
      totalprice = (num.parse(widget.price) - (num.parse(widget.price) * dis))
          .toStringAsFixed(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('โค้ดส่วนลด',
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.confirmation_num_outlined),
              onPressed: () {
                CouPon(context);
              },
            ),
          ], //กลาง
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
            decoration: BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
            child: Stack(children: <Widget>[
              Positioned(
                  child: Container(
                width: 411,
                height: 411,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(31, 31, 31, 1),
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(411, 411))),
              )),
              Positioned(
                  top: 451,
                  left: 30,
                  child: Container(
                    width: 500,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(31, 31, 31, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(500, 500))),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Coupon ',
                        style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: coupon.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            height: 100,
                            margin: const EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text("1x"),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                    child: coupon[index]['dis'] >= 1
                                        ? Text(
                                            coupon[index]['dis'].toString(),
                                            style: GoogleFonts.prompt(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        : Text(
                                            '${(coupon[index]['dis'] * 100).toStringAsFixed(0)}%',
                                            style: GoogleFonts.prompt(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                TextButton(
                                  onPressed: () {
                                    nextScreenReplace(
                                        context,
                                        Payment(
                                            price: widget.price,
                                            ID: widget.ID,
                                            dis: coupon[index]['dis']));

                                    print(totalprice);
                                  },
                                  child: Text(
                                    "Apply",
                                    style:
                                        GoogleFonts.prompt(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFFF53BE1E)),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ))
                    ]),
              ),
            ])));
  }

  Future<void> getCoupon(String couponId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final couponDoc =
          await firestore.collection('coupon').doc(couponId).get();

      if (!couponDoc.exists) {
        print("ไม่มีไอสัสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสสส");
      } else {
        print("asdasdasdasdasdasdasdsad");
        DocumentReference userDocumentReference = userCollection.doc(uid);
        return await userDocumentReference.update({
          "coupon": FieldValue.arrayUnion([couponId])
        });
      }
    } catch (e) {
      print('Error getting coupon: $e');
    }
  }

  Future<void> CouPon(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Coupon", style: GoogleFonts.prompt()),
            content: TextField(
                controller: textController,
                autofocus: true, //แสดงTextField
                decoration:
                    InputDecoration(hintText: "Apply your coupon code here"),
                style: GoogleFonts.prompt()),
            actions: [
              TextButton(
                child: Text("Confirm", style: GoogleFonts.prompt()),
                onPressed: () {
                  getCoupon(textController.text)
                      .then((value) => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Couponpayment(
                                    price: widget.price, ID: widget.ID)),
                            (route) => false,
                          ));
                },
              )
            ],
          ));
}
