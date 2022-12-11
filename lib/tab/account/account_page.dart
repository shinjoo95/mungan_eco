import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youth_ecoapp/login/login_Page.dart';
import 'package:youth_ecoapp/tab/account/account_model.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          '프로필',
        ),
        actions: [
          IconButton(onPressed: () {
            Get.offAll(() => LoginPage());
          }, icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundColor: Colors.lightGreen,
                        backgroundImage: NetworkImage(model.getProfileImageUrl()),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  model.getNickName(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [Text('3', style: TextStyle(fontSize: 18),), Text('게시물')],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [Text('0', style: TextStyle(fontSize: 18)), Text('팔로워')],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [Text('0', style: TextStyle(fontSize: 18)), Text('팔로잉')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
