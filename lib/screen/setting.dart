import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/SettingController.dart';
import 'package:voteapp/screen/myInfo.dart';
import 'package:voteapp/screen/myVote.dart';

import 'login.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final auth = FirebaseAuth.instance;
  var user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    // final c = Get.put(SettingController());

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              if (user != null) {
                Get.to(const MyInfo());
              } else {
                Get.to(Login());
              }
            }, child: Text('내정보')),
            ElevatedButton(onPressed: (){
              if (user != null) {
                Get.to(const MyVote());
              } else {
                Get.to(Login());
              }
            }, child: Text('내가 간 투표함')),
          ],
        ),
      ),
    );
  }
}
