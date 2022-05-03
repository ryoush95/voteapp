import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:voteapp/Controller/addCandidateController.dart';

class AddCandidate extends StatefulWidget {
  const AddCandidate({Key? key}) : super(key: key);

  @override
  State<AddCandidate> createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  TextEditingController titletxc = TextEditingController();
  TextEditingController memotxc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<AddCandidateController>();
    titletxc.dispose();
    memotxc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddCandidateController());
    AddCandidateController c = Get.find();
    c.uid.value = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('후보등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                child: Center(
                    child: GetBuilder<AddCandidateController>(builder: (_) {
                  return c.pickImage == null
                      ? const Text('no image')
                      : Image.file(File(c.pickImage!.path));
                })),
              ),
              ElevatedButton(
                  onPressed: () {
                    c.getImage();
                  },
                  child: const Text('add image')),
              TextField(
                  controller: titletxc,
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
                controller: memotxc,
                decoration: const InputDecoration(
                  hintText: '부가 설명',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  c.submit(titletxc.text, memotxc.text);
                },
                child: const Text('등록'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
