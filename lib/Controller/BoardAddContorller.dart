import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart';

class BoardAddController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController title = TextEditingController();
  QuillController qc = QuillController.basic();
  RxString name = ''.obs;
  String? cateId;
  String? docId;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await init();

  }

  Future<void> init() async {
    await db
        .collection('votemember')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => name.value = value['name']
    );

    cateId = Get.arguments['cateId'];
    docId = Get.arguments['docId'];
    if (docId != null){
      String content = '';
      await db.collection('board').doc(docId).get().then((value){
        title.text = value.data()!['title'];
        content = value.data()!['content'];
      });
      var json = jsonDecode(content);
      qc = QuillController(document: Document.fromJson(json),
          selection: const TextSelection.collapsed(offset: 0));
      print(qc.document.toDelta());
    }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    Get.delete<BoardAddController>();
  }

  void boardadd() {
    var data = jsonEncode(qc.document.toDelta().toJson());
    //no blank
    if (title.text.isNotEmpty && !qc.document.isEmpty() ) {
      //μμ 
      if(docId != null){
       db.collection('board').doc(docId).update({
         'title': title.text,
         'content' : data,
       }).then((value) {
         Get.back(result: true);
       });
      }else {
        //μ κΈ
        db.collection('board').add({
          'writer': _auth.currentUser!.uid,
          'name': name.value,
          'timestamp': Timestamp.now(),
          'title': title.text,
          'content': data,
          'replycount': 0,
          'category': cateId,
        }).then((value) {
          Get.back(result: true);
          Fluttertoast.showToast(msg: 'κ²μλ¬Ό λ±λ‘');
        });
      }
    } else {
      Fluttertoast.showToast(msg: 'μ λͺ©κ³Ό λ΄μ©μ νμΈν΄μ£ΌμΈμ');
    }
  }
}
