import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../screen/home.dart';
import '../screen/setting.dart';
import '../screen/board.dart';
import '../screen/votelist.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class BottomNaviController extends GetxController {
  RxInt selectIndex = 0.obs;
  DateTime backpress = DateTime.now();
  List widgetoption = const [
    Home(),
    VoteList(),
    Board(),
    Setting(),
  ];

  void onItemTapped(int index) {
    selectIndex.value = index;
    update();
  }


}


