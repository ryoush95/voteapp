import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:voteapp/model.dart';
import 'package:voteapp/screen/login.dart';

import '../screen/boardAdd.dart';

class BoardController extends GetxController {
  // final TextEditingController txc = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;

  List list = [];
  String cateId = '';

  void init() async {
    await db
        .collection('board')
        .where('category', isEqualTo: cateId)
        .orderBy('timestamp', descending: true)
        .get()
        .then(
          (value) => value.docs.forEach((element) {
            list.add(
              BoardModel(
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

  Future<void> getAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser != null){
      final bool refreshPage = await Get.to(const boardAdd(),arguments: {
        'docId' : null,
        'cateId' : cateId});
      print(refreshPage);
      if(refreshPage) {
        list.clear();
        init();
      }
    } else {
      Get.to(Login());
    }

  }



  String datetime(Timestamp date) {
    final now = Timestamp.now().toDate();
    final todate = date.toDate();
    if (now.day == todate.day) {
      String ts = DateFormat('HH:mm').format(todate);
      return ts;
    }
    String ts = DateFormat('MM-dd').format(todate);
    return ts;
  }
}
