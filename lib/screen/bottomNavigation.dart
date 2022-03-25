import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/bottomController.dart';
import 'package:voteapp/screen/setting.dart';
import 'package:voteapp/screen/voteAdd.dart';

import 'board.dart';
import 'category.dart';
import 'home.dart';
import 'login.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNaviController c = Get.put(BottomNaviController());
    return WillPopScope(
      onWillPop: c.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(()=> Text(c.titletext.value)),
          actions: [
            IconButton(onPressed: (){
              Get.to(const voteAdd());
            },
                icon: const Icon(Icons.add),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
              child: IconButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Obx(
          () => IndexedStack(
            index: c.selectIndex.value,
            children: [
              const Home(),
              Navigator(
                key: c.navigatorKey,
                onGenerateRoute: (rs){
                  return MaterialPageRoute(builder: (context) {
                    return const Category(argument: 'vote',);
                  },);
                },
              ),
              Navigator(
                key: c.navigatorKey2,
                onGenerateRoute: (rs){
                  return MaterialPageRoute(builder: (context) {
                    return const Category(argument: 'board',);
                  },);
                },
              ),
              const Setting(),
            ],
          )
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: c.selectIndex.value,
            selectedItemColor: Colors.blueAccent,
            onTap: c.onItemTapped,
            unselectedItemColor: Colors.black,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.how_to_vote),
                label: '투표함',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: '커뮤니티',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
