import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindmesh/enums/ai.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/circle_button.dart';
import 'package:mindmesh/ui/custom_widgets/home_con.dart';
import 'package:mindmesh/ui/custom_widgets/home_tiles.dart';
import 'package:mindmesh/ui/screens/chat/chat_view.dart';
import 'package:mindmesh/ui/screens/home/home_view_model.dart';
import 'package:mindmesh/ui/screens/mesh_chat/mesh_chat_view.dart';
import 'package:mindmesh/ui/screens/settings/settings_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    final iconBrightness = Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        statusBarColor: kCTransparentColor,
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: SizedBox(
                height: screenHeight(context),
                width: screenWidth(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                    // bottom: 0,
                    top: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.mindMesh,
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 5,),
                              Icon(Icons.eco_rounded, size: 25, color: kCGreenColor,)
                            ],
                          ),
                          Row(
                            children: [
                              CircleButton(onTap: null, image: AppStrings.dp1, useImage: true,),
                              SizedBox(width: 5,),
                              CircleButton(
                                icon: Icons.menu_open_outlined,
                                onTap: () {
                                  model.navigateNamed(SettingsView.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppStrings.hi,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        AppStrings.greetings,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          HomeCon(
                            onTap: () {
                              model.navigateNamed(MeshChatView.id);
                            },
                            maxLines: 5,
                            color: kCCustomTeal,
                            icon: CupertinoIcons.chat_bubble_2,
                            height: screenHeight(context) / 2.8,
                            width: screenWidth(context) / 2.3,
                            text: AppStrings.engageMultipleAIs,
                          ),
                          Spacer(),
                          Column(
                            children: [
                              HomeCon(
                                onTap: () {
                                  model.navigate(ChatView(whichAI: AI.gemini));
                                },
                                maxLines: 2,
                                color: kCCustomLightBlue,
                                icon: CupertinoIcons.sparkles,
                                height: screenHeight(context) / 6,
                                width: screenWidth(context) / 2.3,
                                text: AppStrings.converseWithGeminiAI,
                              ),
                              SizedBox(
                                height:
                                    (screenHeight(context) / 2.8 -
                                        (screenHeight(context) / 6 +
                                            screenHeight(context) / 6)),
                              ),
                              HomeCon(
                                onTap: () {
                                  model.navigate(ChatView(whichAI: AI.chatGPT));
                                },
                                maxLines: 2,
                                color: kCCustomIndigo,
                                icon: Icons.ac_unit_outlined,
                                height: screenHeight(context) / 6,
                                width: screenWidth(context) / 2.3,
                                text: AppStrings.converseWithChatGPTAI,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppStrings.featuredAI,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            HomeTiles(
                              onTap: () {
                                model.navigate(ChatView(whichAI: AI.gemini));
                              },
                              title: AppStrings.geminiAI,
                              subTitle: AppStrings.geminiSub,
                              image: AppStrings.gemini,
                            ),
                            HomeTiles(
                              onTap: () {
                                model.navigate(ChatView(whichAI: AI.qwen));
                              },
                              title: AppStrings.qwenAI,
                              subTitle: AppStrings.qwenSub,
                              image: AppStrings.qwen,
                            ),
                            HomeTiles(
                              onTap: () {
                                model.navigate(ChatView(whichAI: AI.deepseek));
                              },
                              title: AppStrings.deepseekAI,
                              subTitle: AppStrings.deepseekSub,
                              image: AppStrings.deepseek,
                            ),
                            HomeTiles(
                              onTap: () {
                                model.navigate(ChatView(whichAI: AI.chatGPT));
                              },
                              title: AppStrings.chatGPTAI,
                              subTitle: AppStrings.chatGPTSub,
                              image: AppStrings.openAI,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
