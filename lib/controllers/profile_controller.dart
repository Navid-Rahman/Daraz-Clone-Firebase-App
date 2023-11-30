import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImagePath = ''.obs;
  var profileImageURL = '';

  var isLoading = false.obs;

  // Text Controllers
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

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

  // Upload Profile Image
  uploadProfileImage() async {
    var fileName = basename(profileImagePath.value);
    var destination = 'profile/images/${currentUser!.uid}/$fileName';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));

    profileImageURL = await ref.getDownloadURL();
  }

  // Update Profile
  updateProfile({
    name,
    password,
    profileImageURL,
  }) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);

    await store.set({
      'name': name,
      'password': password,
      'profileImage': profileImageURL,
    }, SetOptions(merge: true));
    isLoading.value = false;
  }
}
