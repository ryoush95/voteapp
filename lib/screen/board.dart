import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'boardView.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  // BoardController c = Get.put(BoardController());
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController txc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txc.addListener(() {});
  }

  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    txc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
                controller: txc,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
            ElevatedButton(
              onPressed: () {
                if (_auth != null) {
                  if (txc.text.isNotEmpty) {
                    db.collection('board').add({
                      'writer': _auth.currentUser!.email,
                      'name': _auth.currentUser!.displayName,
                      'timestamp': Timestamp.now(),
                      'title': txc.text,
                      'content': txc.text,
                      'replycount': 0,
                    });
                  } else {
                    print(0);
                  }
                } else {
                  print('login');
                }
              },
              child: Text('add'),
            ),
            Expanded(
                child: FutureBuilder(
              future: db
                  .collection('board')
                  .orderBy('timestamp', descending: true)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                      height: 50, child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(Boardview(),
                              arguments: snapshot.data!.docs[index].id);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.black)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(snapshot.data!.docs[index]['title']),
                                Text(snapshot.data!.docs[index]['writer']),
                                Text(snapshot.data!.docs[index]['replycount']
                                    .toString()),
                                Text(datetime(
                                    snapshot.data!.docs[index]['timestamp'])),
                                Text(snapshot.data!.docs[index]['name']),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  String datetime(Timestamp date) {
    DateTime da = date.toDate();
    String ts = DateFormat('yyyy-MM-dd HH:mm').format(da);
    return ts;
  }
}
