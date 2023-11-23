import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/utils/widgets/custom_button.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline_rounded,
            ),
          ),
        ],
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
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            imgFc5,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }),

                    10.heightBox,

                    /// Title and Details Section
                    title!.text
                        .size(18)
                        .color(darkFontGrey)
                        .fontFamily(bold)
                        .make(),
                    10.heightBox,

                    /// Rating Section
                    VxRating(
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,
                    ),

                    10.heightBox,
                    "Rs. 1,000"
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
                              "In House Brands"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .size(16)
                                  .make(),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_outlined,
                            color: darkFontGrey,
                          ),
                        )
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ))
                        .rounded
                        .color(textfieldGrey)
                        .make(),

                    /// Colors section
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color"
                                  .text
                                  .fontFamily(semibold)
                                  .color(textfieldGrey)
                                  .make(),
                            ),
                            Row(
                              children: List.generate(
                                  3,
                                  (index) => VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 6))
                                      .color(Vx.randomPrimaryColor)
                                      .make()),
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
                                  .color(textfieldGrey)
                                  .make(),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove),
                                ),
                                "0"
                                    .text
                                    .size(16)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                                10.widthBox,
                                "(0 Available)"
                                    .text
                                    .size(16)
                                    .fontFamily(semibold)
                                    .color(textfieldGrey)
                                    .make(),
                              ],
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
                                  .color(textfieldGrey)
                                  .make(),
                            ),
                            "Rs. 1,000"
                                .text
                                .size(16)
                                .fontFamily(bold)
                                .color(redColor)
                                .make(),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),

                    /// Description Section
                    10.heightBox,
                    "Description:"
                        .text
                        .size(18)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),

                    10.heightBox,
                    "This is a dummy item and a dummy description for the .... Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
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
                        ),
                      ),
                    ),

                    /// Similar Items Section
                    20.heightBox,

                    productsYouMayAlsoLike.text
                        .fontFamily(bold)
                        .color(darkFontGrey)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const EdgeInsets.symmetric(horizontal: 4),
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
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: customButton(
              title: "Add to Cart",
              color: redColor,
              textColor: whiteColor,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
