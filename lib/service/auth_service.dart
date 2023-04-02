import 'package:chat_test/pages/auth/login_phone.dart';
import 'package:chat_test/pages/auth/register/register.speedy.otp.dart';
import 'package:chat_test/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../helper/helper_function.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/user.model.dart';
import '../widgets/widgets.dart';

class AuthService extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> checkUserLoginStatus(BuildContext context) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && user.isAnonymous == false) {
      await HelperFunction.saveUserUidSF(user.uid);
      return true;
    } else {
      signInAnon(context);
      return false;
    }
  }

  Future<void> _showLoginReminderDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Please Login'),
          content: Text('You need to login to access this page'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signInAnon(BuildContext context) async {
    User? user = (await _firebaseAuth.signInAnonymously()).user;
    if (user != null && user.isAnonymous == true) {
      await HelperFunction.saveUserUidSF(user.uid);
      nextScreenReplace(context, LoginPhonePage());
      Fluttertoast.showToast(msg: 'Please Login');
    } else {
      Fluttertoast.showToast(msg: 'Login fail!');
    }
  }

  void checkSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpScreen(
                      verificationId: verificationId,
                      phone: phoneNumber,
                    )));
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("mUsers").doc(_uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return true;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required List<String> cards,
    required List<String> events,
    required List<String> groups, // รับข้อมูล cards เป็น List<String>
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      //uploading image to firebase storage
      await storeFileDataToStorage("profilePic/$_uid", profilePic)
          .then((value) {
        userModel.profilePic = value;
        userModel.cards =
            cards; // กำหนดค่าของ cards จาก parameter ให้กับ userModel
        userModel.events = events;
        userModel.groups = groups;
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.uid;
      });
      _userModel = userModel;
      await _firebaseFirestore
          .collection("mUsers")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileDataToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Storing data locally
  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserPhoneSF("");
      await _firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  // Future loginWithUserNameandPassword(String email, String password) async {
  //   try {
  //     User user = (await firebaseAuth.signInWithEmailAndPassword(
  //             email: email, password: password))
  //         .user!;

  //     if (user != null) {
  //       return true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  // Future registerUserWithEmailandPassword(
  //     String fullname, String email, String password) async {
  //   try {
  //     User user = (await firebaseAuth.createUserWithEmailAndPassword(
  //             email: email, password: password))
  //         .user!;

  //     if (user != null) {
  //       await DatabaseService(uid: user.uid).savingUserData(fullname, email);
  //       return true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }
}
