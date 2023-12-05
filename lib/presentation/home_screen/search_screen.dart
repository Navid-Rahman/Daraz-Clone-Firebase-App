import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/services/firestore_services.dart';
import 'package:get/get.dart';

import '../categories/items_details.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: query.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: FutureBuilder(
          future: FirestoreServices.searchProducts(query),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No products found"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filteredData = data
                  .where((element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 300,
                  ),
                  children: filteredData
                      .mapIndexed(
                        (currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              filteredData[index]['p_imgs'][0],
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "${filteredData[index]['p_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            10.heightBox,
                            "${filteredData[index]['p_price']}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .outerShadowMd
                            .rounded
                            .margin(
                              const EdgeInsets.symmetric(horizontal: 4),
                            )
                            .padding(
                              const EdgeInsets.all(12),
                            )
                            .make()
                            .onTap(() {
                          Get.to(() => ItemDetails(
                                title: filteredData[index]['p_name'],
                                data: filteredData[index],
                              ));
                        }),
                      )
                      .toList(),
                ),
              );
            }
          }),
    );
  }
}
