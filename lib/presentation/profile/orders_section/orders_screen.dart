import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:get/get.dart';

import 'orders_details.dart';

class OrdersScreen extends StatelessWidget {
  final dynamic data;
  const OrdersScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: palettesFour,
      appBar: AppBar(
        title: "My Orders".text.color(whiteColor).fontFamily(semibold).make(),
        iconTheme: const IconThemeData(color: whiteColor),
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
            var data = snapshot.data!.docs;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // leading: "${index + 1}"
                    //     .text
                    //     .fontFamily(bold)
                    //     .color(darkFontGrey)
                    //     .xl
                    //     .make(),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: palettesThree,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: palettesTwo, width: 2),
                      ),
                      child: Center(
                        child: "${index + 1}"
                            .text
                            .fontFamily(bold)
                            .color(whiteColor)
                            .xl
                            .make(),
                      ),
                    ),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .fontFamily(bold)
                        .make(),
                    trailing: IconButton(
                      icon: const Icon(Icons.double_arrow_outlined,
                          color: palettesFive, size: 40),
                      onPressed: () {
                        Get.to(() => OrdersDetails(
                              data: data[index],
                            ));
                      },
                    ),
                  )
                      .box
                      .rounded
                      .color(palettesTen)
                      .border(color: palettesTwo, width: 2)
                      .make()
                      .p8();
                });
          }
        },
      ),
    );
  }
}
