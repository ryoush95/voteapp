import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyInfoController extends GetxController{
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final nameTxc = TextEditingController();
  String uid = '';


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    uid = _auth.currentUser!.uid;
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameTxc.dispose();
    super.dispose();
  }

  void init() async {
    await db.collection('votemember').doc(uid).get().then((value){
      nameTxc.text = value.data()!['name'];
    });
  }

  void infoSave(){
    db.collection('votemember').doc(uid).update({
      'name' : nameTxc.text,
    }).then((value) =>
        Get.back()
    );
  }

}