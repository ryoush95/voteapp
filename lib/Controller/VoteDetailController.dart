import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteDetailController extends GetxController {
  final db = FirebaseFirestore.instance;
  String uid = Get.arguments['uid'];
  String doc = Get.arguments['doc'];
  RxString name = ''.obs;
  RxString memo = ''.obs;
  String image = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  void init() async {
    await db.collection('vote').doc(uid).collection(uid).doc(doc)
    .get().then((value){
      name.value = value.data()!['name'];
      memo.value = value.data()!['memo'];
      image = value.data()!['image'];
      print(name);
    });
  }

  ImageProvider circle() {
    if (image == '') {
      return const AssetImage('images/noimg.jpg');
    } else {
      return NetworkImage(image);
    }
  }
}
