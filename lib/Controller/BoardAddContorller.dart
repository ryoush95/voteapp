import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BoardAddController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  RxString name = ''.obs;
  String? cateId;
  String? docId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    db
        .collection('votemember')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => name.value = value['name']
    );

    print(cateId);
    cateId = Get.arguments['cateId'];
    docId = Get.arguments['docId'];
    print(docId);
    if (docId != null){
      db.collection('board').doc(docId).get().then((value){
        title.text = value['title'];
        content.text = value['content'];
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    content.dispose();
    Get.delete<BoardAddController>();
  }

  void boardadd() {
    //no blank
    if (title.text.isNotEmpty && content.text.isNotEmpty) {
      //수정
      if(docId != null){
       db.collection('board').doc(docId).update({
         'title': title.text,
         'content' : content.text,
       }).then((value) {
         Get.back(result: true);
       });
      }else {
        //새 글
        db.collection('board').add({
          'writer': _auth.currentUser!.uid,
          'name': name.value,
          'timestamp': Timestamp.now(),
          'title': title.text,
          'content': content.text,
          'replycount': 0,
          'category': cateId,
        }).then((value) {
          Get.back(result: true);
          Fluttertoast.showToast(msg: '게시물 등록');
        });
      }
    } else {
      Fluttertoast.showToast(msg: '제목과 내용을 확인해주세요');
    }
  }
}
