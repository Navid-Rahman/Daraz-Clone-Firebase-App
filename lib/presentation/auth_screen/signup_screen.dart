import 'package:daraz_idea_firebase/controllers/auth_controllers.dart';
import 'package:get/get.dart';

import '../../constants/consts.dart';
import '../../utils/widgets/app_logo_widget.dart';
import '../../utils/widgets/bg_widget.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_textfields.dart';
import '../home_screen/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCheck = false;
  var controller = Get.put(AuthController());

  // Text Controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Join the $appname"
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
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPassword: false,
                    ),
                    customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPassword: false,
                    ),
                    customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      isPassword: true,
                    ),
                    customTextField(
                      title: confirmPassword,
                      hint: confirmPasswordHint,
                      controller: confirmPasswordController,
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
                    Row(
                      children: [
                        Checkbox(
                          activeColor: palettesTwo,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = value!;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        color: fontGrey, fontFamily: regular)),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        color: redColor, fontFamily: regular)),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        color: fontGrey, fontFamily: regular)),
                                TextSpan(
                                    text: termsAndCondition,
                                    style: TextStyle(
                                        color: redColor, fontFamily: regular)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    10.heightBox,
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : customButton(
                            title: signUp,
                            color: isCheck == true ? palettesTwo : lightGrey,
                            textColor: whiteColor,
                            onPressed: () async {
                              if (isCheck != false) {
                                controller.isLoading(true);
                                try {
                                  await controller
                                      .signupMethod(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  )
                                      .then((value) {
                                    return controller.storeUserData(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }).then((value) {
                                    VxToast.show(context,
                                        msg: loggedInSuccessfully);
                                    Get.offAll(const Home());
                                  });
                                } catch (e) {
                                  auth.signOut();
                                  VxToast.show(context, msg: e.toString());
                                  controller.isLoading(false);
                                }
                              }
                            },
                          ).box.width(context.screenWidth - 50).make(),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyHaveAnAccount.text.color(fontGrey).make(),
                        logIn.text.color(redColor).make().onTap(() {
                          Get.back();
                        }),
                      ],
                    )
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
