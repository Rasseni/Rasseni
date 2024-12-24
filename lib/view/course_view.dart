import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/progress_controller.dart';
import '../model/course_item_model.dart';
import '../model/app_style.dart';
import 'lesson_player_screen.dart';

class TheCoursesScreen extends StatelessWidget {
  final List<CourseItem> courseLessons;
  final String courseId;
  final String courseName;
  final String courseLabel;
  final String icon;
  final Color color;

  const TheCoursesScreen({
    super.key,
    required this.courseLessons,
    required this.courseName,
    required this.courseId,
    required this.courseLabel,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final _progressController = Provider.of<ProgressController>(context);

    // Initialize progress controller with lesson count
    _progressController.initializeSteps(courseId, courseLessons.length);

    // Load progress if needed
    _progressController.loadProgress();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(width, height, context),
            _buildProgressIndicator(height, _progressController),
            Expanded(
              child: _buildLessonsList(
                  _progressController, context, height, width),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(double width, double height, BuildContext context) {
    return Container(
      height: height * 0.1,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(AppStyles.back, color: AppStyles.whiteColor),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.007),
                  Text(courseName,
                      style: AppStyles.semiBold24(AppStyles.whiteColor)),
                  SizedBox(
                    width: width * 0.6,
                    height: height * 0.03,
                    child: Text(
                      courseLabel,
                      style: AppStyles.regular16(AppStyles.whiteColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.05),
            child: Image.asset(icon, width: width * 0.12),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(
      double height, ProgressController _progressController) {
    return LinearProgressIndicator(
      color: AppStyles.greenColor,
      backgroundColor: AppStyles.grayColor,
      value: _progressController.getCourseProgress(
              courseId, courseLessons.length) /
          100,
      minHeight: height * 0.045,
    );
  }

  Widget _buildLessonsList(ProgressController _progressController,
      BuildContext context, double height, double width) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stepper(
            physics: ClampingScrollPhysics(),
            currentStep: _progressController.currentSteps[courseId] ?? 0,
            controlsBuilder: (context, details) => const SizedBox.shrink(),
            steps: List.generate(
                courseLessons.length,
                (index) =>
                    _buildStep(index, _progressController, context, height)),
          ),
        ],
      ),
    );
  }

  Step _buildStep(int index, ProgressController _progressController,
      BuildContext context, double height) {
    final isAccessible =
        _progressController.isLessonAccessible(courseId, index);
    final isCompleted =
        _progressController.courseProgress[courseId]?[index] ?? false;

    return Step(
      title: GestureDetector(
        onTap: () {
          if (isAccessible) {
            _navigateToLesson(context, index);
          } else {
            _showLockedLessonDialog(context);
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 16.0),
          padding: EdgeInsets.only(left: 16.0),
          width: double.infinity,
          height: height * 0.15,
          decoration: BoxDecoration(
            color: isCompleted
                ? AppStyles.greenColor // Completed lessons
                : isAccessible
                    ? AppStyles.blueColor // Accessible but not completed
                    : AppStyles.grayColor, // Locked lessons
            borderRadius: BorderRadius.circular(35),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              courseLessons[index].title,
              style: AppStyles.regular14(AppStyles.whiteColor),
            ),
          ),
        ),
      ),
      content: Container(),
      isActive: (_progressController.currentSteps[courseId] ?? -1) >= index,
      state: isCompleted ? StepState.complete : StepState.indexed,
    );
  }

  void _navigateToLesson(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LessonPlayerScreen(
          videoUrl: courseLessons[index].url,
          title: courseLessons[index].title,
          itemId: courseLessons[index].id,
          courseId: courseId,
          courseLessons: courseLessons,
        ),
      ),
    );
  }

  void _showLockedLessonDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            'Lesson Locked',
            style: AppStyles.bold20(AppStyles.blackColor),
          ),
          content: Text(
              "You need to complete the previous lesson to unlock this one.",
              textAlign: TextAlign.center,
              style: AppStyles.regular16(AppStyles.blackColor)),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Ok",
                style: AppStyles.bold15(AppStyles.blackColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
