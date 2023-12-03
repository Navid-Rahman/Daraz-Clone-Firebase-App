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
}
