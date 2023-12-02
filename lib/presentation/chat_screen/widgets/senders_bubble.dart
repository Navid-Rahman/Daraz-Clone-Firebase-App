import '../../../constants/consts.dart';

Widget senderBubble() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: const BoxDecoration(
      color: redColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: "Message Goes Here.......".text.white.size(16).make(),
        ),
        10.heightBox,
        Align(
          alignment: Alignment.bottomRight,
          child: "12:00 PM".text.white.size(12).make(),
        ),
      ],
    ),
  );
}
