import '../../constants/consts.dart';
import '../../constants/lists.dart';
import 'signup_screen.dart';
import '../home_screen/home.dart';
import '../../utils/widgets/app_logo_widget.dart';
import '../../utils/widgets/bg_widget.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_textfields.dart';
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
              Obx(
                () => Column(
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
                        child: forgetPassword.text.color(palettesSix).make(),
                      ),
                    ),
                    5.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : customButton(
                            title: logIn,
                            color: palettesTwo,
                            textColor: whiteColor,
                            onPressed: () async {
                              controller.isLoading(true);

                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context,
                                      msg: loggedInSuccessfully);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createNewAccount.text.color(fontGrey).make(),
                    5.heightBox,
                    customButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      title: signUp,
                      color: palettesTen,
                      textColor: palettesSeven,
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
                    .color(palettesFour)
                    .rounded
                    .padding(const EdgeInsets.all(10))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
