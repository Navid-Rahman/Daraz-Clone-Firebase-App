import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;

  changeProfileImage(context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image == null) {
        return;
      }
      profileImagePath.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.message.toString());
    }
  }
}
