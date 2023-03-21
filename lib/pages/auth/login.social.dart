import 'package:chat_test/pages/auth/login.speedy.dart';
import 'package:chat_test/pages/auth/register/register.speedy.agreement.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:chat_test/pages/auth/login_phone.dart';

import '../../widgets/widgets.dart';

class LoginSocial extends StatefulWidget {
  const LoginSocial({super.key});

  @override
  State<LoginSocial> createState() => _LoginSocialState();
}

class _LoginSocialState extends State<LoginSocial> {
  String? status;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    status = 'Not Authenticated';
  }

  void signInAnon() async {
    User? user = (await auth.signInAnonymously()).user;
    if (user != null && user.isAnonymous == true) {
      setState(() {
        nextScreenReplace(context, const HomePage());
        print('Sign In Anonymously');
      });
    } else {
      status = 'Sign In fail';
    }
  }

  // void signOut() async {
  //   await auth.signOut();
  //   setState(() {
  //     status = 'Sign Out';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/Logo.png',
                    scale: 18,
                  ),
                ),
                const SizedBox(height: 320),

                //Speedy
                InkWell(
                  onTap: () {
                    ap.isSignedIn == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPhonePage(),
                            ),
                          );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/Logo2.png',
                              scale: 15,
                            ),
                            Text(
                              'Log in with Speedy     ',
                              style: GoogleFonts.prompt(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Skip
                InkWell(
                  onTap: () => signInAnon(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Skip',
                              style: GoogleFonts.prompt(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a SPEEDY ? ',
                      style: GoogleFonts.prompt(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.prompt(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.lightGreen,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterAgreement(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
