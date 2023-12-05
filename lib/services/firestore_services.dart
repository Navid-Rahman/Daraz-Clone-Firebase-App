import 'package:daraz_idea_firebase/constants/consts.dart';

class FirestoreServices {
  /// Get users data
  static getUser(String uid) {
    return firestore
        .collection(usersCollection)
        .where(
          'id',
          isEqualTo: uid,
        )
        .snapshots();
  }

  /// Get products data
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  /// Get Subcategory products data
  static getSubcategoryProducts(subcategory) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: subcategory)
        .snapshots();
  }

  /// Get cart data
  static getCart(String uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  /// Delete cart item
  static deleteCartItem(String id) {
    return firestore.collection(cartCollection).doc(id).delete();
  }

  /// Get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  /// Get all my orders
  static getMyOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  /// Get all my wishlist
  static getMyWishlist() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  /// Get all my messages
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  /// Get all counts
  static getCounts() async {
    var data = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(productsCollection)
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);

    return data;
  }

  /// Get all products
  static getAllProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  /// Get featured products
  static getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  /// Get search products
  static searchProducts(String query) {
    return firestore
        .collection(productsCollection)
        .where('p_name', isLessThanOrEqualTo: query)
        .get();
  }
}
