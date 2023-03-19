import 'package:chat_test/pages/auth/login.speedy.dart';
import 'package:chat_test/pages/auth/register/register.speedy.agreement.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginSocial extends StatefulWidget {
  const LoginSocial({super.key});

  @override
  State<LoginSocial> createState() => _LoginSocialState();
}

class _LoginSocialState extends State<LoginSocial> {
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
                const SizedBox(height: 210),
                Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            print('google');
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white60,
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
                                  'assets/images/google-logo.png',
                                  scale: 15,
                                ),
                                Text(
                                  '    Log in with Google   ',
                                  style: GoogleFonts.prompt(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Speedy
                    const SizedBox(height: 15),
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
                                  builder: (context) => const LoginSpeedy(),
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

                    //Apple
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        print('Apple');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
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
                                  'assets/images/AppleW-Logo.png',
                                  scale: 15,
                                ),
                                Text(
                                  'Sign in with Apple     ',
                                  style: GoogleFonts.prompt(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
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
                    //Skip
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
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
                    )
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
