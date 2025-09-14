import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindmesh/enums/app_theme.dart';
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
  Widget build(BuildContext settingsContext) {
    final iconBrightness = Theme.of(settingsContext).brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: iconBrightness,
        statusBarColor: kCTransparentColor,
      ),
      child: Consumer<SettingsViewModel>(
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
                        image: DecorationImage(image: AssetImage(AppStrings.dp1,), fit: BoxFit.cover),
                      ),
                      // child: Image.asset(AppStrings.dp, fit: BoxFit.cover),
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
                      subTitle: model.setThemeMessage,
                      onTap: (){
                        showModalBottomSheet(context: settingsContext, builder: (settingsContext){
                              return SizedBox(
                                height: screenHeight(context)/3.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.pickTheme,
                                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          AppStrings.pickThemeSub,
                                          style: Theme.of(context).textTheme.displaySmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 30,),
                                        SettingsTile(
                                          title: AppStrings.systemTheme,
                                          titleColor: model.currentTheme == AppThemeMode.automatic ? kCGreenColor : null,
                                          onTap: (){
                                            model.updateThemeMode(AppThemeMode.automatic);
                                          },
                                        ),
                                        SettingsTile(
                                          title: AppStrings.lightTheme,
                                          titleColor: model.currentTheme == AppThemeMode.light ? kCGreenColor : null,
                                          onTap: (){
                                            model.updateThemeMode(AppThemeMode.light);
                                          },
                                        ),
                                        SettingsTile(
                                          showDivider: false,
                                          title: AppStrings.darkTheme,
                                          titleColor: model.currentTheme == AppThemeMode.dark ? kCGreenColor : null,
                                          onTap: (){
                                            model.updateThemeMode(AppThemeMode.dark);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                        },
                        );
                      },
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
      ),
    );
  }
}
