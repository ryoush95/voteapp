import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:voteapp/Controller/addCandidateController.dart';

class AddCandidate extends StatelessWidget {
  const AddCandidate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AddCandidateController());
    AddCandidateController c = Get.find();
    c.uid.value = Get.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: const Text('add image')),
            TextField(
                controller: c.titletxc,
                decoration: const InputDecoration(
                  hintText: '후보 이름',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: c.memotxc,
              decoration: const InputDecoration(
                hintText: '부가 설명',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  c.submit();
                },
                child: const Text('등록'))
          ],
        ),
      ),
    );
  }
}
