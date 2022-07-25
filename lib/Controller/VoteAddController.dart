import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VoteAddController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString category = ''.obs;
  var catelist = ['카테고리 선택'].obs;
  TextEditingController titletxc = TextEditingController();
  TextEditingController memotxc = TextEditingController();
  RxBool period = false.obs;
  List<String> dateMenu = ['7일', '30일', '1년'];
  RxString data = '7일'.obs;
  DateTime t = DateTime.now();

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
    print(period.value?Timestamp.fromDate(t):null);
    if (category.value != '카테고리 선택' && title != '' && memo != '') {
      db.collection('vote').add({
        'allcount': 0,
        'timestamp': Timestamp.now(),
        'title': title,
        'memo': memo,
        'category': category.value,
        // 'enddate' : period.value?Timestamp.fromDate(t):null
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

  List<DropdownMenuItem<String>> dateItem() {
    return dateMenu.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  String dateAfter() {
    String v = data.value;
    String d = '';

    if(v == '7일') {
      t = DateTime.now().add(Duration(days: 7));
    } else if(v == '30일') {
      t = DateTime.now().add(Duration(days: 30));
    } else if (v == '1년') {
      t = DateTime.now().add(Duration(days: 365));
    }
    d = DateFormat('yyyy-MM-dd').format(t);
    return d;
  }
}
