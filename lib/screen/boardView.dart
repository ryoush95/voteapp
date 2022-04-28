import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/BoardViewController.dart';
import 'boardAdd.dart';

class Boardview extends StatelessWidget {
  const Boardview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoardViewController c = Get.put(BoardViewController());

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(actions: [
          Obx(() => c.idCheck.value
              ? ElevatedButton(
                  onPressed: () async {
                    final bool refresh =
                        await Get.to(const boardAdd(), arguments: c.docId);

                    if (refresh) {
                      c.init();
                    }
                  },
                  child: const Text('수정'),
                )
              : SizedBox()),
          Obx(() => c.idCheck.value
              ? ElevatedButton(
                  onPressed: () {
                    c.boardDelete();
                  },
                  child: const Text('삭제'),
                )
              : SizedBox()),
        ]
            // c.writerCheck()
            ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Text(
                    c.title.value,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                          "${c.name.value} (댓글 ${c.replycount.value})",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        )),
                    Obx(() => Text(
                          c.time.value,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        )),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 40,
                ),
                Obx(
                  () => Text(
                    c.content.value,
                    style: (const TextStyle(
                      fontSize: 18.0,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: const Text('목록으로')),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Text('댓글'),
                      IconButton(
                        onPressed: () {
                          c.replyrefresh();
                        },
                        icon: const Icon(Icons.refresh_rounded),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  height: 20,
                ),
                reply(c),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: Column(
              children: [
                const Divider(
                  thickness: 2,
                  height: 2,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: TextField(
                        controller: c.txc,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        c.replyadd(c.txc.text);
                        c.txc.text = '';
                      },
                      child: const Text('등록'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget reply(c) {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: c.replylist.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  c.replylist[index]['name'],
                  style: const TextStyle(fontSize: 14),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    c.replydelete(c.replylist[index].id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 16,
                  ),
                ),
              ]),
              Text(
                c.replylist[index]['content'],
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                c.replytime(index),
                style: const TextStyle(color: Colors.grey),
              ),
              const Divider(
                thickness: 2,
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}
