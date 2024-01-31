import 'package:daraz_idea_firebase/constants/consts.dart';

Widget customButton({
  onPressed,
  color,
  textColor,
  String? title,
  double? width,
  double? borderRadius,
}) {
  return SizedBox(
    width: width ?? double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
      ),
      child: title!.text.color(textColor).fontFamily(bold).make(),
    ),
  );
}
