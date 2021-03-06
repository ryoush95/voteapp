import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
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
        child: SingleChildScrollView(
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
              quill.QuillToolbar.basic(controller: c.qc,
                iconTheme: const quill.QuillIconTheme(borderRadius: 15),
                multiRowsDisplay: false,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GetBuilder<BoardAddController>(builder: (_){
                  return quill.QuillEditor.basic(controller: c.qc, readOnly: false,);
                }),
              ),
              // Expanded(
              //   child: Container(
              //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //     child: TextField(
              //       controller: c.content,
              //       decoration: const InputDecoration(
              //           hintText: "내용", border: InputBorder.none,
              //       ),
              //       maxLines: 50,
              //       keyboardType: TextInputType.multiline,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
