import 'package:chat_test/pages/auth/login.social.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/widgets/text.form.global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/widgets.dart';

class LoginSpeedy extends StatefulWidget {
  const LoginSpeedy({super.key});

  @override
  State<LoginSpeedy> createState() => _LoginSpeedyState();
}

class _LoginSpeedyState extends State<LoginSpeedy> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const LoginSocial()),
          icon: const Icon(Icons.arrow_back, color: Colors.green, size: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.language,
                color: Colors.green,
                size: 25,
              ))
        ],
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/Logo.png',
                    scale: 18,
                  ),
                ),

                const SizedBox(height: 25),
                //email input
                Text(
                  '  Email',
                  style: GoogleFonts.prompt(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormGlobal(
                  controller: emailController,
                  text: '',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),

                //pass input
                Text(
                  '  Password',
                  style: GoogleFonts.prompt(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormGlobal(
                  controller: passwordController,
                  text: '',
                  obscure: true,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.prompt(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
