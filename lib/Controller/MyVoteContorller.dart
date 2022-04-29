import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:voteapp/model.dart';

class MyVoteController extends GetxController {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';

  //list
  Map<String, dynamic> member = {};
  List mylist = [];
  RxList<dynamic> list = <dynamic>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await db
        .collection('votemember')
        .doc(_auth.currentUser!.email)
        .get()
        .then((value)
    {
      mylist = value.data()!['voteList'];
      print(mylist);
    });

    for(int i = 0; i < mylist.length; i++){
      await db.collection('vote').doc(mylist[i]).get().then((e) =>
          list.add(VoteListModel(
              title: e.data()!['title'],
              id: e.id,
              timestamp: e.data()!['timestamp'],
              votecount: e.data()!['allcount']))
      );
    }
    print(list[0].title);
    update();
  }
}
