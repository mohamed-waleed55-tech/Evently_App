import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently/DM/onboarding_DM.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/features/events/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/colors/colors_manager.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPageIndex = 0;
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPageIndex == introScreens.length - 1;
    final bool isFirstPage = currentPageIndex == 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              margin: REdgeInsets.only(top: 8),

              child: Image.asset(ImagesManager.onLogo),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: introScreens.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItem(
                    onboardingDm: introScreens[index],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      if (isFirstPage) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.mainLayout,
                        );
                      } else {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      isFirstPage ? "Skip" : "Back",
                      style: TextStyle(
                        color: ColorsManager.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// Dots
                  DotsIndicator(
                    dotsCount: introScreens.length,
                    position: currentPageIndex.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: ColorsManager.blue,
                      color: Colors.grey.shade300,
                      size: const Size.square(9),
                      activeSize: const Size(18, 9),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  /// Next / Finish
                  TextButton(
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.mainLayout,
                        );
                      } else {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      isLastPage ? "Finish" : "Next",
                      style: const TextStyle(
                        color: ColorsManager.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}