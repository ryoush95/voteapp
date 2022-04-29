import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voteapp/screen/login.dart';

import '../screen/myInfo.dart';

class SettingController extends GetxController {
  final _auth = FirebaseAuth.instance;

  void goMyinfo() {
    if(_auth.currentUser != null) {
      Get.to(const MyInfo());
    } else {
      Get.to(Login());
    }
  }

}