import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BoardViewController extends GetxController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String room = Get.arguments;
  RxString title = ''.obs;
  RxString content = ''.obs;
  RxString name = ''.obs;
  RxString time = ''.obs;
  RxString category = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  void init() async {
    await db.collection('board').doc(room).get().then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data();
        title.value = data!['title'];
        name.value = data['name'];
        content.value = data['content'];
        Timestamp ts = data['timestamp'];
        DateTime da = ts.toDate();
        String t = DateFormat('yyyy-MM-dd HH:mm').format(da);
        time.value = t;
        // name = data['name'];
      }
    });
  }
}