// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/course_controller.dart';
import '../../view/home_screen.dart';
import '../../model/app_style.dart';

class Dashboardscreen extends StatelessWidget {
  final List<Map<String, dynamic>> explore = [
    {
      'title': 'Soft Skill',
      'icon': AppStyles.skills,
    },
    {
      'title': 'Project Ideas',
      'icon': AppStyles.project,
    },
    {
      'title': 'About Hardware',
      'icon': AppStyles.hardware,
    },
    {
      'title': 'Software Trends',
      'icon': AppStyles.trends,
    },
  ];

  final List<Map<String, dynamic>> codingVocab = [
    {
      'title': 'Git',
      'subtitle': 'Commandes',
      'icon': AppStyles.git,
    },
    {
      'title': 'Main',
      'subtitle': 'References',
      'icon': AppStyles.main,
    },
    {
      'title': 'Coding',
      'subtitle': 'References',
      'icon': AppStyles.coding,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    double progressPercentage = 70;
    final _courseController = Provider.of<CourseController>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(height, width),
            _buildProgressCard(
                width, height, progressPercentage, _courseController, context),
            SizedBox(height: height * 0.01),
            _buildSectionTitle("Explore", width),
            _buildExploreList(width, height),
            SizedBox(height: height * 0.03),
            _buildSectionTitle("Coding Vocab", width),
            _buildCodingVocabList(width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double height, double width) {
    return Container(
      width: double.infinity,
      height: height * .09,
      decoration: BoxDecoration(
        color: AppStyles.blueColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.3,
              height: height * 0.08,
              child: Image.asset(
                AppStyles.logoWithoutBackground,
                fit: BoxFit.cover, // Ensure it scales nicely
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                AppStyles.notificationNone,
                color: AppStyles.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(
      double width,
      double height,
      double progressPercentage,
      CourseController _courseController,
      BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Container(
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.02,
            right: width * 0.01,
            top: height * 0.03,
            bottom: height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildProgressIndicator(progressPercentage, height),
                  SizedBox(width: width * 0.1),
                  _buildProgressDetails(height, width),
                ],
              ),
              SizedBox(height: height * 0.03),
              _buildViewAllButton(width, height, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(double progressPercentage, double height) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                value: progressPercentage / 100,
                strokeWidth: 20,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppStyles.yellowColor),
                backgroundColor: AppStyles.blackColor,
              ),
              Center(
                child: Text(
                  '${progressPercentage.toInt()}',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans',
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: AppStyles.yellowColor,
                    letterSpacing: -2,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Web dev', style: AppStyles.bold20(AppStyles.blackColor)),
            Text('Master Class',
                style: AppStyles.regular20(AppStyles.blackColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressDetails(double height, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildProgressIndicatorWithColor(
            70, 71, AppStyles.indigoColor, AppStyles.blackColor, width),
        SizedBox(height: height * 0.04),
        _buildProgressIndicatorWithColor(
            20, 71, AppStyles.greenColor, AppStyles.blackColor, width),
      ],
    );
  }

  Widget _buildProgressIndicatorWithColor(
    int progressPercentage,
    double size,
    Color valueColor,
    Color backgroundColor,
    double width,
  ) {
    return Row(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                value: progressPercentage / 100,
                strokeWidth: 10,
                valueColor: AlwaysStoppedAnimation<Color>(valueColor),
                backgroundColor: backgroundColor,
              ),
              Center(
                child: Text('${progressPercentage.toInt()}',
                    style: AppStyles.bold24(valueColor)),
              ),
            ],
          ),
        ),
        SizedBox(width: width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mobile Dev", style: AppStyles.bold15(AppStyles.blackColor)),
            Text("Master Class",
                style: AppStyles.regular15(AppStyles.blackColor)),
          ],
        ),
      ],
    );
  }

  Widget _buildViewAllButton(
      double width, double height, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Homescreen(),
              ),
            );
          },
          child: Container(
            width: width * 0.5,
            height: height * 0.055,
            decoration: BoxDecoration(
              color: AppStyles.orangeColor,
              borderRadius: BorderRadius.circular(35),
            ),
            child: Center(
              child: Text("View All",
                  style: AppStyles.bold15(AppStyles.whiteColor)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, double width) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: AppStyles.light24(AppStyles.blackColor)),
      ),
    );
  }

  Widget _buildExploreList(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: SizedBox(
        width: double.infinity,
        height: height * .14,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: explore.length,
          itemBuilder: (context, index) {
            final _explore = explore[index];
            return _exploreCard(
                height, width, _explore['title'], _explore['icon'], context);
          },
        ),
      ),
    );
  }

  Widget _buildCodingVocabList(double width, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: SizedBox(
        width: double.infinity,
        height: height * .17,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: codingVocab.length,
          itemBuilder: (context, index) {
            final _codingVocab = codingVocab[index];
            return _codingVocabCard(
                context,
                height,
                width,
                _codingVocab['title'],
                _codingVocab['subtitle'],
                _codingVocab['icon']);
          },
        ),
      ),
    );
  }

  Widget _exploreCard(double height, double width, String title, String icon,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showComingSoonDialog(context);
      },
      child: Card(
        elevation: 5,
        color: AppStyles.indigoColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: SizedBox(
          height: height * 0.14,
          width: width * 0.5,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            child: Stack(
              children: [
                Align(alignment: Alignment.topLeft, child: Image.asset(icon)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(title,
                      style: AppStyles.regular16(AppStyles.whiteColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _codingVocabCard(BuildContext context, double height, double width,
      String title, String subtitle, String icon) {
    return GestureDetector(
      onTap: () {
        _showComingSoonDialog(context);
      },
      child: Card(
        elevation: 5,
        color: AppStyles.blackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: SizedBox(
          height: height * 0.14,
          width: width * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.04, vertical: height * 0.02),
            child: Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft, child: Image.asset(icon)),
                SizedBox(width: width * 0.02),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppStyles.semiBold20(AppStyles.whiteColor)),
                      Text(subtitle,
                          style: AppStyles.light20(AppStyles.whiteColor)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Coming soon',
            style: AppStyles.bold20(AppStyles.blackColor),
          ),
          content: Text(
              'We are preparing an awesome feature for you. Stay tuned.',
              textAlign: TextAlign.center,
              style: AppStyles.regular16(AppStyles.blackColor)),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Done",
                style: AppStyles.bold15(AppStyles.blackColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
