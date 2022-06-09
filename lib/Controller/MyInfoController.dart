import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyInfoController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final nameTxc = TextEditingController();
  String uid = '';
  String email = '';


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    uid = _auth.currentUser!.uid;
    email = _auth.currentUser!.email!;
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameTxc.dispose();
    super.dispose();
  }

  void init() async {
    await db.collection('votemember').doc(uid).get().then((value) {
      nameTxc.text = value.data()!['name'];
    });
  }

  void infoSave() async {
    await db
        .collection('votemember')
        .where('name', isEqualTo: nameTxc.text)
        .get()
        .then((value) {
      if (value.size > 0) {
        print('ooooooooooooooooooooooooooo');
        Get.dialog(AlertDialog(
          title: Text('중복된 닉네임입니다'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('ok'))
          ],
        ));
      } else {
        print('xxxxxxxxxxxxxxxxxxxxxxxxxxx');
        Get.dialog(AlertDialog(
          title: Text('사용가능한 닉네임입니다'),
          content: Text('닉네임을 변경할까요?'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('cancel')),
            TextButton(
                onPressed: () {
                  db.collection('votemember').doc(uid).update({
                    'name': nameTxc.text,
                  }).then((value) {
                    Fluttertoast.showToast(msg: '변경되었습니다.');
                    Get.back();
                  });
                },
                child: Text('ok'))
          ],
        ));
      }
    });
  }

  void revoke() async {
    _auth.currentUser!.delete();
    await _auth.signOut();
    // await GoogleSignIn().signOut();
    Fluttertoast.showToast(msg: 'revoke');
    Get.back();
  }
}
