import 'package:flutter/material.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/settings_tile.dart';
import 'package:mindmesh/ui/screens/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String id = 'SettingsView';
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(child: SizedBox(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: (){
                            model.pop();
                          },
                          child: Icon(Icons.arrow_back_rounded, color: Theme.of(context).iconTheme.color, size: IconSize.homeConIconSize,)),
                      SizedBox(width: 12,),
                      Text(
                        AppStrings.settings,
                        style: Theme.of(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: screenWidth(context)/4,
                    width: screenWidth(context)/4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kCGrey400Color,
                    ),
                    child: Icon(Icons.person, color: kCGreenColor,size: 80,),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    AppStrings.randomName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8,),
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 35,),
                  SettingsTile(
                    title: AppStrings.email,
                    subTitle: AppStrings.randomMail,
                    color: kCGreenColor,
                  ),
                  SettingsTile(
                    title: AppStrings.theme,
                    subTitle: AppStrings.systemTheme,
                    onTap: (){},
                  ),
                  SettingsTile(
                    title: AppStrings.storage,
                    subTitle: AppStrings.storageLocal,
                  ),
                  SettingsTile(
                    title: AppStrings.feedBack,
                  ),
                  SettingsTile(
                    title: AppStrings.exit,
                    onTap: (){},
                  ),
                ],
              ),
            ),
          )),
        );
      }
    );
  }
}
