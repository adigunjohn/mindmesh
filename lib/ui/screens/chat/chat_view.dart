import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmesh/enums/ai.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/chat_bubble.dart';
import 'package:mindmesh/ui/custom_widgets/mindmesh_textfield.dart';
import 'package:mindmesh/ui/screens/chat/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, this.whichAI});
  static const String id = 'ChatView';
  final AI? whichAI;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50),() => context.read<ChatViewModel>().chatType(widget.whichAI));
  }
  @override
  Widget build(BuildContext context) {
    final iconBrightness = Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        statusBarColor: kCTransparentColor,
      ),
      child: Consumer<ChatViewModel>(
        builder: (context, model, child) {
          return PopScope(
            onPopInvokedWithResult: (x,y){
              model.deleteFile();
            },
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded, color: Theme.of(context).iconTheme.color, size: IconSize.homeConIconSize,),
                  onPressed: () => model.pop(),
                ),
                title: Text(model.chatTitle, style: Theme.of(context).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,),
                actions: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.sort_rounded, color: Theme.of(context).iconTheme.color, size: IconSize.homeConIconSize,),
                    onSelected: (value) {
                      model.updateSelectedModelVersion(widget.whichAI,value);
                    },
                    // initialValue: model.selectedModelVersion,
                    itemBuilder: (BuildContext context) {
                      return model.modelVersion!.map((String category) {
                        bool isSelected = category == model.selectedModelVersion;
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
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Scrollbar(
                            thickness: 6,
                            radius: Radius.circular(25),
                            controller: model.scrollController,
                            child: ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 90),
                              controller: model.scrollController,
                              itemCount: model.messages.length,
                              itemBuilder: (context, index) {
                                final message = model.messages[model.messages.length - 1 - index];
                                return ChatBubble(aiImage: model.chatImage!, message: message.text, isUser: message.isUser, time: message.time, image: message.image, file: message.file);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MindmeshTextfield(
                      image: model.pickedImage?.path,
                      file: model.pickedFile?.first.name,
                      visible: model.showOptions,
                      controller: model.textController,
                      onTap:(){model.sendMessage(widget.whichAI);},
                      onDoubleTap: model.updateShowOptions,
                      pickFiles: model.pickFile,
                      pickImageFromCamera: (){
                        model.pickImage(ImageSource.camera);
                      },
                      pickImageFromGallery: (){
                        model.pickImage(ImageSource.gallery);
                      },
                      onDeleteFile: model.deleteFile,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
