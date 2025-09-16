import 'package:flutter/material.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/chat_bubble.dart';

class MeshChatBubble extends StatelessWidget {
  const MeshChatBubble({super.key,
   required this.popMenuList,
    required this.selectedModelVersion,
    required this.scrollController,
    required this.itemCount,
    required this.messages,
    required this.aiImage,
    required this.onSelected,
  });

  final void Function(String) onSelected;
  final List<String> popMenuList;
  final List<Message> messages;
  final String? selectedModelVersion;
  final ScrollController? scrollController;
  final int itemCount;
  final String aiImage;
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: screenWidth(context)/1.33,
                child: Text(AppStrings.changeModel, maxLines: 1,style: Theme.of(context).textTheme.displaySmall,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),),
            PopupMenuButton<String>(
              onSelected: onSelected,
              // initialValue: model.selectedModelVersion,
              itemBuilder: (BuildContext context) {
                return popMenuList.map((String category) {
                  bool isSelected = category == selectedModelVersion;
                  return PopupMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: isSelected ? 15 : 12,
                          fontStyle: isSelected ? FontStyle.italic : FontStyle.normal),
                    ),
                  );
                }).toList();
              },
              child: Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).iconTheme.color, size: IconSize.chatBubbleIconSize,),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: Scrollbar(
              thickness: 6,
              radius: Radius.circular(25),
              controller: scrollController,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 90, top: 8),
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
        ),
      ],
    );
  }
}
