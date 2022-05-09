import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class VoteAddController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString category = ''.obs;
  var catelist = ['카테고리 선택'].obs;
  TextEditingController titletxc = TextEditingController();
  TextEditingController memotxc = TextEditingController();

  void cate(String data) {
    category.value = data;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    cateList();
    category.value = catelist[0];
  }

  void cateList() async {
    await db
        .collection('category')
        .get()
        .then((value) => value.docs.forEach((element) {
              catelist.add(element.data()['cate']);
              // print(list);
            }));
  }

  void add(String title, String memo) {
    if (category.value != '카테고리 선택' && title != '' && memo != '') {
      db.collection('vote').add({
        'allcount': 0,
        'timestamp': Timestamp.now(),
        'title': title,
        'memo': memo,
        'category': category.value,
      }).then((value) => Get.back());
      Fluttertoast.showToast(msg: '투표함이 등록되었습니다', gravity: ToastGravity.BOTTOM);
    } else {
      Fluttertoast.showToast(
        msg: '빈칸을 확인해주세요',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  // 스피너 목록
  List<DropdownMenuItem<String>> cateitem() {
    List<String> list = [];
    for (int i = 0; i < catelist.length; i++) {
      list.add(catelist[i]);
    }
    return list.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
