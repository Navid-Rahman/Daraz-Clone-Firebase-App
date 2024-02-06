import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palettesFour,
      appBar: AppBar(
        title: "My Wishlist".text.color(whiteColor).fontFamily(semibold).make(),
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getMyWishlist(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Wishlist yet".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          data[index]['p_imgs'][0],
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: data[index]['p_price']
                            .toString()
                            .numCurrency
                            .text
                            .color(redColor)
                            .make(),
                        trailing: IconButton(
                          onPressed: () async {
                            await firestore
                                .collection(productsCollection)
                                .doc(data[index].id)
                                .set({
                              'p_wishlist':
                                  FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: redColor,
                          ),
                        ),
                      ).box.roundedSM.shadowSm.color(whiteColor).make();
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
