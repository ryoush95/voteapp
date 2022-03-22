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
  String hotname = '';
  String newuid = '';
  String newname = '';

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
    String img;
    await db.orderBy('allcount', descending: true).limit(1).get().then((value) {
      hotuid = value.docs[0].id;
      hotname = value.docs[0]['title'];
      db
          .doc(hotuid)
          .collection(value.docs[0].id)
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

    db.orderBy('timestamp').limit(3).get().then((value) {
      newuid = value.docs[random].id;
      newname = value.docs[random]['title'];
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
      return const AssetImage('images/appicon.png');
    } else {
      return NetworkImage(list[index].img);
    }
  }

  void toVote(int v) {
    if (v == 1) {
      Get.to(
        const Vote(),
        arguments: {'uid': hotuid, 'name': hotname},
      );
    } else {
      Get.to(const Vote(), arguments: {'uid': newuid, 'name': newname});
    }
  }
}
