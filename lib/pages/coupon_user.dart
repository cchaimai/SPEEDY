import 'package:chat_test/pages/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CouPonUser extends StatelessWidget {
  CouPonUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('โค้ดส่วนลด',
              style: GoogleFonts.prompt(
                  fontSize: 20, fontWeight: FontWeight.w500)),
          backgroundColor: const Color.fromRGBO(31, 31, 31, 1),
          toolbarHeight: 84, //ความสูง bar บน
          centerTitle: true, //กลาง
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
                        'Enter a Voucher Code',
                        style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Coupon Code",
                                  hintStyle: GoogleFonts.prompt(),
                                  contentPadding: const EdgeInsets.all(10)),
                            ))
                          ],
                        ),
                      ),
                      Text(
                        'Your Coupon ',
                        style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: Coupon.coupons.length,
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
                                  child: Text(
                                    Coupon.coupons[index].code,
                                    style: GoogleFonts.prompt(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    //Navigator.pop(context);
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
}
