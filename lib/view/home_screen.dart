// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../controller/app_user_controller.dart';
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
              // _buildProgressCard(width, height, context),
              SizedBox(height: height * 0.02),
              _buildCourseGrid(
                  width, height, _courseController, _progressController),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildProgressCard(double width, double height, BuildContext context) {
  //   return Consumer<AppUser>(
  //     builder: (context, myProvider, child) {
  //       if (myProvider.myCoursesList.isEmpty) {
  //         return Center(
  //           child: Text(
  //             "No courses added yet!",
  //             style: AppStyles.regular24(AppStyles.blackColor),
  //           ),
  //         );
  //       }

  //       // Add this check to ensure the list is not empty before accessing the first item
  //       if (myProvider.myCoursesList.isNotEmpty) {
  //         // Use the first course safely
  //         return GestureDetector(
  //           child: Card(
  //               // Existing code for the card...
  //               ),
  //         );
  //       }

  //       return GestureDetector(
  //         child: Card(
  //           elevation: 20,
  //           color: AppStyles.yellowColor,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(35),
  //           ),
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //                 left: width * 0.07,
  //                 top: height * 0.03,
  //                 bottom: height * 0.02),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     SizedBox(
  //                       height: 100,
  //                       width: 100,
  //                       child: Stack(
  //                         fit: StackFit.expand,
  //                         children: [
  //                           CircularProgressIndicator(
  //                             strokeCap: StrokeCap.round,
  //                             value: myProvider
  //                                 .getProgress(myProvider.myCoursesList[0].id),
  //                             strokeWidth: 20,
  //                             valueColor: AlwaysStoppedAnimation<Color>(
  //                                 AppStyles.whiteColor),
  //                             backgroundColor: AppStyles.blackColor,
  //                           ),
  //                           Center(
  //                             child: Text(
  //                                 '${myProvider.getProgress(myProvider.myCoursesList[0].id).toInt()}',
  //                                 style:
  //                                     AppStyles.bold48(AppStyles.whiteColor)),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       height: height * 0.05,
  //                       width: width * 0.25,
  //                       decoration: BoxDecoration(
  //                         color: AppStyles.indigoColor,
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: Radius.circular(35),
  //                           bottomLeft: Radius.circular(35),
  //                         ),
  //                       ),
  //                       child: Center(
  //                         child: Text("Continue",
  //                             style: AppStyles.bold12(
  //                               AppStyles.whiteColor,
  //                             )),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: height * 0.04),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           myProvider.myCoursesList[0].name,
  //                           style: AppStyles.bold32(AppStyles.blackColor),
  //                         ),
  //                         Text('Master Class',
  //                             style: AppStyles.regular32(AppStyles.blackColor)),
  //                       ],
  //                     ),
  //                     SizedBox(
  //                         height: height * 0.1,
  //                         child: Text(
  //                           'Harvard',
  //                           style: AppStyles.medium24(AppStyles.blackColor),
  //                         )),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildCourseGrid(
    double width,
    double height,
    CourseController _courseController,
    ProgressController _progressController,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * .06),

      // Ensure there's at least one item to skip

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
        itemCount: _courseController.userCourses.isEmpty
            ? 1
            : _courseController.userCourses.length + 1,

        itemBuilder: (context, index) {
          final itemCount = _courseController.userCourses.length > 1
              ? _courseController
                  .userCourses.length // Show courses and "Add Card"
              : 1; // Show only "Add Card" if no courses are available
          // If the list is empty or this is the last item, show the "Add Card"
          if (_courseController.userCourses.isEmpty ||
              index == _courseController.userCourses.length) {
            return _addCard(height, width, context, _courseController);
          }

          // Safe access for courses
          final course = _courseController.userCourses[index];
          return GestureDetector(
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
              // _progressController.progress.isNaN
              //     ? 0
              //     : _progressController.progress,
              AppStyles.courseResources[course.name]?['color'],
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
                // Spacer(),
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
        print("user add courses: ${_courseController.userCourses}");
        print(
            "=========================================================================");
        print("avalible courses: ${_courseController.availableCourses}");
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
}
