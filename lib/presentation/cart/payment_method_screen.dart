import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/widgets/custom_button.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Choose Payment Method".text.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        width: context.screenWidth,
        height: 60,
        child: customButton(
          color: redColor,
          textColor: whiteColor,
          title: "Place Order",
          onPressed: () {
            controller.placeMyOrder(
                orderPaymentMethod:
                    paymentMethodTitle[controller.paymentIndex.value],
                totalAmount: controller.totalPrice.value);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(
                paymentMethodListImage.length,
                (index) => GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodListImage[index],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    activeColor: redColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : const SizedBox(),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: paymentMethodTitle[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
