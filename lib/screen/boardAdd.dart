import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/BoardAddContorller.dart';

class boardAdd extends StatelessWidget {
  const boardAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoardAddController c = Get.put(BoardAddController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
              onPressed: () {
                c.boardadd();
              },
              child: const Text(
                '등록',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Obx(
                () => TextField(
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: c.name.value,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: c.title,
                decoration: const InputDecoration(
                  hintText: "제목",
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  controller: c.content,
                  decoration: const InputDecoration(
                      hintText: "내용", border: InputBorder.none,
                  ),
                  maxLines: 50,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
