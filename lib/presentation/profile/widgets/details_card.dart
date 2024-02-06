import 'package:daraz_idea_firebase/constants/consts.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(semibold).color(darkFontGrey).size(24).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .rounded
      .white
      .shadowSm
      .width(width)
      .height(80)
      .padding(const EdgeInsets.all(4))
      .make();
}
