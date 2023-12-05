import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import 'home_controller.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  // Textcontroller for the shipping details screen
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;

  var products = [];

  var placingOrder = false.obs;

  calculateTotalPrice(data) {
    for (var i = 0; i < data.length; i++) {
      totalPrice.value = 0;

      totalPrice.value =
          totalPrice.value + int.parse(data[i]['price'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder.value = true;

    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city': cityController.text,
      'order_by_state': stateController.text,
      'order_by_postal_code': postalCodeController.text,
      'order_by_phone_number': phoneNumberController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_code': 'E-Mart-${DateTime.now().millisecondsSinceEpoch}',
      'order_confirmed': false,
      'order_on_delivery': false,
      'order_delivered': false,
      'order_date': DateTime.now(),
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
    });

    placingOrder.value = false;
  }

  getProductDetails() async {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'price': productSnapshot[i]['price'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
