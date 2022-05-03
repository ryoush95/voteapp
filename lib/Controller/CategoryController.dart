import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  final db = FirebaseFirestore.instance;
  var list = [].obs;

  @override
  void onInit() async{
    await db.collection('category').get().then((value) =>
        value.docs.forEach((element) {
          list.add(element.data()['cate']);
        })
    );
  }
}