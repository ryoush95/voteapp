import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/VoteAddController.dart';

class voteAdd extends StatelessWidget {
  const voteAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VoteAddController());
    VoteAddController c = Get.find();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('새 투표'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                DropdownButton<String>(
                  value: c.category.value,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.blueGrey,
                  ),
                  onChanged: (String? data) {
                    c.cate(data!);
                  },
                  items: c.cateitem(),
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "투표함 이름"),
                  controller: c.titletxc,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "추가 정보"),
                  controller: c.memotxc,
                ),
                Obx(
                  () => RadioListTile(
                    value: false,
                    groupValue: c.period.value,
                    onChanged: (bool? value) {
                      c.period.value = value!;
                    },
                    title: Text("no date"),
                  ),
                ),
                Obx(
                  () => RadioListTile(
                    value: true,
                    groupValue: c.period.value,
                    onChanged: (bool? value) {
                      c.period.value = value!;
                    },
                    title: Text("date"),
                  ),
                ),
                Obx(
                  () => Visibility(
                      visible: c.period.value,
                      child: Column(
                        children: [
                          DropdownButton<String>(
                              value: c.data.value,
                              items: c.dateItem(),
                              onChanged: (String? data) {
                                c.data.value = data!;
                              }),
                          Text('end ${c.dateAfter()}')
                        ],
                      )),
                ),
                ElevatedButton(
                  onPressed: () {
                    c.add(c.titletxc.text, c.memotxc.text);
                  },
                  child: const Text('go'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
