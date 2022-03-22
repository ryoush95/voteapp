import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class AddCandidateController extends GetxController {
  RxString uid = ''.obs;
  TextEditingController titletxc = TextEditingController();
  TextEditingController memotxc = TextEditingController();
  String? email = FirebaseAuth.instance.currentUser?.email;

  FirebaseStorage fs = FirebaseStorage.instance;

  Future<void> upload(String input) async {
    final picker = ImagePicker();
    XFile? pickImage;
    try {
      pickImage = await picker.pickImage(
          source: input == 'camera' ? ImageSource.camera : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickImage!.path);
      File imageFile = File(pickImage.path);

      try {
        await fs.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'upload': email!,
            }));
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }

  void submit() {
    FirebaseFirestore.instance
        .collection('vote')
        .doc(uid.value)
        .collection(uid.value)
        .add({
      'name': titletxc.text,
      'memo': memotxc.text,
      'votecount': 0,
      'timestamp': Timestamp.now(),
      'auth': FirebaseAuth.instance.currentUser?.email,
    });
    Get.back();
  }
}
