import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/bottomController.dart';
import 'package:voteapp/screen/votelist.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> list = ['a', 'b', 'c'];
    return Scaffold(
        body: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            BottomNaviController.to.setCategoryPage(true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VoteList(arguments: list[index]);
                },
              ),
            );
            // Get.to(const VoteList(), arguments: list[index]);
          },
          child: ListTile(
            title: Text(
              list[index],
              style: const TextStyle(fontSize: 20.0),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    ));
  }
}
