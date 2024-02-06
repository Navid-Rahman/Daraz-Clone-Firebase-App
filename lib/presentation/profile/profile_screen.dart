import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/controllers/profile_controller.dart';
import 'package:daraz_idea_firebase/presentation/profile/widgets/details_card.dart';
import 'package:daraz_idea_firebase/presentation/profile/wishlist_section/wishlist_screen.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controllers.dart';
import '../auth_screen/login_screen.dart';
import 'edit_profile_screen.dart';
import 'messages_section/messages_screen.dart';
import 'orders_section/orders_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    FirestoreServices.getCounts();

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return SafeArea(
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
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),

                    /// User Profile
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['profileImage'] == ''
                              ? Image.asset(
                                  imgProfile2,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                                  data['profileImage'],
                                  width: 60,
                                  fit: BoxFit.cover,
                                ).box.roundedFull.clip(Clip.antiAlias).make(),

                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                                "${data['email']}"
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
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child:
                                "Logout".text.white.fontFamily(semibold).make(),
                          ),
                        ],
                      ),
                    ),

                    20.heightBox,

                    FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else {
                          var countData = snapshot.data;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                width: context.screenWidth / 3.5,
                                count: countData[0].toString(),
                                title: "in your cart",
                              ),
                              detailsCard(
                                width: context.screenWidth / 3.5,
                                count: countData[1].toString(),
                                title: "in your wishlist",
                              ),
                              detailsCard(
                                width: context.screenWidth / 3.5,
                                count: countData[2].toString(),
                                title: "your orders",
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    20.heightBox,

                    /// Buttons Section
                    ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;

                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIcons[index],
                            width: 30,
                            color: palettesTwo,
                          ),
                          title: profileButtonLists[index]
                              .text
                              .fontFamily(semibold)
                              .color(palettesOne)
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
                        .color(palettesFour)
                        .rounded
                        .shadowSm
                        .margin(const EdgeInsets.all(12))
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .make()
                        .box
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
