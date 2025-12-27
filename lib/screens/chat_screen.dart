// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/chat_controller.dart';

// class ChatScreen extends StatelessWidget {
//   ChatScreen({super.key});

//   final controller = Get.put(ChatController());
//   final input = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F7FF),
//       appBar: AppBar(
//         title: const Text("AI Medical Assistant"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() => ListView.builder(
//                   padding: const EdgeInsets.all(20),
//                   itemCount: controller.messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = controller.messages[index];
//                     final isAI = msg['sender'] == 'ai';

//                     return Align(
//                       alignment:
//                           isAI ? Alignment.centerLeft : Alignment.centerRight,
//                       child: Container(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         padding: const EdgeInsets.all(16),
//                         constraints: const BoxConstraints(maxWidth: 280),
//                         decoration: BoxDecoration(
//                           color: isAI ? Colors.white : Colors.blueAccent,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 8,
//                             )
//                           ],
//                         ),
//                         child: Text(
//                           msg['text'],
//                           style: TextStyle(
//                             color: isAI ? Colors.black87 : Colors.white,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           ),

//           Obx(() => controller.isTyping.value
//               ? const Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Text("AI is typing...",
//                       style: TextStyle(color: Colors.blueGrey)),
//                 )
//               : const SizedBox()),

//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: input,
//                     decoration: const InputDecoration(
//                       hintText: "Ask a question...",
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Colors.blueAccent),
//                   onPressed: () {
//                     if (input.text.trim().isEmpty) return;
//                     controller.sendUserMessage(input.text);
//                     input.clear();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final controller = Get.put(ChatController());
  final TextEditingController input = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Column(
          children: [
            const Text("Medical AI Assistant", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Obx(() => Text(
              controller.isChatActive.value ? "Online" : "Conversation Ended",
              style: TextStyle(
                fontSize: 12,
                color: controller.isChatActive.value ? Colors.green : Colors.red,
                fontWeight: FontWeight.normal,
              ),
            )),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              _scrollToBottom();
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(20),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isAI = msg['sender'] == 'ai';
                  return _buildMessageBubble(msg['text'], isAI);
                },
              );
            }),
          ),

          // Typing Indicator
          Obx(() => controller.isTyping.value
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "AI is thinking...",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox()),

          // Session Closed Banner
          Obx(() => !controller.isChatActive.value
              ? Container(
                  width: double.infinity,
                  color: Colors.red.withOpacity(0.1),
                  padding: const EdgeInsets.all(12),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Colors.redAccent, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Chat Ended - You can review messages but cannot send new ones",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox()),

          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isAI) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isAI ? Colors.white : Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isAI ? 0 : 20),
            bottomRight: Radius.circular(isAI ? 20 : 0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isAI ? Colors.black87 : Colors.white,
            height: 1.5,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Obx(() {
      final bool isActive = controller.isChatActive.value;
      return Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: input,
                enabled: isActive,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: isActive
                      ? "Ask a question or mention symptoms..."
                      : "Chat is locked",
                  hintStyle: TextStyle(
                    color: isActive ? Colors.grey : Colors.grey.shade400,
                  ),
                  filled: true,
                  fillColor: isActive
                      ? const Color(0xFFF4F7FF)
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? Colors.blueAccent
                    : Colors.grey.shade300,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: isActive ? Colors.white : Colors.grey,
                ),
                onPressed: isActive
                    ? () {
                        if (input.text.trim().isEmpty) return;
                        controller.sendUserMessage(input.text.trim());
                        input.clear();
                      }
                    : null,
              ),
            )
          ],
        ),
      );
    });
  }
}