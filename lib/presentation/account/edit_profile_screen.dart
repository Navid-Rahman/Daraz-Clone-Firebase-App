import 'dart:io';

import 'package:daraz_idea_firebase/controllers/profile_controller.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_button.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_textfields.dart';
import 'package:get/get.dart';

import '../../constants/consts.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// If profile image and profile image path is empty then show default image
              data['profileImage'] == '' && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :

                  /// If profile image is not empty and profile image path is empty then show image from url
                  data['profileImage'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(
                          data['profileImage'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      :

                      /// If profile image is empty and profile image path is empty then show image from path
                      Image.file(
                          File(controller.profileImagePath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              customButton(
                color: redColor,
                textColor: whiteColor,
                title: "Change",
                onPressed: () {
                  controller.changeProfileImage(context);
                },
              ),
              const Divider(),
              20.heightBox,
              customTextField(
                controller: controller.nameController,
                title: name,
                hint: nameHint,
                isPassword: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.oldPasswordController,
                title: oldPassword,
                hint: oldPasswordHint,
                isPassword: true,
              ),
              10.heightBox,
              customTextField(
                controller: controller.newPasswordController,
                title: newPassword,
                hint: newPasswordHint,
                isPassword: true,
              ),
              20.heightBox,
              controller.isLoading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : SizedBox(
                      width: context.screenWidth,
                      child: customButton(
                        color: redColor,
                        textColor: whiteColor,
                        title: "Save",
                        onPressed: () async {
                          controller.isLoading.value = true;

                          // If profile image path is not empty then upload image
                          if (controller.profileImagePath.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageURL = data['profileImage'];
                          }

                          // If old password is not empty and matches with the old password then update profile
                          if (controller
                                  .oldPasswordController.text.isNotEmpty &&
                              controller.oldPasswordController.text ==
                                  data['password']) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              oldPassword:
                                  controller.oldPasswordController.text,
                              newPassword:
                                  controller.newPasswordController.text,
                            );

                            await controller.updateProfile(
                              name: controller.nameController.text,
                              password:
                                  controller.newPasswordController.text.isEmpty
                                      ? data['password']
                                      : controller.newPasswordController.text,
                              profileImageURL: controller.profileImageURL,
                            );

                            VxToast.show(context,
                                msg: "Profile Updated Successfully");
                            return;
                          } else {
                            VxToast.show(context,
                                msg: "Old Password is Incorrect");

                            controller.isLoading.value = false;
                          }
                        },
                      ),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 16, right: 16))
              .rounded
              .make(),
        ),
      ),
    );
  }
}
