import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/presentation/auth_screen/signup_screen.dart';
import 'package:daraz_idea_firebase/presentation/home_screen/home.dart';
import 'package:daraz_idea_firebase/utils/widgets/app_logo_widget.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_button.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_textfields.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controllers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appname"
                  .text
                  .white
                  .bold
                  .fontFamily(bold)
                  .size(20)
                  .make(),
              20.heightBox,
              Column(
                children: [
                  customTextField(
                    controller: controller.emailController,
                    title: email,
                    hint: emailHint,
                    isPassword: false,
                  ),
                  customTextField(
                    controller: controller.passwordController,
                    title: password,
                    hint: passwordHint,
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  customButton(
                    onPressed: () async {
                      await controller
                          .loginMethod(context: context)
                          .then((value) {
                        if (value != null) {
                          VxToast.show(context, msg: loggedInSuccessfully);
                          Get.offAll(() => const Home());
                        }
                      });
                    },
                    title: logIn,
                    color: redColor,
                    textColor: whiteColor,
                  ).box.width(context.screenWidth - 50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  customButton(
                    onPressed: () {
                      Get.to(() => const SignUpScreen());
                    },
                    title: signUp,
                    color: lightGolden,
                    textColor: redColor,
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: lightGrey,
                          child: Image.asset(
                            socialIconList[index],
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(10))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
