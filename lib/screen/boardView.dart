import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/BoardViewController.dart';

class Boardview extends StatelessWidget {
  const Boardview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BoardViewController());
    final BoardViewController c = Get.find();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                c.title.value,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(c.name.value)),
                Obx(() => Text(c.time.value)),
              ],
            ),
            const SizedBox(
              height: 10,
              width: double.maxFinite,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey,
                        width: 1.0)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Text(c.content.value)),
          ],
        )),
      ),
    );
  }
}
