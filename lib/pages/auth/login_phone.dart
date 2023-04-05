import 'package:chat_test/pages/auth/login.social.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/helper_function.dart';
import '../../widgets/widgets.dart';

class LoginPhonePage extends StatefulWidget {
  @override
  LoginPhonePageState createState() => LoginPhonePageState();
}

class LoginPhonePageState extends State<LoginPhonePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _codeSent = false;

  String _verificationId = '';

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
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    final String phoneNumber = _phoneController.text.trim();
    await _auth.verifyPhoneNumber(
      phoneNumber: '+66$phoneNumber',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) async {
        // Sign in with the credential
        UserCredential result =
            await _auth.signInWithCredential(authCredential);
        Fluttertoast.showToast(
            msg:
                'User logged in with phone number: ${result.user!.phoneNumber}');
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        Fluttertoast.showToast(msg: 'Failed to log in: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and show the code input form
        setState(() {
          _codeSent = true;
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> _signInWithPhoneNumber() async {
    String smsCode = _codeController.text.trim();
    if (smsCode.length == 6 && int.tryParse(smsCode) != null) {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      await _auth.signInWithCredential(credential).then((value) async {
        // saving the values to our shared preferences
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserPhoneSF(_phoneController.text);

        // Navigate to the HomePage
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }).catchError((e) {
        print(e);
        Fluttertoast.showToast(msg: 'เกิดข้อผิดพลาดในการเข้าสู่ระบบ');
      });
      Fluttertoast.showToast(msg: 'การเข้าสู่ระบบเสร็จสิ้น!');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "กรุณากรอก OTP ให้ถูกต้อง",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    _phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: _phoneController.text.length,
      ),
    );
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'เข้าสู่ระบบด้วยโทรศัพท์มือถือ',
                    style: GoogleFonts.prompt(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 350,
                    child: Text(
                      'กรุณากรอกหมายเลขโทรศัพท์มือถือ เราจะส่งรหัสผ่านแบบครั้งเดียว (OTP) ไปยังหมายเลขโทรศัพท์มือถือของคุณ',
                      style: GoogleFonts.prompt(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _codeSent ? _buildVerificationForm() : _buildPhoneForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextFormField(
            cursorColor: Colors.green,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                _phoneController.text = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
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
                          const CountryListThemeData(bottomSheetHeight: 600),
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
              suffixIcon: _phoneController.text.length > 9
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
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          // onTap: () => _verifyPhoneNumber(),
          onTap: () {
            String phoneNumber = _phoneController.text.trim();
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
              _verifyPhoneNumber();
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
    );
  }

  Widget _buildVerificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: TextFormField(
            controller: _codeController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'OTP Code',
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
            ),
            onEditingComplete: _signInWithPhoneNumber,
          ),
        ),
        InkWell(
          onTap: _signInWithPhoneNumber,
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
      ],
    );
  }
}
