import 'package:flutter/material.dart';
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
    return Consumer<MeshChatViewModel>(
      builder: (context, model, child) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              surfaceTintColor: kCTransparentColor,
              backgroundColor: kCTransparentColor,
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
                    Text(AppStrings.chatGPTAI, style: Theme.of(context).textTheme.displayMedium,),
                    Text(AppStrings.claudeAI, style: Theme.of(context).textTheme.displayMedium,),
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
                        popMenuList: model.geminiModelVersion,
                        selectedModelVersion: model.geminiSelectedModelVersion,
                        scrollController: model.geminiScrollController,
                        itemCount: model.geminiMessages.length,
                      messages: model.geminiMessages,
                      aiImage: AppStrings.gemini,
                      onSelected: (value){
                        model.updateGeminiSelectedModelVersion(value);
                      },),

                    //chatGPT tab
                    MeshChatBubble(
                      popMenuList: model.chatGPTModelVersion,
                      selectedModelVersion: model.chatGPTSelectedModelVersion,
                      scrollController: model.chatGPTScrollController,
                      itemCount: model.chatGPTMessages.length,
                      messages: model.chatGPTMessages,
                      aiImage: AppStrings.openAI,
                      onSelected: (value){
                        model.updateChatGPTSelectedModelVersion(value);
                      },),

                    //claude tab
                    MeshChatBubble(
                      popMenuList: model.claudeModelVersion,
                      selectedModelVersion: model.claudeSelectedModelVersion,
                      scrollController: model.claudeScrollController,
                      itemCount: model.claudeMessages.length,
                      messages: model.claudeMessages,
                      aiImage: AppStrings.claude,
                      onSelected: (value){
                        model.updateClaudeSelectedModelVersion(value);
                      },),

                    //deepseek tab
                    MeshChatBubble(
                      popMenuList: model.deepseekModelVersion,
                      selectedModelVersion: model.deepseekSelectedModelVersion,
                      scrollController: model.deepseekScrollController,
                      itemCount: model.deepseekMessages.length,
                      messages: model.deepseekMessages,
                      aiImage: AppStrings.deepseek,
                      onSelected: (value){
                        model.updateDeepseekSelectedModelVersion(value);
                      },),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MindmeshTextfield(
                    controller: model.textController,
                    onTap: () {
                      model.sendMessageToAll();
                    },
                    onDoubleTap: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
