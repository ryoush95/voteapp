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
  @override
  Widget build(BuildContext context) {
    // final c = Get.put(SettingController());
    final auth = FirebaseAuth.instance;

    void goMyinfo(get) {
      if(auth.currentUser != null) {
        get;
      } else {
        Get.to(Login());
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              goMyinfo(Get.to(const MyInfo()));
            }, child: Text('내정보')),
            ElevatedButton(onPressed: (){
              goMyinfo(Get.to(const MyVote()));
            }, child: Text('내가 간 투표함')),
          ],
        ),
      ),
    );
  }
}
