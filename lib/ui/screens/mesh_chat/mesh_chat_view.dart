import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/mesh_chat_bubble.dart';
import 'package:mindmesh/ui/custom_widgets/mindmesh_textfield.dart';
import 'package:mindmesh/ui/screens/mesh_chat/mesh_chat_view_model.dart';
import 'package:provider/provider.dart';

class MeshChatView extends StatelessWidget {
  const MeshChatView({super.key});
  static const String id = 'MeshChatView';
  @override
  Widget build(BuildContext context) {
    final iconBrightness = Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        statusBarColor: kCTransparentColor,
      ),
      child: Consumer<MeshChatViewModel>(
        builder: (context, model, child) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).iconTheme.color,
                    size: IconSize.homeConIconSize,
                  ),
                  onPressed: () => model.pop(),
                ),
                title: Text(
                  AppStrings.mesh,
                  style: Theme.of(context).textTheme.displayLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                bottom: PreferredSize(
                  preferredSize: Size(screenWidth(context), 40),
                  child: TabBar(
                    isScrollable: true,
                    overlayColor: WidgetStateColor.transparent,
                    tabAlignment: TabAlignment.center,
                    indicatorColor: kCGreenColor,
                    indicatorWeight: 3,
                    dividerHeight: 0,
                    // dividerColor: kCGreenColor,
                    labelPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                    tabs: [
                      Text(AppStrings.geminiAI, style: Theme.of(context).textTheme.displayMedium,),
                      Text(AppStrings.qwenAI, style: Theme.of(context).textTheme.displayMedium,),
                      Text(AppStrings.chatGPTAI, style: Theme.of(context).textTheme.displayMedium,),
                      Text(AppStrings.deepseekAI, style: Theme.of(context).textTheme.displayMedium,),
                    ],
                  ),
                ),
              ),
              body: Stack(
                children: [
                  TabBarView(
                    children: [
                      //gemini tab
                      MeshChatBubble(
                          scrollController: model.geminiScrollController,
                          itemCount: model.geminiMessages.length,
                        messages: model.geminiMessages,
                        aiImage: AppStrings.gemini,
                      ),

                      //qwen tab
                      MeshChatBubble(
                        scrollController: model.qwenScrollController,
                        itemCount: model.qwenMessages.length,
                        messages: model.qwenMessages,
                        aiImage: AppStrings.qwen,
                        ),

                      //chatGPT tab
                      MeshChatBubble(
                        scrollController: model.chatGPTScrollController,
                        itemCount: model.chatGPTMessages.length,
                        messages: model.chatGPTMessages,
                        aiImage: AppStrings.openAI,
                      ),

                      //deepseek tab
                      MeshChatBubble(
                        scrollController: model.deepseekScrollController,
                        itemCount: model.deepseekMessages.length,
                        messages: model.deepseekMessages,
                        aiImage: AppStrings.deepseek,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MindmeshTextfield(
                      image: model.pickedImage?.path,
                      file: model.pickedFile?.first.name,
                      visible: model.showOptions,
                      fileVisible: model.showFile,
                      controller: model.textController,
                      onTap: model.sendMessageToAll,
                      onDoubleTap: model.updateShowOptions,
                      pickFiles: model.pickFile,
                      pickImageFromGallery: (){
                        model.pickImage(ImageSource.gallery);
                      },
                      pickImageFromCamera: (){
                        model.pickImage(ImageSource.camera);
                      },
                      onDeleteFile: model.deleteFile,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
