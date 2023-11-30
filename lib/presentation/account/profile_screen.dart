import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/controllers/profile_controller.dart';
import 'package:daraz_idea_firebase/presentation/account/edit_profile_screen.dart';
import 'package:daraz_idea_firebase/presentation/account/widgets/details_card.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controllers.dart';
import '../auth_screen/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              /// Edit Icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ).onTap(() {
                  Get.to(() => const EditProfileScreen());
                }),
              ),

              /// User Profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Image.asset(
                      imgProfile2,
                      width: 60,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Example User"
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          "customer@example.com"
                              .text
                              .white
                              .size(
                                12,
                              )
                              .make(),
                        ],
                      ),
                    ),

                    // Logout Button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);
                        Get.offAll(() => const LoginScreen());
                      },
                      child: "Logout".text.white.fontFamily(semibold).make(),
                    ),
                  ],
                ),
              ),

              20.heightBox,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  detailsCard(
                    width: context.screenWidth / 3.5,
                    count: "00",
                    title: "in your cart",
                  ),
                  detailsCard(
                    width: context.screenWidth / 3.5,
                    count: "43",
                    title: "in your wishlist",
                  ),
                  detailsCard(
                    width: context.screenWidth / 3.5,
                    count: "08",
                    title: "your orders",
                  ),
                ],
              ),

              /// Buttons Section
              ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.asset(
                      profileButtonIcons[index],
                      width: 30,
                    ),
                    title: profileButtonLists[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.black26,
                  );
                },
                itemCount: profileButtonLists.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
                  .box
                  .white
                  .rounded
                  .shadowSm
                  .margin(const EdgeInsets.all(12))
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .make()
                  .box
                  .color(redColor)
                  .make(),
            ],
          ),
        ),
      ),
    );
  }
}
