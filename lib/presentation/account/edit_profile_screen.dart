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
              customTextField(
                controller: controller.passwordController,
                title: password,
                hint: passwordHint,
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
                          await controller.uploadProfileImage();
                          await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.passwordController.text,
                            profileImageURL: controller.profileImageURL,
                          );
                          VxToast.show(context,
                              msg: "Profile Updated Successfully");
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
