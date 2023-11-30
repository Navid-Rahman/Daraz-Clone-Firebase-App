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
}
