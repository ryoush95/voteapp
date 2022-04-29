import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/MyVoteContorller.dart';
import 'package:voteapp/screen/vote.dart';

class MyVote extends StatelessWidget {
  const MyVote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MyVoteController());

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
          ()=> ListView.builder(
            itemCount: c.list.length,
            itemBuilder: (BuildContext context, int index) {
              if (c.list.isEmpty) {
                return const CircularProgressIndicator();
              } else {
                return InkWell(
                  onTap: () => Get.to(const Vote(), arguments: {
                    'uid': c.list[index].id,
                    'name': c.list[index].title
                  }),
                  child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              c.list[index].title,
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              '${c.list[index].votecount.toString()} 표',
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              }
            }),
      ),
    );
  }
}
