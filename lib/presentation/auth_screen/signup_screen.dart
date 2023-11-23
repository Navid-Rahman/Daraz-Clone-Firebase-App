import 'package:get/get.dart';

import '../../constants/consts.dart';
import '../../utils/widgets/app_logo_widget.dart';
import '../../utils/widgets/bg_widget.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_textfields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isCheck = false;

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
              Column(
                children: [
                  customTextField(title: name, hint: nameHint),
                  customTextField(title: email, hint: emailHint),
                  customTextField(title: password, hint: passwordHint),
                  customTextField(
                      title: confirmPassword, hint: confirmPasswordHint),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
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
                  customButton(
                    onPressed: () {},
                    title: signUp,
                    color: isCheck == true ? redColor : lightGrey,
                    textColor: whiteColor,
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
