import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

import '../../../constants/consts.dart';

Widget senderBubble(DocumentSnapshot data) {
  var timeData =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();

  var time = intl.DateFormat('hh:mm a').format(timeData);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : lightGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: "${data['message']}".text.white.size(16).make(),
          ),
          10.heightBox,
          Align(
            alignment: Alignment.bottomRight,
            child: time.text.white.size(12).make(),
          ),
        ],
      ),
    ),
  );
}
