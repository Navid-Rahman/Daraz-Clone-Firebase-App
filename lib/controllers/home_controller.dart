import 'package:get/get.dart';

import '../constants/consts.dart';
import '../constants/firebase_consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var userName = '';

  var searchController = TextEditingController();

  getUserName() async {
    var data = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });

    userName = data;
  }
}
