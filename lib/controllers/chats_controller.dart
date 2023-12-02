import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;

  var messageController = TextEditingController();

  dynamic chatDocId;

  getChatId() async {
    await chats
        .where('users', isEqualTo: {
          friendId: null,
          currentId: null,
        })
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_message': '',
              'users': {
                friendId: null,
                currentId: null,
              },
              'fromId': '',
              'toId': '',
              'from_Name': friendName,
              'to_Name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
  }

  sendMessage(String message) async {
    if (message.trim().isNotEmpty) {
      await getChatId();

      chats.doc(chatDocId).update({
        'last_message': message,
        'created_on': FieldValue.serverTimestamp(),
        'fromId': currentId,
        'toId': friendId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'uid': currentId,
        'message': message,
      });

      messageController.clear();
    }
  }
}
