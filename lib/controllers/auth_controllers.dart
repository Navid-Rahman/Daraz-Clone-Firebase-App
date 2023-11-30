import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Text Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  /// Login Method
  Future<UserCredential?> loginMethod({
    context,
  }) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    } catch (e) {
      print(e);
    }

    return userCredential;
  }

  /// Register Method
  Future<UserCredential?> signupMethod({
    email,
    password,
    context,
  }) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    } catch (e) {
      print(e);
    }

    return userCredential;
  }

  /// Store User Data
  storeUserData({
    name,
    email,
    password,
  }) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);

    store.set({
      'name': name,
      'email': email,
      'password': password,
      'photoUrl': '',
      'id': currentUser!.uid,
    });
  }

  /// Logout Method
  signoutMethod(
    context,
  ) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
