import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/app_style.dart';
import 'authentication/signup_proccess/auth_email.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController();
    final _onboardingProvider = Provider.of<OnboardingController>(context);

    final List<Map<String, String>> boardingPages = [
      {
        "imageUrl": "assets/images/onboarding/onboarding1.png",
        "title": "Welcome to ",
        "bluetitle": "Raseeni",
        "description":
            "The first Educational/Smart study planner mobile app in Egypt.",
        "button": "Continue"
      },
      {
        "imageUrl": "assets/images/onboarding/onboarding2.png",
        "title": "Get ",
        "bluetitle": "Ready!",
        "description":
            " Start an exceptional journey using our features that will help you become the best.",
        "button": "Continue"
      },
      {
        "imageUrl": "assets/images/logo/Rasseni-removebg-preview.png",
        "title": "",
        "bluetitle": "Enjoy!",
        "description":
            "Enjoy this app to the fullest and give us your feedback :)",
        "button": "Get Started"
      },
    ];

    _pageController.addListener(() {
      _onboardingProvider.setPage(_pageController.page!.round());
    });

    // Dimensions in logical pixels (dp)
    Size size = MediaQuery.sizeOf(context);
    double width = size.width;
    double height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: boardingPages.length,
                  controller: _pageController,
                  itemBuilder: (context, index) => Column(
                    children: [
                      pageLayout(
                        image: boardingPages[index]["imageUrl"]!,
                        title: boardingPages[index]["title"]!,
                        bluetitle: boardingPages[index]["bluetitle"] ?? "",
                        subTitle: boardingPages[index]["description"]!,
                        height: height,
                        width: width,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.09,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: height * 0.03,
                      ),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: boardingPages.length,
                        effect:
                            ExpandingDotsEffect(dotWidth: 10, dotHeight: 10),
                      ),
                    ),
                    Container(
                      width: width * 0.5,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        color: AppStyles.indigoColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.indigoColor,
                        ),
                        onPressed: () {
                          int currentPage = _onboardingProvider.currentPage;
                          currentPage == boardingPages.length - 1
                              ? Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        AuthEmail(),
                                  ),
                                )
                              : _pageController.nextPage(
                                  duration: Duration(milliseconds: 700),
                                  curve: Curves.easeInOut,
                                );
                        },
                        child: Center(
                          child: Text(
                              boardingPages[_onboardingProvider.currentPage]
                                  ["button"]!,
                              style: AppStyles.bold24(AppStyles.whiteColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageLayout({
    required String image,
    required String title,
    required String bluetitle,
    required String subTitle,
    required double height,
    required double width,
  }) {
    return Column(
      children: [
        Image.asset(
          image,
          height: height * 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppStyles.semiBold32(AppStyles.blackColor),
            ),
            Text(
              bluetitle,
              style: AppStyles.semiBold32(AppStyles.indigoColor),
            ),
          ],
        ),
        SizedBox(height: height * 0.03),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            subTitle,
            style: AppStyles.regular20(AppStyles.blackColor),
          ),
        ),
      ],
    );
  }
}
