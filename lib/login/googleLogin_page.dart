import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class GoogleLogin extends StatefulWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  State<GoogleLogin> createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  Future<UserCredential> googleAuthSignIn() async {
    //구글 Sign in 플로우 오픈!
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //구글 인증 정보 읽어왓!
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    //읽어온 인증정보로 파이어베이스 인증 로그인!
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    //파이어 베이스 Signin하고 결과(userCredential) 리턴햇!
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
