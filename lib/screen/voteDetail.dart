import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/VoteDetailController.dart';

class VoteDetail extends StatelessWidget {
  const VoteDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(VoteDetailController());
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image(image: c.circle()),
            ),
            Text(
              c.name.value,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              c.memo.value,
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
