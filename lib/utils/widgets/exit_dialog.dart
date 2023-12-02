import 'package:flutter/services.dart';

import '../../constants/consts.dart';
import 'custom_button.dart';

Widget exitDialog(
  BuildContext context,
) {
  return Dialog(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
      const Divider(),
      10.heightBox,
      "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customButton(
            color: redColor,
            textColor: whiteColor,
            title: "Yes",
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          customButton(
            color: redColor,
            textColor: whiteColor,
            title: "No",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ],
  )
          .box
          .roundedSM
          .color(lightGrey)
          .padding(
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10))
          .make());
}
