import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/course_controller.dart';
import '../../controller/progress_controller.dart';
import '../../view/home_screen.dart';
import '../../model/app_style.dart';

class Dashboardscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final _courseController = Provider.of<CourseController>(context);
    final _progressController = Provider.of<ProgressController>(context);

    // Get the top 3 courses with the highest progress
    final topCourses = _progressController.getTopCourses(
        _courseController, _progressController);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(height, width),
            _buildProgressCard(width, height, topCourses, context),
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

  Widget _buildProgressCard(double width, double height,
      List<Map<String, dynamic>> topCourses, BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side: Highest progress course
                  if (topCourses.isNotEmpty)
                    _buildMainCourseCard(topCourses[0], width, height),
                  // SizedBox(width: width * 0.1),

                  // Right side: Second and third highest courses
                  if (topCourses.length > 1)
                    Column(
                      children: [
                        _buildSecondaryCourseCard(topCourses[1], width, height),
                        SizedBox(height: height * 0.02),
                        if (topCourses.length > 2)
                          _buildSecondaryCourseCard(
                              topCourses[2], width, height),
                      ],
                    ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 0.45,
                    child: Text(
                        'You have ${topCourses.length}\ncourses running now.',
                        style: AppStyles.bold18(AppStyles.blackColor)),
                  ),
                  _buildViewAllButton(width, height, context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCourseCard(
      Map<String, dynamic> course, double width, double height) {
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
                value: course['progress'] / 100,
                strokeWidth: 20,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppStyles.courseResources[course['title']]?['color'],
                ),
                backgroundColor: AppStyles.blackColor,
              ),
              Center(
                child: Text(
                  '${course['progress'].toInt()}',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans',
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    color: AppStyles.courseResources[course['title']]?['color'],
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
            SizedBox(
              width: width * 0.3,
              child: Text(
                course['title'],
                style: AppStyles.bold24(AppStyles.blackColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: width * 0.3,
              child: Text(
                course['subtitle'],
                style: AppStyles.regular20(AppStyles.blackColor),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondaryCourseCard(
      Map<String, dynamic> course, double width, double height) {
    return Padding(
      padding: EdgeInsets.only(right: width * 0.05, bottom: height * 0.02),
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  value: course['progress'] / 100,
                  strokeWidth: 15,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppStyles.courseResources[course['title']]?['color'],
                  ),
                  backgroundColor: AppStyles.blackColor,
                ),
                Center(
                  child: Text(
                    '${course['progress'].toInt()}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: AppStyles.courseResources[course['title']]
                          ?['color'],
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.2,
                child: Text(course['title'],
                    style: AppStyles.semiBold16(AppStyles.blackColor)),
              ),
              SizedBox(
                width: width * 0.2,
                child: Text(
                  course['subtitle'],
                  style: AppStyles.regular14(AppStyles.blackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
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
            width: width * 0.45,
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
                fit: BoxFit.cover,
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
    final List<Map<String, dynamic>> explore = [
      {'title': 'Soft Skill', 'icon': AppStyles.skills},
      {'title': 'Project Ideas', 'icon': AppStyles.project},
      {'title': 'About Hardware', 'icon': AppStyles.hardware},
      {'title': 'Software Trends', 'icon': AppStyles.trends},
    ];

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
    final List<Map<String, dynamic>> codingVocab = [
      {'title': 'Git', 'subtitle': 'Commandes', 'icon': AppStyles.git},
      {'title': 'Main', 'subtitle': 'References', 'icon': AppStyles.main},
      {'title': 'Coding', 'subtitle': 'References', 'icon': AppStyles.coding},
    ];

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
