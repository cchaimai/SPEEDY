import 'package:chat_test/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/helper_function.dart';
import 'package:chat_test/pages/auth/login.social.dart';
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
  String? otpCode;

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
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    final String phoneNumber = _phoneController.text.trim();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign in with the auto-retrieved credential
        await _auth.signInWithCredential(credential);

        // Show a success message
        Fluttertoast.showToast(msg: 'Logged in successfully');
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
    final String smsCode = _codeController.text.trim();
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    await _auth.signInWithCredential(credential).then((value) async {
      // saving the values to our shared preferences
      // QuerySnapshot snapshot =
      //     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
      //         .gettingUserData(_phoneController.text);
      await HelperFunction.saveUserLoggedInStatus(true);
      await HelperFunction.saveUserPhoneSF(_phoneController.text);
      //await HelperFunction.saveUserNameSF(snapshot.docs[0]['fisrtName']);
      // ignore: use_build_context_synchronously
      nextScreenReplace(context, const HomePage());
    });
    Fluttertoast.showToast(msg: 'Logged in successfully');
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
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
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
        InkWell(
          onTap: () => _verifyPhoneNumber(),
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
        const SizedBox(height: 20),
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
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          onCompleted: (value) {
            setState(() {
              otpCode = value;
            });
          },
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => _signInWithPhoneNumber(),
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
