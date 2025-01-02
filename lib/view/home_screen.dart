// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/course_controller.dart';
import '../controller/progress_controller.dart';
import '../model/app_style.dart';
import 'add_course_screen.dart';
import 'course_view.dart';
import 'streak_screen.dart';

// the home page
class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final _courseController = Provider.of<CourseController>(context);
    final _progressController = Provider.of<ProgressController>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(height, width),
            _buildStreakCard(width, height, context),
            SizedBox(height: height * 0.01),
            _buildScrollableContent(
                width, height, _courseController, _progressController, context),
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

  Widget _buildStreakCard(double width, double height, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => StreakScreen(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: height * .09,
          decoration: BoxDecoration(
            color: AppStyles.orangeColor,
            borderRadius: BorderRadius.circular(35),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Streak",
                    style: AppStyles.regular24(AppStyles.whiteColor)),
                Row(
                  children: [
                    Text('1', style: AppStyles.bold32(AppStyles.whiteColor)),
                    SizedBox(width: 4),
                    Icon(AppStyles.streak,
                        color: AppStyles.whiteColor, size: 35),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableContent(
    double width,
    double height,
    CourseController _courseController,
    ProgressController _progressController,
    BuildContext context,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCourseGrid(
                  width, height, _courseController, _progressController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseGrid(
    double width,
    double height,
    CourseController _courseController,
    ProgressController _progressController,
  ) {
    // Sort courses by progress in descending order
    final sortedCourses = _courseController.getSortedCourses(
        _courseController, _progressController);

    return Padding(
      padding: EdgeInsets.only(bottom: height * .06),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.85,
        ),
        // Add +1 to include the "Add Card"
        itemCount: sortedCourses.isEmpty ? 1 : sortedCourses.length + 1,
        itemBuilder: (context, index) {
          // If the list is empty or this is the last item, show the "Add Card"
          if (sortedCourses.isEmpty || index == sortedCourses.length) {
            return _addCard(height, width, context, _courseController);
          }

          // Safe access for courses
          final course = sortedCourses[index];
          return Dismissible(
            key: Key(course.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
              child: Icon(
                AppStyles.delete, // Your custom delete icon
                color: Colors.white,
                size: 30,
              ),
            ),
            confirmDismiss: (direction) async {
              // Show your custom delete dialog
              final bool? shouldDelete = await _showDeleteDialog(
                context,
                _courseController,
                course.id,
              );

              // Return true to dismiss, false to cancel, or null to keep the card swiped
              return shouldDelete;
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TheCoursesScreen(
                      courseLessons: course.content,
                      courseName: course.name,
                      courseId: course.id,
                      courseLabel: course.label,
                      icon: AppStyles.courseResources[course.name]?['image'],
                      color: AppStyles.courseResources[course.name]?['color'],
                    ),
                  ),
                );
              },
              child: _courseCard(
                height,
                width,
                course.name,
                course.label,
                AppStyles.courseResources[course.name]?['image'],
                _progressController.getCourseProgress(
                    course.id, course.content.length),
                AppStyles.courseResources[course.name]?['color'],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _courseCard(double height, double width, String title, String subtitle,
      String image, double progressPercentage, Color color) {
    return Card(
      elevation: 10,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: width * 0.04,
          top: height * 0.03,
          bottom: height * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 10,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppStyles.whiteColor),
                  ),
                  CircularProgressIndicator(
                    strokeCap: StrokeCap.round,
                    value: progressPercentage / 100,
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation(AppStyles.whiteColor),
                    backgroundColor: AppStyles.blackColor,
                  ),
                  Center(
                    child: Text('${progressPercentage.toInt()}',
                        style: AppStyles.bold20(AppStyles.whiteColor)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.25,
                      child: Text(
                        title,
                        style: AppStyles.bold15(AppStyles.whiteColor),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.2,
                      child: Text(
                        subtitle,
                        style: AppStyles.regular10(AppStyles.whiteColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.03, left: width * 0.02),
                  child: SizedBox(
                    height: height * 0.09,
                    width: width * 0.09,
                    child: Image.asset(image),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addCard(double height, double width, BuildContext context,
      CourseController _courseController) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddCourseScreen()));
      },
      child: Card(
        elevation: 10,
        color: AppStyles.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppStyles.grayColor,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 40,
                    color: AppStyles.whiteColor,
                  )),
              SizedBox(
                height: height * 0.01,
              ),
              Text('Add Course', style: AppStyles.bold15(AppStyles.grayColor)),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context,
      CourseController _courseController, String courseId) {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Delete Course 💀',
            style: AppStyles.bold20(AppStyles.blackColor),
          ),
          content: Text('Are you sure you want to delete this course?',
              textAlign: TextAlign.center,
              style: AppStyles.regular16(AppStyles.blackColor)),
          actions: [
            // "No" button
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "No",
                style: AppStyles.bold15(AppStyles.blackColor),
              ),
            ),
            // "Yes" button
            CupertinoDialogAction(
              isDefaultAction: true, // Indicate default action
              onPressed: () {
                _courseController.deleteCourse(courseId);
                Navigator.pop(context, true);
              }, // Close dialog and return true (delete)
              child: Text(
                "Yes",
                style: AppStyles.bold15(AppStyles.blackColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
