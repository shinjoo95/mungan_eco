import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:youth_ecoapp/tab/tab_page.dart';
import '../login/login_Page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  final FirebaseAuth authentication = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => TabPage());
    }
  }

  void register(String email, String password) async {
    try {
      await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "회원 정보를 알맞게 쓰세요!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        messageText: Text(
          "비밀정보는 6자 이상! \n$e.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void member(String email, String password) async {
    try {
      await authentication.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error message",
        "User message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "아이디, 비밀번호를 다시 치세요",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        messageText: Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logout() {
    authentication.signOut();
  }
}
