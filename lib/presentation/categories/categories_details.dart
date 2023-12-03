import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import 'items_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.white.fontFamily(bold).make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No Products Found",
                  style: TextStyle(
                    color: darkFontGrey,
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              var data = snapshot.data!.docs;

              return Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          controller.subcat.length,
                          (index) => "${controller.subcat[index]}"
                              .text
                              .size(12)
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .makeCentered()
                              .box
                              .rounded
                              .size(120, 50)
                              .margin(const EdgeInsets.symmetric(
                                horizontal: 4,
                              ))
                              .white
                              .make(),
                        ),
                      ),
                    ),

                    /// Items Container

                    20.heightBox,

                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data[index]['p_imgs'][0],
                                height: 150,
                                width: 200,
                                fit: BoxFit.cover,
                              ).box.roundedSM.clip(Clip.antiAlias).make(),
                              10.heightBox,
                              "${data[index]['p_name']}"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(semibold)
                                  .make(),
                              10.heightBox,
                              " ${data[index]['p_price']}"
                                  .numCurrencyWithLocale(
                                    locale: 'en_IN',
                                  )
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .rounded
                              .outerShadowSm
                              .margin(
                                const EdgeInsets.symmetric(horizontal: 4),
                              )
                              .padding(
                                const EdgeInsets.all(12),
                              )
                              .make()
                              .onTap(() {
                            controller.checkIfFavourite(data[index]);
                            Get.to(
                              () => ItemDetails(
                                title: "${data[index]['p_name']}",
                                data: data[index],
                              ),
                            );
                          });
                        },
                      ),
                    ),
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
