import 'package:firebase_auth/firebase_auth.dart';

class AccountModel{
  void logout(){

  }
  String getProfileImageUrl(){
    return FirebaseAuth.instance.currentUser?.photoURL ?? 'assets/youth1.png';
  }
  String getNickName(){
    return FirebaseAuth.instance.currentUser?.displayName ?? '닉네임';
  }
}