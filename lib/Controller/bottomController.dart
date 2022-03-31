import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class BottomNaviController extends GetxController {
  static BottomNaviController get to => Get.find();
  RxInt selectIndex = 0.obs;
  DateTime backpress = DateTime.now();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;
  RxString titletext = 'app titleee'.obs;

  void onItemTapped(int index) {
    selectIndex.value = index;
    print(index);
    if (index == 1){
      titletext.value = '투표함';
    } else if (index == 2) {
      titletext.value = '커뮤니티';
    } else if (index == 3){
      titletext.value = '설정';
    } else {
      titletext.value = '랭킹 5';
    }
    update();
  }

  Future<bool> onWillPop() async{
    setCategoryPage(false);
    if(selectIndex.value == 2) {
      return !await navigatorKey2.currentState!.maybePop();
    } else {
      return !await navigatorKey.currentState!.maybePop();
    }
  }

  void setCategoryPage(bool ck) {
    isCategoryPageOpen(ck);
  }

  void back() {
    setCategoryPage(false);
    onWillPop();
  }


}


