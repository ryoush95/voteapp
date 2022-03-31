import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoardViewController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String room = Get.arguments;
  final txc = TextEditingController();
  RxString title = ''.obs;
  RxString content = ''.obs;
  RxString name = ''.obs;
  RxString time = ''.obs;
  RxString category = ''.obs;
  int replycount = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  void init() async {
    await db.collection('board').doc(room).get().then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data();
        title.value = data!['title'];
        name.value = data['name'];
        content.value = data['content'];
        Timestamp ts = data['timestamp'];
        DateTime da = ts.toDate();
        String t = DateFormat('yyyy-MM-dd HH:mm').format(da);
        time.value = t;
        replycount = data['replycount'];
        // name = data['name'];
      }
    });

    // await db.collection('board').doc(room).collection('reply').
  }

  void replyadd(String content) async{
    String name = '';
    await db.collection('votemember').doc(_auth.currentUser!.email).get().then(
            (value) => name = value.data()!['name']);
    print(name);
    db.collection('board').doc(room).collection('reply').doc().set({
      'writer': _auth.currentUser!.email,
      'content' : content,
      'timestamp': Timestamp.now(),
      'name': name,
    });
    print(replycount);
    replycount += 1;
    db.collection('board').doc(room).update({
      'replycount': replycount,
    });
  }
}