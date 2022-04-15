import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:voteapp/Controller/BoardController.dart';

import 'boardView.dart';

class Board extends StatefulWidget {
  const Board({Key? key, this.arguments}) : super(key: key);
  final arguments;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  BoardController c = Get.put(BoardController());
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c.init(widget.arguments);
    c.txc.addListener(() {});
  }

  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    c.txc.dispose();
    Get.delete<BoardController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);

    Future onRefresh() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      c.list.clear();
      c.init(widget.arguments);
      refreshController.refreshCompleted();
    }

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
                controller: c.txc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
            ElevatedButton(
              onPressed: () {
                c.boardadd();
              },
              child: const Text('add'),
            ),
            Expanded(
              child: GetBuilder<BoardController>(
                builder: (_) => SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: const ClassicHeader(),
                  controller: refreshController,
                  onRefresh: onRefresh,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: c.list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(const Boardview(), arguments: c.list[index].id);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.black)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(c.list[index].title),
                                    Text(c.list[index].replycount.toString()),
                                  ],
                                ),
                                // Text(c.list[index].writer),
                                Row(
                                  children: [
                                    Text(c.list[index].ts),
                                    Text(c.list[index].name),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
