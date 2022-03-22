import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/bottomController.dart';
import 'package:voteapp/screen/voteAdd.dart';

import 'login.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNaviController());
    BottomNaviController c = Get.find();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('app title'),
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
          () => Container(
            child: c.widgetoption.elementAt(c.selectIndex.value),
          ),
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
