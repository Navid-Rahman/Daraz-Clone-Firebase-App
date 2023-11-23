import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/presentation/home_screen/widgets/featured_button.dart';
import 'package:daraz_idea_firebase/utils/widgets/home_buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
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
                decoration: InputDecoration(
                  hintText: searchAnything,
                  hintStyle: const TextStyle(
                    color: textfieldGrey,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: textfieldGrey,
                  ),
                  filled: true,
                  fillColor: whiteColor,
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
                          width: context.screenWidth / 2.5,
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
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                              )),
                    ),

                    10.heightBox,

                    /// Featured Categories
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
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
                        color: redColor,
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
                            child: Row(
                              children: List.generate(
                                  6,
                                  (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            imgP1,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          10.heightBox,
                                          "Lenovo Ideapad 320"
                                              .text
                                              .color(darkFontGrey)
                                              .fontFamily(semibold)
                                              .make(),
                                          10.heightBox,
                                          "Rs. 50,000"
                                              .text
                                              .color(redColor)
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
                                          .white
                                          .padding(const EdgeInsets.all(8))
                                          .make()),
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
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
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
                            Image.asset(
                              imgP5,
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "Lenovo Ideapad 320"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            10.heightBox,
                            "Rs. 50,000"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .rounded
                            .margin(
                              const EdgeInsets.symmetric(horizontal: 4),
                            )
                            .padding(
                              const EdgeInsets.all(12),
                            )
                            .make();
                      },
                    ),
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
