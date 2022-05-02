import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/HomeController.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController c = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text(
                '지금 핫한 투표함',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              IconButton(
                  onPressed: () {
                    c.hotlist.clear();
                    c.newlist.clear();
                    c.hotinit();
                    c.newinit();
                  },
                  icon: const Icon(Icons.refresh))
            ]),
            const Text(''),
            SizedBox(
              height: 350,
              child: Obx(
                () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: c.hotlist.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "${index + 1} 위",
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
                                backgroundImage: c.circle(c.hotlist, index),
                                radius: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              c.hotlist[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              "${c.hotlist[index].votecount.toString()} 표 ",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ),
            TextButton(
                onPressed: () {
                  c.toVote(1);
                },
                child: const Text('이 투표함으로')),
            const Text(
              '새로나온 투표함',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Text(''),
            SizedBox(
              height: 350,
              child: Obx(
                () => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: c.newlist.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "${index + 1} 위",
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
                                backgroundImage: c.circle(c.newlist, index),
                                radius: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              c.newlist[index].title,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              "${c.newlist[index].votecount.toString()} 표 ",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ),
            TextButton(
                onPressed: () {
                  c.toVote(2);
                },
                child: const Text('이 투표함으로')),
          ],
        ),
      ),
    );
  }
}
