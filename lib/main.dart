import 'package:chat_test/helper/helper_function.dart';
import 'package:chat_test/pages/auth/login.social.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/shared/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../../service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constant.apiKey,
            appId: Constant.appId,
            messagingSenderId: Constant.messageSenderId,
            projectId: Constant.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: SizedBox(
            width: 300,
            height: 300,
            child: Image.asset(
              'assets/images/Logo.png',
            ),
          ),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
          nextScreen: _isSignedIn ? const HomePage() : const LoginSocial(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
