import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/domain/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var subcat = [];

  var isFavourite = false.obs;

  getSubCategories(title) async {
    subcat.clear();

    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decoded = categoryModelFromJson(data);

    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subCategories) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

  incrementQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decrementQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart(
      {title, image, sellerName, totalPrice, quantity, color, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'image': image,
      'sellerName': sellerName,
      'price': totalPrice,
      'quantity': quantity,
      'color': color,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    quantity.value = 0;
    colorIndex.value = 0;
    totalPrice.value = 0;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isFavourite.value = true;
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFavourite.value = false;
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFavourite(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFavourite.value = true;
    } else {
      isFavourite.value = false;
    }
  }
}
