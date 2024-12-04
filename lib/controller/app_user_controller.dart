import 'package:flutter/material.dart';
import 'online_data_controller.dart';

import '../model/courses_model.dart';

class AppUser extends ChangeNotifier {
  List<CoursesModel> theCoursesList = [];
  List<CoursesModel> myCoursesList = [];
  bool _isLoading = false;
  Map<String, Set<String>> courseProgress =
      {}; // Track progress by courseId and itemId

  AppUser() {
    _loadData();
    for (var element in theCoursesList) {
      if (element.name == 'CS50') {
        print(element);
        addCourse(element);
      }
    }
    notifyListeners();
  }

  void _filterLoadedCourses() {
    theCoursesList.removeWhere(
        (item) => myCoursesList.any((myItem) => myItem.name == item.name));
  }

  void addCourse(CoursesModel theCourse) {
    myCoursesList.add(theCourse);
    theCoursesList.removeWhere((item) => item.name == theCourse.name);
    notifyListeners();
  }

  void removeCourse(CoursesModel theCourse) {
    theCoursesList.add(theCourse);
    myCoursesList.removeWhere((item) => item.name == theCourse.name);
    notifyListeners();
  }

  Future<void> _loadData() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final courses = await OnlineData().theCoursesList();
      if (courses != null) {
        theCoursesList = courses;
        _filterLoadedCourses();
        notifyListeners();
      }
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      _isLoading = false;
    }
  }

  // Update progress for a course item (completed or not)
  void updateProgress(String courseId, String itemId, bool isCompleted) {
    if (!courseProgress.containsKey(courseId)) {
      courseProgress[courseId] = {};
    }

    if (isCompleted) {
      courseProgress[courseId]?.add(itemId);
    } else {
      courseProgress[courseId]?.remove(itemId);
    }
    notifyListeners();
  }

  bool isItemCompleted(String courseId, String itemId) {
    return courseProgress[courseId]?.contains(itemId) ?? false;
  }

  double getProgress(String courseId) {
    final completedItems = courseProgress[courseId]?.length ?? 0;
    final totalItems = myCoursesList
            .firstWhere((course) => course.id == courseId)
            .content
            .length ??
        0;
    return totalItems > 0 ? completedItems / totalItems : 0.0;
  }

  Map<String, List<CoursesModel>> getCoursesByLabel() {
    Map<String, List<CoursesModel>> coursesByLabel = {};
    for (var course in theCoursesList) {
      if (!coursesByLabel.containsKey(course.label)) {
        coursesByLabel[course.label] = [];
      }
      coursesByLabel[course.label]!.add(course);
    }
    return coursesByLabel;
  }
}
