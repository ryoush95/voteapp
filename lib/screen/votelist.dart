import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/bottomController.dart';
import 'package:voteapp/screen/vote.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Controller/VoteListController.dart';

class VoteList extends StatefulWidget {
  const VoteList({Key? key, this.arguments}) : super(key: key);
  final arguments;

  @override
  State<VoteList> createState() => _VoteListState();
}

class _VoteListState extends State<VoteList> {
  final VoteListController c = Get.put(VoteListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.init(widget.arguments);

    BottomNaviController.to.titletext.value = '투표함';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<VoteListController>();
  }

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);

    Future onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      c.list.clear();
      c.init(widget.arguments);
      refreshController.refreshCompleted();
    }

    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: const ClassicHeader(),
              controller: refreshController,
              onRefresh: onRefresh,
              child: Obx(() => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: c.list.length,
                  itemBuilder: (context, index) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            )),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Get.to(voteAdd());
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
