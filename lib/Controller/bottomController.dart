import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class BottomNaviController extends GetxController {
  static BottomNaviController get to => Get.find();
  RxInt selectIndex = 0.obs;
  DateTime backpress = DateTime.now();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;

  void onItemTapped(int index) {
    selectIndex.value = index;
    update();
  }

  Future<bool> onWillPop() async{
    setCategoryPage(false);
    return !await navigatorKey.currentState!.maybePop();
  }

  void setCategoryPage(bool ck) {
    isCategoryPageOpen(ck);
  }

  void back() {
    setCategoryPage(false);
    onWillPop();
  }


}


