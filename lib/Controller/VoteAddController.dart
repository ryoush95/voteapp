import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoteAddController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString category = ''.obs;
  List<String> catelist = ['a', 'b', 'c'];
  TextEditingController titletxc = TextEditingController();
  TextEditingController memotxc = TextEditingController();

  void cate(String data) {
    category.value = data;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    category.value = catelist[0];
  }

  void add(String title, String memo) {
    db.collection('vote').add({
      'allcount': 0,
      'timestamp': Timestamp.now(),
      'title': title,
      'memo': memo,
      'category': category.value,
    });
  }

  // 스피너 목록
  List<DropdownMenuItem<String>> cateitem() {
    return catelist.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
