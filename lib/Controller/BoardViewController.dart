import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoardViewController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String room = Get.arguments;
  final txc = TextEditingController();
  RxString title = ''.obs;
  RxString content = ''.obs;
  RxString name = ''.obs;
  RxString time = ''.obs;
  RxString category = ''.obs;
  String? writer;
  RxInt replycount = 0.obs;
  RxList replylist = [].obs;
  String? docId;
  RxBool idCheck =false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txc.dispose();
    BoardViewController().dispose();
  }

  void init() async {
    await db.collection('board').doc(room).get().then((value) {
      docId = value.id;
      if (value.exists) {
        Map<String, dynamic>? data = value.data();
        title.value = data!['title'];
        name.value = data['name'];
        content.value = data['content'];
        time.value = datetime(data['timestamp']);
        replycount.value = data['replycount'];
        writer = data['writer'];
        writer == _auth.currentUser!.uid ? idCheck.value = true : idCheck.value = false;
      }
    });

    await replyRefresh();
  }

  void boardDelete() {
    Get.dialog(AlertDialog(
      title: const Text('삭제하시겠습니까?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('cancel')),
        TextButton(
            onPressed: () {
              db.collection('board').doc(docId).delete();
              Get.back(result: true);
              Get.back(result: true);
            },
            child: const Text('ok')),
      ],
    ));
  }

  void replyAdd(String content) async {
    String name = '';
    await db
        .collection('votemember')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => name = value.data()!['name']);
    await db.collection('board').doc(room).collection('reply').doc().set({
      'writer': _auth.currentUser!.uid,
      'content': content,
      'timestamp': Timestamp.now(),
      'name': name,
    });
    replycount.value += 1;
    replyCountUpdate();
    replyRefresh();
  }

  Future<void> replyRefresh() async {
    replylist.clear();
    await db
        .collection('board')
        .doc(room)
        .collection('reply')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) => value.docs.forEach((e) {
              replylist.add(e);
            }));
    update();
  }

  void replyDelete(String id) {
    Get.dialog(AlertDialog(
      content: const Text('댓글을 삭제하시겠습니까?'),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('아니요')),
        TextButton(
            onPressed: () {
              db
                  .collection('board')
                  .doc(room)
                  .collection('reply')
                  .doc(id)
                  .delete();
              replycount.value -= 1;
              replyCountUpdate();
              replyRefresh();
              Get.back();
            },
            child: const Text('네')),
      ],
    ));
  }

  void replyCountUpdate() {
    db.collection('board').doc(room).update({
      'replycount': replycount.value,
    });
  }

  String datetime(Timestamp date) {
    DateTime da = date.toDate();
    String ts = DateFormat('yyyy-MM-dd HH:mm').format(da);
    return ts;
  }

  String replytime(int index) {
    var date = replylist[index]['timestamp'];
    DateTime da = date.toDate();
    String ts = DateFormat('MM-dd HH:mm').format(da);
    return ts;
  }
}
