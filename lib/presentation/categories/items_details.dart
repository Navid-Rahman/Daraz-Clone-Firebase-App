import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: palettesFour,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: title!.text.color(whiteColor).fontFamily(bold).make(),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: palettesFive,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isFavourite.value) {
                    controller.removeFromWishlist(data.id, context);
                  } else {
                    controller.addToWishlist(data.id, context);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFavourite.value
                      ? palettesTwo
                      : palettesEight,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: customButton(
            title: "Add to Cart",
            color: palettesTwo,
            textColor: whiteColor,
            width: double.infinity,
            borderRadius: 0,
            onPressed: () {
              if (controller.quantity.value > 0) {
                controller.addToCart(
                  title: data['p_name'],
                  image: data['p_imgs'][0],
                  sellerName: data['p_seller'],
                  totalPrice: controller.totalPrice.value,
                  quantity: controller.quantity.value,
                  vendorId: data['vendor_id'],
                  color: data['p_colors'][controller.colorIndex.value],
                  context: context,
                );
                VxToast.show(context, msg: "Added to Cart");
              } else {
                VxToast.show(context, msg: "Please select at least 1 quantity");
              }
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          itemCount: data['p_imgs'].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),

                      10.heightBox,

                      /// Title and Details Section
                      title!.text
                          .size(18)
                          .color(palettesTwo)
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,

                      /// Rating Section
                      VxRating(
                        value: double.parse(data['p_rating'].toString()),
                        onRatingUpdate: (value) {},
                        normalColor: palettesThree,
                        selectionColor: palettesTwo,
                        isSelectable: false,
                        count: 5,
                        maxRating: 5,
                        size: 25,
                        // stepInt: true,
                      ),

                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrencyWithLocale(
                            locale: 'en_US',
                          )
                          .text
                          .size(18)
                          .color(redColor)
                          .fontFamily(bold)
                          .make(),

                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                "Seller".text.white.fontFamily(semibold).make(),
                                5.heightBox,
                                "${data['p_seller']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(palettesFour)
                                    .size(16)
                                    .make(),
                              ],
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.mark_unread_chat_alt_outlined,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ))
                          .rounded
                          .color(palettesFive)
                          .make(),

                      /// Colors section
                      20.heightBox,
                      Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Color"
                                      .text
                                      .fontFamily(semibold)
                                      .color(palettesSix)
                                      .make(),
                                ),
                                Row(
                                  children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 6))
                                            .color(Color(int.parse(
                                                    data['p_colors'][index]
                                                        .toString()))
                                                .withOpacity(1))
                                            .make()
                                            .onTap(() {
                                          controller.changeColorIndex(index);
                                        }),
                                        Visibility(
                                          visible: index ==
                                              controller.colorIndex.value,
                                          child: const Icon(Icons.done,
                                              color: whiteColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            /// Quantity Section
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity"
                                      .text
                                      .fontFamily(semibold)
                                      .color(palettesSix)
                                      .make(),
                                ),
                                Obx(
                                  () => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.decrementQuantity();
                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      controller.quantity.value.text
                                          .size(16)
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      IconButton(
                                        onPressed: () {
                                          controller.incrementQuantity(
                                              int.parse(data['p_quantity']));

                                          controller.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      10.widthBox,
                                      "(${data['p_quantity']} Available)"
                                          .text
                                          .size(16)
                                          .fontFamily(semibold)
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),

                            /// Total Price Row
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total Price"
                                      .text
                                      .fontFamily(semibold)
                                      .color(palettesSix)
                                      .make(),
                                ),
                                "${controller.totalPrice.value}"
                                    .numCurrencyWithLocale(
                                      locale: 'en_US',
                                    )
                                    .text
                                    .size(16)
                                    .fontFamily(bold)
                                    .color(redColor)
                                    .make(),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.rounded.color(whiteColor).shadowSm.make(),
                      ),

                      /// Description Section
                      20.heightBox,
                      "Description:"
                          .text
                          .size(18)
                          .fontFamily(semibold)
                          .color(palettesTwo)
                          .make(),

                      10.heightBox,
                      "${data['p_desc']}"
                          .text
                          .fontFamily(semibold)
                          .color(palettesOne)
                          .make(),

                      10.heightBox,

                      /// Buttons Section
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          itemDetailsButtonLists.length,
                          (index) => ListTile(
                            title: itemDetailsButtonLists[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                            onTap: () {},
                          )
                              .box
                              .color(whiteColor)
                              .margin(
                                const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                              )
                              .rounded
                              .make(),
                        ),
                      ),

                      /// Similar Items Section
                      20.heightBox,

                      productsYouMayAlsoLike.text
                          .fontFamily(bold)
                          .color(palettesTwo)
                          .size(16)
                          .make(),

                      10.heightBox,

                      /// Similar Items List
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
                                      "Ferrari Portofino"
                                          .text
                                          .color(palettesTwo)
                                          .fontFamily(semibold)
                                          .make(),
                                      10.heightBox,
                                      "Rs. 1,00,00,00000"
                                          .text
                                          .color(palettesSeven)
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
                                      .color(palettesThree)
                                      .padding(const EdgeInsets.all(8))
                                      .make()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
