import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/constants/lists.dart';
import 'package:daraz_idea_firebase/controllers/product_controller.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:get/get.dart';

import 'categories_details.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            categories,
            style: TextStyle(
              fontFamily: bold,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: 200,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      categoriesImages[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      categoriesLists[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: darkFontGrey,
                      ),
                    ),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  controller.getSubCategories(categoriesLists[index]);
                  Get.to(
                    () => CategoryDetails(
                      title: categoriesLists[index],
                    ),
                  );
                });
              }),
        ),
      ),
    );
  }
}
