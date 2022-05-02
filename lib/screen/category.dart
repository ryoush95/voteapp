import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/CategoryController.dart';
import 'package:voteapp/Controller/bottomController.dart';
import 'package:voteapp/screen/board.dart';
import 'package:voteapp/screen/votelist.dart';


class Category extends StatelessWidget {
  const Category({Key? key,this.argument}) : super(key: key);
  final argument;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CategoryController());
    return Scaffold(
        body: Obx(
            () => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: c.list.length,
      itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              BottomNaviController.to.setCategoryPage(true);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {

                    return argument == 'vote'?
                    VoteList(arguments: c.list[index])
                    : Board(arguments: c.list[index]);
                  },
                ),
              );
              // Get.to(const VoteList(), arguments: list[index]);
            },
            child: ListTile(
              title: Text(
                c.list[index],
                style: const TextStyle(fontSize: 20.0),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
      },
    ),
        ));
  }
}
