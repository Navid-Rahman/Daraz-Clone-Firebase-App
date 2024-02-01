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
        width: 50,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(palettesOne).make()
    ],
  ).box.rounded.color(palettesFour).size(width, height).shadowSm.make();
}
