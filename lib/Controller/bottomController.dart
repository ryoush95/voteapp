import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class BottomNaviController extends GetxController {
  static BottomNaviController get to => Get.find();
  RxInt selectIndex = 0.obs;
  DateTime backpress = DateTime.now();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  RxBool isCategoryPageOpen = false.obs;
  RxString titletext = 'Rank5'.obs;

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
      //true = 첫화면 false = 카테고리 페이지
      if(!await navigatorKey2.currentState!.maybePop()){
        exitalert();
      }
      return false;
    } else if (selectIndex.value == 1){
      if(!await navigatorKey.currentState!.maybePop()){
        exitalert();
      }
      return false;
    } else {
      exitalert();
      return false;
    }
  }

  void setCategoryPage(bool ck) {
    isCategoryPageOpen(ck);
  }

  void back() {
    setCategoryPage(false);
    onWillPop();
  }

  void exitalert(){
    Get.dialog(
        AlertDialog(
          title: Text('앱종료?'),
          actions: [
            TextButton(onPressed: (){
              Get.back();
            }, child: Text('no')),
            TextButton(onPressed: (){
              SystemNavigator.pop();
            }, child: Text('yes'))
          ],
        )
    );
  }


}


