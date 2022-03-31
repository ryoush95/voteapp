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
        child: SingleChildScrollView(
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
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(c.name.value)),
                  Obx(() => Text(c.time.value)),
                ],
              ),
              const Divider(
                thickness: 2,
                height: 40,
              ),
              Obx(
                () => Text(c.content.value,
                    style: (const TextStyle(
                      fontSize: 14.0,
                    ))),
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
    );
  }
}
