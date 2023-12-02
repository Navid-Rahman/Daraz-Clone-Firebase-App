import 'package:daraz_idea_firebase/controllers/chats_controller.dart';
import 'package:daraz_idea_firebase/presentation/chat_screen/widgets/senders_bubble.dart';
import 'package:get/get.dart';

import '../../constants/consts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Chat".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
                child: ListView(
                  children: [
                    senderBubble(),
                    senderBubble(),
                  ],
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey),
                      ),
                      filled: true,
                      fillColor: lightGrey,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                ),
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .roundedSM
                .color(lightGrey)
                .make(),
          ],
        ),
      ),
    );
  }
}
