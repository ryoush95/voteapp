import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final txc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txc.text = _auth.currentUser!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Get.back(result: false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: txc,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                ),
                ElevatedButton(onPressed: () async {
                  await db.collection('votemember')
                      .doc(_auth.currentUser!.uid)
                      .set({
                    'email': _auth.currentUser!.email,
                    'name' : txc.text,
                    'uid' : _auth.currentUser!.uid,
                    'voteList' : [],
                  }).then((value) => Get.back(result: true));
                }, child: const Text('save'))
              ],
            ),
          )
      ),
    );
  }


}
