import 'package:daraz_idea_firebase/constants/consts.dart';

Widget orderPlacedDetails({title1, title2, details1, details2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.color(darkFontGrey).fontFamily(semibold).make(),
            "$details1".text.color(redColor).fontFamily(semibold).make(),
          ],
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.color(darkFontGrey).fontFamily(semibold).make(),
              "$details2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
