import 'package:daraz_idea_firebase/constants/consts.dart';

Widget customButton({
  onPressed,
  color,
  textColor,
  String? title,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
