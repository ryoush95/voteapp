import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Controller/gSigninController.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final gSigninController c = Get.put(gSigninController());

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    c.name.value = googleUser!.displayName!;
    c.email.value = googleUser.email;
    c.bt.value = '로그아웃';
    c.adduser();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void googleSignOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    c.bt.value = '구글 로그인';

  }

  @override
  Widget build(BuildContext context) {
    final gSigninController c = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(c.name.value)),
            Obx(() => Text(c.email.value)),
            sign(),
          ],
        ),
      ),
    );
  }

  Widget sign() {
      return TextButton(
          onPressed: () {
            if (c.bt.value == '구글 로그인') {
              signInWithGoogle();
            } else {
              c.name.value = '정보없음';
              c.email.value = '';
              googleSignOut();
            }
          },
          child: Obx(() => Text(c.bt.value)),
      );

    //   return TextButton(
    //       onPressed: () {
    //         signInWithGoogle();
    //       },
    //       child: Text('구글 로그인'));
    // } else {
    //   return TextButton(
    //       onPressed: () {
    //         c.name.value = '정보없음';
    //         c.email.value = '';
    //         googleSignOut();
    //       },
    //       child: Text('로그아웃'));
    // }
  }
}
