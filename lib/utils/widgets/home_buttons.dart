import 'package:daraz_idea_firebase/constants/consts.dart';

Widget homeButtons({
  icon,
  String? title,
  height,
  width,
  //onPressed,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}
