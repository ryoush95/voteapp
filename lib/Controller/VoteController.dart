import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model.dart';

class VoteController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  RxList<dynamic> votelist = <dynamic>[].obs;
  RxInt num = 0.obs;
  RxString uid = ''.obs;

  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();
    voterank();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onInit
  //   super.onClose();
  //   print('close');
  // }

  Future voterank() async {
    await db
        .collection('vote')
        .doc(uid.value)
        .collection(uid.value)
        .orderBy('votecount', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          votelist.add(Rank(
              title: element.data()['name'],
              votecount: element.data()['votecount'],
              id: element.id));
        });
      },
    );
  }

  void voting(int index) {
    var votedb = db
        .collection('vote')
        .doc(uid.value)
        .collection(uid.value)
        .doc(votelist[index].id);
    var votemember = db.collection('votemember').doc(_auth.currentUser!.email);

    //투표버튼 클릭
    votemember.get().then((value) {
      //중복투표
      if (value.data()![uid.value] != null) {
        Get.dialog(AlertDialog(
          title: const Text('중복투표'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('ok'))
          ],
        ));
      } else {
        // 성공
        Get.dialog(AlertDialog(
          title: const Text('투표?'),
          actions: [
            TextButton(
                onPressed: () {
                  //votecount 올리기
                  votedb.update({
                    'votecount': votelist[index].votecount + 1,
                  });
                  int? l = 0;
                  for (int i = 0; i < votelist.length; i++) {
                    l = (l! + votelist[i].votecount) as int?;
                  }
                  db
                      .collection('vote')
                      .doc(uid.value)
                      .update({'allcount': l! + 1});
                  //투표 어디햇는지 저장
                  votedb
                      .collection(votelist[index].id)
                      .doc(_auth.currentUser!.email)
                      .set({
                    'vote': _auth.currentUser!.email,
                    'name': _auth.currentUser!.displayName,
                  });
                  //votemember에 추가 중복투표 방지
                  // votemember.update({uid.value: uid.value});
                  //새로고침
                  votelist.clear();
                  voterank();
                  Get.back();
                },
                child: const Text('ok')),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('cancel')),
          ],
        ));
      }
    });
  }

  void rankadd(String s) {
    db.collection('vote').doc(uid.value).collection(uid.value).add({
      'name': s,
      'votecount': 0,
      'timestamp': Timestamp.now(),
    });
  }
}
