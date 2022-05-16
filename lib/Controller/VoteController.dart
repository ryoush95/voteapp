import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/screen/addCandidate.dart';

import '../model.dart';

class VoteController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  RxList<dynamic> votelist = <dynamic>[].obs;
  RxInt num = 0.obs;
  RxString uid = ''.obs;
  String? imageUrl;
  List mylist = [];

  @override
  void onInit() {
    super.onInit();
    voterank();
  }


  //투표 리스트
  Future voterank() async {
    String img;
    await db
        .collection('vote')
        .doc(uid.value)
        .collection(uid.value)
        .orderBy('votecount', descending: true)
        .get()
        .then(
      (value) {
        value.docs.forEach((element) {
          img = element.data()['image'] ?? '';
          votelist.add(Rank(
            title: element.data()['name'],
            votecount: element.data()['votecount'],
            id: element.id,
            img: img,
          ));
        });
      },
    );
  }

  // 이미지 바인딩
  ImageProvider? circle(int index) {
    if (votelist[index].img == '') {
      return const AssetImage('images/noimg.jpg');
    } else {
      return NetworkImage(votelist[index].img);
    }
  }

  void voting(int index) {
    if (_auth.currentUser == null) {
      print('no auth');
      return;
    }
    var votedb = db
        .collection('vote')
        .doc(uid.value)
        .collection(uid.value)
        .doc(votelist[index].id);
    final votemember = db.collection('votemember').doc(_auth.currentUser!.uid);

    //투표버튼 클릭
    votemember.get().then((value) {
      mylist = value.data()!['voteList'];
      int i = 0;
      var dist = false;
      while (i < mylist.length) {
        if (mylist[i] == uid.value) {
          dist = true;
          break;
        }
        i++;
      }
      print(mylist);
      //중복투표
      if (dist) {
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
                      .doc(_auth.currentUser!.uid)
                      .set({
                    'vote': _auth.currentUser!.email,
                    'name': _auth.currentUser!.displayName,
                  });
                  //votemember에 추가 중복투표 방지
                  mylist.add(uid.value);
                  votemember.update({'voteList': mylist});
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

  //후보 추가로 이동
  void candidate() async{
    if (_auth.currentUser == null) {
      print('no auth');
      return;
    }
    bool result = await Get.to(const AddCandidate(),
        arguments: uid.value);

    if (result) {
      votelist.clear();
      voterank();
    } else {
      return;
    }
  }
}
