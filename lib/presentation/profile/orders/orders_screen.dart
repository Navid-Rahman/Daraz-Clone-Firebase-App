import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getMyOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders yet".text.color(darkFontGrey).makeCentered();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
