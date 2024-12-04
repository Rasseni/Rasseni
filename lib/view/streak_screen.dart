import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/streak_controller.dart';
import '../model/app_style.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final streakProvider = Provider.of<StreakContoller>(context);
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    return Scaffold(
      appBar: _buildAppBar(context, width),
      body: _buildCarousel(streakProvider, height, width),
      backgroundColor: AppStyles.orangeColor,
    );
  }

  AppBar _buildAppBar(BuildContext context, double width) {
    return AppBar(
      title: Text(
        'Streaks',
        style: AppStyles.bold24(AppStyles.whiteColor),
      ),
      backgroundColor: AppStyles.orangeColor,
      iconTheme: IconThemeData(color: AppStyles.whiteColor),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: width * .02),
          child: const Icon(
            Icons.local_fire_department,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _buildCarousel(
      StreakContoller streakProvider, double height, double width) {
    return Center(
      child: SizedBox(
        height: height * 0.5,
        child: CarouselSlider.builder(
          itemCount: 31, // Number of items
          options: CarouselOptions(
            height: height * 0.5,
            viewportFraction: 0.6,
            onPageChanged: (index, reason) {
              streakProvider.updatePage(index);
            },
            enableInfiniteScroll: false,
            scrollPhysics: const ClampingScrollPhysics(),
          ),
          itemBuilder: (context, index, realIndex) {
            return _buildStreakContainer(streakProvider, index, height, width);
          },
        ),
      ),
    );
  }

  Widget _buildStreakContainer(
      StreakContoller streakProvider, int index, double height, double width) {
    // Fetch styles for the current container
    final containerStyle = streakProvider.getContainerStyle(index);
    final textSize = containerStyle['textSize'] as double;
    final textColor = containerStyle['textColor'] as Color;
    final iconColor = containerStyle['iconColor'] as Color;

    // Determine scale for active container
    final bool isCurrentPage = index == streakProvider.currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: width * 0.001),
      child: Transform.scale(
        scale: isCurrentPage ? 1.0 : 0.75,
        child: Container(
          height: isCurrentPage ? height * 0.4 : height * 0.3,
          width: isCurrentPage ? width * 0.7 : width * 0.6,
          decoration: BoxDecoration(
            color: AppStyles.darkOrangeColor,
            border: Border.all(color: AppStyles.whiteColor, width: 4),
            borderRadius: BorderRadius.circular(35),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeader(index, height, width),
              _buildMainContent(index, height, width),
              _buildFooter(iconColor, height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int index, double height, double width) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.02,
        top: height * 0.02,
        bottom: height * 0.02,
        right: width * 0.02,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            Text('${index + 1}', style: AppStyles.bold48(AppStyles.whiteColor)),
            SizedBox(width: width * 0.01),
            Text('December', style: AppStyles.regular24(AppStyles.whiteColor)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(int index, double height, double width) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${index + 1}', style: AppStyles.bold96(AppStyles.whiteColor)),
          // SizedBox(width: width * 0.01),
          Text("Day's\nStreak",
              style: AppStyles.regular24(AppStyles.whiteColor)),
        ],
      ),
    );
  }

  Widget _buildFooter(Color iconColor, double height, double width) {
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.05,
        top: height * 0.02,
        bottom: height * 0.01,
        right: width * 0.02,
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          AppStyles.streak,
          color: iconColor,
          size: 70,
        ),
      ),
    );
  }
}
