import 'package:daraz_idea_firebase/constants/consts.dart';
import 'package:daraz_idea_firebase/utils/widgets/bg_widget.dart';
import 'package:get/get.dart';

import 'items_details.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .rounded
                        .size(120, 50)
                        .margin(const EdgeInsets.symmetric(
                          horizontal: 4,
                        ))
                        .white
                        .make(),
                  ),
                ),
              ),

              /// Items Container

              20.heightBox,

              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 6,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imgP5,
                          height: 150,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        "Lenovo Ideapad 320"
                            .text
                            .color(darkFontGrey)
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        "Rs. 50,000"
                            .text
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .outerShadowSm
                        .margin(
                          const EdgeInsets.symmetric(horizontal: 4),
                        )
                        .padding(
                          const EdgeInsets.all(12),
                        )
                        .make()
                        .onTap(() {
                      Get.to(
                        () => ItemDetails(
                          title: "Lenovo Ideapad 320",
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
