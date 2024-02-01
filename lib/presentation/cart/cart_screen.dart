import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/controllers/cart_controller.dart';
import 'package:daraz_idea_firebase/presentation/cart/shipping_details_screen.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:get/get.dart';

import '../../utils/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: palettesFour,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            "Shopping Cart".text.color(whiteColor).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        width: context.screenWidth,
        height: 60,
        child: customButton(
          color: palettesTwo,
          textColor: whiteColor,
          borderRadius: 0,
          width: context.screenWidth,
          title: "Proceed to Checkout",
          onPressed: () {
            Get.to(() => const ShippingDetailsScreen());
          },
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "No items in cart".text.color(palettesTwo).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculateTotalPrice(data);
            controller.productSnapshot = data;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            data[index]['image'],
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          title:
                              "${data[index]['title']}  (x${data[index]['quantity']})"
                                  .text
                                  .color(palettesTwo)
                                  .fontFamily(semibold)
                                  .make(),
                          subtitle: data[index]['price']
                              .toString()
                              .numCurrency
                              .text
                              .color(redColor)
                              .make(),
                          trailing: IconButton(
                            onPressed: () {
                              FirestoreServices.deleteCartItem(data[index].id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: redColor,
                            ),
                          ),
                        )
                            .box
                            .rounded
                            .color(palettesTen)
                            .shadowSm
                            .padding(const EdgeInsets.all(8))
                            .make();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .color(palettesTwo)
                          .fontFamily(semibold)
                          .make(),
                      Obx(
                        () => controller.totalPrice.value.numCurrency.text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                      ),
                    ],
                  )
                      .box
                      .padding(const EdgeInsets.all(12))
                      .color(palettesTen)
                      .shadowSm
                      .roundedSM
                      .make(),
                  10.heightBox,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
