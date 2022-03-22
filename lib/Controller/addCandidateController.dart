import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class AddCandidateController extends GetxController {
  RxString uid = ''.obs;

  String? email = FirebaseAuth.instance.currentUser?.email;
  XFile? pickImage;
  String? fileName;

  FirebaseStorage fs = FirebaseStorage.instance;

  @override
  void onClose() {
    // TODO: implement onInit
    super.onClose();
  }

  Future getImage() async {
    final picker = ImagePicker();
    pickImage =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 1920);
    fileName = path.basename(pickImage!.path);
    update();
  }

  Future<void> upload() async {
    try {
      await fs.ref(fileName).putFile(File(pickImage!.path));
      // print(fileName);
    } catch (e) {
      print(e);
    }
  }

  void submit(String name, String memo) {
    if (pickImage == null) {
      fileName = '';
    }
    if (name == '' || memo == '') {
      Fluttertoast.showToast(
        msg: '빈칸을 확인해주세요',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black45,
      );
    } else {
      upload();
      FirebaseFirestore.instance
          .collection('vote')
          .doc(uid.value)
          .collection(uid.value)
          .add({
        'name': name,
        'memo': memo,
        'votecount': 0,
        'timestamp': Timestamp.now(),
        'auth': FirebaseAuth.instance.currentUser?.email,
        'image': fileName
      });
      Get.back();
    }
  }
}
