import 'package:daraz_idea_firebase/controllers/profile_controller.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_button.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_textfields.dart';
import 'package:get/get.dart';

import '../../constants/consts.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imgProfile2,
              width: 60,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            customButton(
              color: redColor,
              textColor: whiteColor,
              title: "Change",
              onPressed: () {
                Get.find<ProfileController>().changeProfileImage(context);
              },
            ),
            const Divider(),
            20.heightBox,
            customTextField(
              title: name,
              hint: nameHint,
              // controller: TextEditingController(),
              isPassword: false,
            ),
            customTextField(
              title: password,
              hint: passwordHint,
              // controller: TextEditingController(),
              isPassword: true,
            ),
            20.heightBox,
            SizedBox(
              width: context.screenWidth,
              child: customButton(
                color: redColor,
                textColor: whiteColor,
                onPressed: () {},
                title: "Save",
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
    );
  }
}
