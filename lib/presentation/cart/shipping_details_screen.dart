import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/presentation/cart/payment_method_screen.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/custom_textfields.dart';

class ShippingDetailsScreen extends StatelessWidget {
  const ShippingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        width: context.screenWidth,
        height: 60,
        child: customButton(
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
          onPressed: () {
            if (controller.addressController.text.isNotEmpty &&
                controller.cityController.text.isNotEmpty &&
                controller.stateController.text.isNotEmpty &&
                controller.postalCodeController.text.isNotEmpty &&
                controller.phoneNumberController.text.isNotEmpty) {
              Get.to(() => const PaymentMethodScreen());
            } else {
              VxToast.show(context, msg: "Please fill all fields");
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              /// Name
              customTextField(
                title: "Address",
                hint: "Enter your address",
                controller: controller.addressController,
                isPassword: false,
              ),

              /// Phone
              customTextField(
                title: "City",
                hint: "Enter your city",
                controller: controller.cityController,
                isPassword: false,
              ),

              /// Address
              customTextField(
                title: "State",
                hint: "Enter your state",
                controller: controller.stateController,
                isPassword: false,
              ),

              /// City
              customTextField(
                title: "Postal Code",
                hint: "Enter your postal code",
                controller: controller.postalCodeController,
                isPassword: false,
              ),

              /// Country
              customTextField(
                title: "Phone Number",
                hint: "Enter your phone number",
                controller: controller.phoneNumberController,
                isPassword: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
