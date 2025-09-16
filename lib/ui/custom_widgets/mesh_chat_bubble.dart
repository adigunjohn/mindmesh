import 'package:flutter/material.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/ui/custom_widgets/chat_bubble.dart';

class MeshChatBubble extends StatelessWidget {
  const MeshChatBubble({super.key,
    required this.scrollController,
    required this.itemCount,
    required this.messages,
    required this.aiImage,
  });
  final List<Message> messages;
  final ScrollController? scrollController;
  final int itemCount;
  final String aiImage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          thickness: 6,
          radius: Radius.circular(25),
          controller: scrollController,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 90, top: 15),
            controller: scrollController,
            reverse: true,
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              return ChatBubble(aiImage: aiImage, message: message.text, isUser: message.isUser, time: message.time, image: message.image, file: message.file,);
            },
          ),
        ),
      ),
    );
  }
}
