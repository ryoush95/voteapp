import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:voteapp/screen/addCandidate.dart';

import '../Controller/VoteController.dart';

class Vote extends StatelessWidget {
  const Vote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VoteController c = Get.put(VoteController());
    c.uid.value = Get.arguments['uid'];
    RefreshController refreshController =
        RefreshController(initialRefresh: false);

    Future onRefresh() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      c.votelist.clear();
      c.voterank();
      refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Get.arguments['name'],
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const AddCandidate(), arguments: c.uid.value);
                        },
                        child: const Text('후보 추가'))
                  ]),
            ),
            Obx(() {
              return Expanded(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: const ClassicHeader(),
                controller: refreshController,
                onRefresh: onRefresh,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: c.votelist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundImage: c.circle(index),
                              radius: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            c.votelist[index].title,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            "${c.votelist[index].votecount.toString()} 표 ",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                c.voting(index);
                                // print(c.votelist[index].id);
                              },
                              child: const Text('투표')),
                        ],
                      ),
                    );
                  },
                ),
              ));
            }),
          ],
        ),
      ),
    );
  }
}
