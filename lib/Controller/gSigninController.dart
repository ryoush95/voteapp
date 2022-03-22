import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class gSigninController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxString name = '정보없음'.obs;
  RxString email = ''.obs;
  RxString url = ''.obs;
  RxString bt = '구글 로그인'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (_auth.currentUser != null) {
      email.value = _auth.currentUser!.email!;
      name.value = _auth.currentUser!.displayName!;
      bt.value = '로그아웃';
    } else {
      bt.value = '구글 로그인';
    }
  }

  void adduser() {
    db
        .collection('votemember')
        .where('email', isEqualTo: email.value)
        .get()
        .then((value) {
      if (value.size == 0) {
        db
            .collection('votemember')
            .doc(email.value)
            .set({'email': email.value});
      }
    });
  }
}