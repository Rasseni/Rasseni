import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/app_user_controller.dart';
import '../model/app_style.dart';

class AddCourseScreen extends StatelessWidget {
  const AddCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      body: Consumer<AppUser>(
        builder: (context, user, child) {
          return SafeArea(
            child: Column(
              children: [
                _buildAppBar(height, width),
                Expanded(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                          itemCount: user.theCoursesList.length,
                          itemBuilder: (context, index) {
                            return Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                color: AppStyles.maybeBlueColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35))),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.theCoursesList[index].name,
                                        style: AppStyles.semiBold24(
                                            AppStyles.whiteColor),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          size: 24,
                                          color: AppStyles.whiteColor,
                                        ),
                                        onPressed: () {
                                          user.addCourse(
                                              user.theCoursesList[index]);
                                        },
                                      )
                                    ],
                                  ),
                                ));
                          }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
}
