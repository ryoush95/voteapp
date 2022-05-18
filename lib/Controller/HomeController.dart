import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:voteapp/screen/vote.dart';

import '../model.dart';

class HomeController extends GetxController {
  var db = FirebaseFirestore.instance.collection('vote');
  RxList hotlist = [].obs;
  RxList newlist = [].obs;
  String hotuid = '';
  RxString hotname = ''.obs;
  String newuid = '';
  RxString newname = ''.obs;

  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    hotinit();
    newinit();
  }

  @override
  void onClose() {
    // TODO: implement onInit
    super.onClose();
    hotlist.clear();
    newlist.clear();
  }

  Future hotinit() async {
    var random = Random().nextInt(2);
    String img;

    await db.orderBy('allcount', descending: true)
        .limit(2).get().then((value) {
      hotuid = value.docs[random].id;
      hotname.value = value.docs[random]['title'];
      db
          .doc(hotuid)
          .collection(value.docs[random].id)
          .orderBy('votecount', descending: true)
          .limit(5)
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            img = element.data()['image'] ?? '';
            hotlist.add(Rank(
                title: element.data()['name'],
                votecount: element.data()['votecount'],
                id: element.id,
                img: img));
          });
        },
      );
    });
  }

  Future newinit() async {
    var random = Random().nextInt(3);
    String img;

    db.where('allcount', isGreaterThan: 0)
        .orderBy('allcount', descending: false)
        .orderBy('timestamp', descending: true)
        .limit(3).get().then((value) {
      newuid = value.docs[random].id;
      newname.value = value.docs[random]['title'];
      db
          .doc(newuid)
          .collection(newuid)
          .orderBy('votecount', descending: true)
          .limit(5)
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            img = element.data()['image'] ?? '';
            newlist.add(Rank(
                title: element.data()['name'],
                votecount: element.data()['votecount'],
                id: element.id,
                img: img));
          });
        },
      );
    });
  }

  ImageProvider? circle(List list, int index) {
    if (list[index].img == '') {
      return const AssetImage('images/noimg.jpg');
    } else {
      return NetworkImage(list[index].img);
    }
  }

  void toVote(int v) {
    if (v == 1) {
      Get.to(
        const Vote(),
        arguments: {'uid': hotuid, 'name': hotname.value},
      );
    } else {
      Get.to(const Vote(), arguments: {'uid': newuid, 'name': newname.value});
    }
  }
}
