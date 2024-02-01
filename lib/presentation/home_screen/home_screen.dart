import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/controllers/home_controller.dart';
import 'package:daraz_idea_firebase/presentation/categories/items_details.dart';
import 'package:daraz_idea_firebase/presentation/home_screen/search_screen.dart';
import 'package:daraz_idea_firebase/presentation/home_screen/widgets/featured_button.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:daraz_idea_firebase/utils/widgets/home_buttons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: palettesTwo,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: lightGrey,
              height: 60,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: searchAnything,
                  hintStyle: const TextStyle(
                    color: palettesEight,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: palettesFive,
                  ).onTap(() {
                    if (controller.searchController.text.isNotEmpty) {
                      Get.to(() => SearchScreen(
                          query: controller.searchController.text));
                    }
                  }),
                  filled: true,
                  fillColor: palettesTen,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    /// Swiper Banner Slider Widget
                    VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            )
                            .make();
                      },
                    ),

                    10.heightBox,

                    /// Home Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todaysDeal : flashSale,
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3,
                          //onPressed: () {},
                        ),
                      ),
                    ),

                    10.heightBox,

                    /// Second Sliders
                    VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            )
                            .make();
                      },
                    ),

                    10.heightBox,

                    /// Home Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topCategories
                              : index == 1
                                  ? brand
                                  : topSellers,
                          height: context.screenHeight * 0.14,
                          width: context.screenWidth / 3.5,
                        ),
                      ),
                    ),

                    10.heightBox,

                    /// Featured Categories
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: context.screenWidth,
                      decoration: BoxDecoration(
                        color: palettesEight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCategories.text
                            .color(whiteColor)
                            .size(18)
                            .fontFamily(semibold)
                            .make(),
                      ),
                    ),

                    20.heightBox,

                    /// Featured Categories List
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                      title: featuredTitle1[index],
                                      icon: featuredImages1[index],
                                    ),
                                    10.heightBox,
                                    featuredButton(
                                      title: featuredTitle2[index],
                                      icon: featuredImages2[index],
                                    ),
                                  ],
                                )).toList(),
                      ),
                    ),

                    /// Featured Products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: context.screenWidth,
                      decoration: BoxDecoration(
                        color: palettesFour,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .size(18)
                              .fontFamily(bold)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(palettesFour),
                                    ),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredProductsData =
                                      snapshot.data!.docs;

                                  return Row(
                                    children: List.generate(
                                      featuredProductsData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            featuredProductsData[index]
                                                ['p_imgs'][0],
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "${featuredProductsData[index]['p_name']}"
                                              .text
                                              .color(palettesTen)
                                              .fontFamily(semibold)
                                              .make(),
                                          10.heightBox,
                                          "${featuredProductsData[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(palettesSix)
                                              .fontFamily(semibold)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .margin(
                                            const EdgeInsets.symmetric(
                                                horizontal: 4),
                                          )
                                          .rounded
                                          .color(palettesEight)
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(
                                        () {
                                          Get.to(
                                            () => ItemDetails(
                                              title: featuredProductsData[index]
                                                  ['p_name'],
                                              data: featuredProductsData[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Third Sliders
                    20.heightBox,
                    VxSwiper.builder(
                      height: 150,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            )
                            .make();
                      },
                    ),

                    /// All Products Section
                    20.heightBox,

                    Container(
                      padding: const EdgeInsets.all(12),
                      width: context.screenWidth,
                      decoration: BoxDecoration(
                        color: palettesEight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: "All Products"
                            .text
                            .color(whiteColor)
                            .size(18)
                            .fontFamily(bold)
                            .make(),
                      ),
                    ),

                    20.heightBox,

                    StreamBuilder(
                        stream: FirestoreServices.getAllProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              ),
                            );
                          } else {
                            var allProductsData = snapshot.data!.docs;

                            return GridView.builder(
                              shrinkWrap: true,
                              itemCount: allProductsData.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 300,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      allProductsData[index]['p_imgs'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allProductsData[index]['p_name']}"
                                        .text
                                        .color(palettesTen)
                                        .fontFamily(semibold)
                                        .make(),
                                    10.heightBox,
                                    "${allProductsData[index]['p_price']}"
                                        .text
                                        .color(palettesSix)
                                        .fontFamily(semibold)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .color(palettesEight)
                                    .rounded
                                    .margin(
                                      const EdgeInsets.symmetric(horizontal: 4),
                                    )
                                    .padding(
                                      const EdgeInsets.all(12),
                                    )
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                        title: allProductsData[index]['p_name'],
                                        data: allProductsData[index],
                                      ));
                                });
                              },
                            );
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
