import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voteapp/Controller/MyInfoController.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyInfoController c = Get.put(MyInfoController());

    return Scaffold(
      appBar: AppBar(
        title : const Text('내 정보'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: c.email,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c.nameTxc,
                    decoration: const InputDecoration(
                      hintText: '닉네임',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: () {
                  c.infoSave();
                }, child: const Text('중복검사')),
              ],
            ),
            ElevatedButton(onPressed: () {
              c.revoke();
            }, child: const Text('회원탈퇴')),
          ],
        ),
      ),
    );
  }
}
