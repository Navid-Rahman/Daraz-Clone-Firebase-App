import 'package:daraz_idea_firebase/constants/colors.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/presentation/home_screen/home.dart';
import 'package:daraz_idea_firebase/utils/widgets/app_logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // creating a method to navigate to login screen
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palettesOne,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.white.bold.fontFamily(bold).size(24).make(),
            5.heightBox,
            appversion.text.white.fontFamily(regular).size(12).make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).size(16).make(),
            5.heightBox,
            copyRight.text.white.fontFamily(regular).size(12).make(),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
