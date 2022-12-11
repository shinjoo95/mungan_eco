import 'package:firebase_auth/firebase_auth.dart';

class SettingModel{
  String getEmail(){
    return FirebaseAuth.instance.currentUser?.email ?? '' ;
  }
  String getProfileImageUrl(){
    return FirebaseAuth.instance.currentUser?.photoURL ?? '';
  }
  String getNickName(){
    return FirebaseAuth.instance.currentUser?.displayName ?? '닉네임';
  }
}
