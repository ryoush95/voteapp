import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model.dart';

class VoteListController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  RxList<dynamic> list = <dynamic>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  Future init() async {
    await db.collection('vote').orderBy('allcount', descending: true).get().then(
          (value) => value.docs.forEach((e) {
        list.add(VoteListModel(
            title: e.data()['title'],
            id: e.id,
            timestamp: e.data()['timestamp'],
            votecount: e.data()['allcount']));
      }),
    );
  }

}