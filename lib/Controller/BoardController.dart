import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voteapp/model.dart';

class BoardController extends GetxController {
  final TextEditingController txc = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List list = [];

  void init(String cate) async {
    await db
        .collection('board')
        .where('category', isEqualTo: cate)
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) => value.docs.forEach((element) {
              list.add(BoardModel(
                  id: element.id,
                  title: element.data()['title'],
                  writer: element.data()['writer'],
                  replycount: element.data()['replycount'],
                  ts: datetime(element.data()['timestamp']),
                  name: element.data()['name']),
              );
            }),
    );
    update();
  }

  void boardadd() {
    if (_auth != null) {
      if (txc.text.isNotEmpty) {
        db.collection('board').add({
          'writer': _auth.currentUser!.email,
          'name': _auth.currentUser!.displayName,
          'timestamp': Timestamp.now(),
          'title': txc.text,
          'content': txc.text,
          'replycount': 0,
          'category' : 'a',
        });
      } else {
        Fluttertoast.showToast(msg: '빈칸 확인');
      }
    } else {
      print('login');
    }
  }

  String datetime(Timestamp date) {
    DateTime da = date.toDate();
    String ts = DateFormat('yyyy-MM-dd HH:mm').format(da);
    return ts;
  }
}
