import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? url;

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

  void submit(String name, String memo) async {
    if (pickImage == null) {
      url = '';
    }
    if (name == '' || memo == '') {
      Fluttertoast.showToast(
        msg: '빈칸을 확인해주세요',
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black45,
      );
    } else {
      UploadTask ut =
          fs.ref('profile').child(fileName!).putFile(File(pickImage!.path));
      url = await (await ut).ref.getDownloadURL();
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
        'image': url
      });
      Get.back();
    }
  }
}
