import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmesh/ui/common/strings.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';
import 'package:mindmesh/ui/custom_widgets/mindmesh_button.dart';
import 'package:mindmesh/ui/screens/home/home_view.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  static const String id = 'OnboardingView';

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(
            child: SizedBox(
              height: screenHeight(context),
              width: screenWidth(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          model.updateActiveIndex(value);
                        },
                        itemCount: model.onboardingFeed.length,
                        itemBuilder: (_, index) {
                          final feed = model.onboardingFeed[index];
                          return Column(
                            children: [
                              Expanded(child: SvgPicture.asset(feed.image, fit: BoxFit.contain, height: screenHeight(context)/2.3, color: Colors.green,)),
                              SizedBox(height: 8),
                              Text(
                                feed.title,
                                style: Theme.of(context).textTheme.displayLarge,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                feed.subtitle,
                                style: Theme.of(context).textTheme.displaySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 15),
                            ],
                          );
                        },
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: model.activeIndex,
                      count: model.onboardingFeed.length,
                      effect: ExpandingDotsEffect(
                        dotColor: kCGrey400Color,
                        activeDotColor: kCGreenColor,
                        dotWidth: 7,
                        dotHeight: 7,
                        expansionFactor: 2,
                      ),
                      onDotClicked: (index) {},
                    ),
                    SizedBox(height: 30),
                    MindmeshButton(
                      text: AppStrings.getStarted,
                      buttonWidth: screenWidth(context) / 2,
                      onTap: () {
                        model.navigate(HomeView.id);
                      },
                    ),
                    SizedBox(height: 30),
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
