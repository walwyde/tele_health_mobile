import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final controller = Get.put(ChatController());
  final input = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      appBar: AppBar(
        title: const Text("AI Medical Assistant"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    final isAI = msg['sender'] == 'ai';

                    return Align(
                      alignment:
                          isAI ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints(maxWidth: 280),
                        decoration: BoxDecoration(
                          color: isAI ? Colors.white : Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: Text(
                          msg['text'],
                          style: TextStyle(
                            color: isAI ? Colors.black87 : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),

          Obx(() => controller.isTyping.value
              ? const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("AI is typing...",
                      style: TextStyle(color: Colors.blueGrey)),
                )
              : const SizedBox()),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: input,
                    decoration: const InputDecoration(
                      hintText: "Ask a question...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    if (input.text.trim().isEmpty) return;
                    controller.sendUserMessage(input.text);
                    input.clear();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
