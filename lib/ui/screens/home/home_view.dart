import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/circle_button.dart';
import 'package:mindmesh/ui/custom_widgets/home_con.dart';
import 'package:mindmesh/ui/screens/home/home_view_model.dart';
import 'package:mindmesh/ui/screens/settings/settings_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                  top: 30,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleButton(icon: Icons.person, onTap: null),
                        CircleButton(
                          icon: Icons.menu_open_outlined,
                          onTap: () {
                            model.navigate(SettingsView.id);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppStrings.hi,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppStrings.greetings,
                      style: Theme.of(context).textTheme.displayLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        HomeCon(
                          onTap: (){},
                          maxLines: 5,
                          color: kCGreenColor,
                          icon: CupertinoIcons.chat_bubble_2,
                          height: screenHeight(context)/2.8,
                          width: screenWidth(context)/2.3,
                          text: AppStrings.engageMultipleAIs,
                        ),
                        Spacer(),
                        Column(
                          children: [
                            HomeCon(
                              onTap: (){},
                              maxLines: 2,
                              color: kCPurpleColor,
                              icon: CupertinoIcons.sparkles,
                              height: screenHeight(context)/6,
                              width: screenWidth(context)/2.3,
                              text: AppStrings.converseWithGeminiAI,
                            ),
                            SizedBox(height: (screenHeight(context)/2.8 - (screenHeight(context)/6 + screenHeight(context)/6)),),
                            HomeCon(
                              onTap: (){},
                              maxLines: 2,
                              color: kCPinkColor,
                              icon: Icons.ac_unit_outlined,
                              height: screenHeight(context)/6,
                              width: screenWidth(context)/2.3,
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
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
