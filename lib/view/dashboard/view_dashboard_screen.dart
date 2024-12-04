import 'package:flutter/material.dart';
import '../../model/app_style.dart';

class ViewDashboardScreen extends StatelessWidget {
  const ViewDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    List<Map<String, dynamic>> softSkills = [
      {
        "title": "Presentation skills",
        "image": "",
      },
      {
        "title": "Work on a Team Master Class",
        "image": "",
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(width, height, context),
            SizedBox(height: height * 0.02),
            _buildSoftSkillsList(softSkills, width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double width, double height, BuildContext context) {
    return Container(
      width: double.infinity,
      height: height * 0.09,
      decoration: BoxDecoration(
        color: AppStyles.blueColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAppBarLeft(width, context),
          _buildAppBarRight(),
        ],
      ),
    );
  }

  Widget _buildAppBarLeft(double width, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(AppStyles.back, color: AppStyles.whiteColor),
          ),
          Text(
            "Soft Skills",
            style: AppStyles.regular32(AppStyles.blackColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarRight() {
    return Padding(
      padding: EdgeInsets.only(right: 20), // Adjusted padding for simplicity
      child: Image.asset(AppStyles.skills),
    );
  }

  Widget _buildSoftSkillsList(
      List<Map<String, dynamic>> softSkills, double width, double height) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: ListView.builder(
          itemCount: softSkills.length,
          itemBuilder: (context, index) {
            final _softSkill = softSkills[index];
            return Padding(
              padding: EdgeInsets.only(bottom: height * 0.02),
              child: _buildCoursesCard(height, width, _softSkill['title']),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCoursesCard(double height, double width, String title) {
    return Container(
      width: double.infinity,
      height: height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: AppStyles.grayColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCourseCardFooter(height, width, title),
        ],
      ),
    );
  }

  Widget _buildCourseCardFooter(double height, double width, String title) {
    return Container(
      width: double.infinity,
      height: height * 0.06,
      decoration: const BoxDecoration(
        color: AppStyles.indigoColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.04),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppStyles.medium16(AppStyles.indigoColor),
          ),
        ),
      ),
    );
  }
}
